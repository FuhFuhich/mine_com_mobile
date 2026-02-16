import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/minecraft_server_model.dart';
import '../../../model/server_log_model.dart';
import '../../../provider/server_logs_provider.dart';

class ServerLogsFragment extends ConsumerStatefulWidget {
  final MinecraftServerModel server;

  const ServerLogsFragment({super.key, required this.server});

  @override
  ConsumerState<ServerLogsFragment> createState() => _ServerLogsFragmentState();
}

class _ServerLogsFragmentState extends ConsumerState<ServerLogsFragment> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  
  Set<LogLevel> _selectedLevels = LogLevel.values.toSet();
  String _searchQuery = '';
  bool _autoScroll = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  List<ServerLogEntry> _filterLogs(List<ServerLogEntry> logs) {
    return logs.where((log) {
      final levelMatch = _selectedLevels.contains(log.level);
      final searchMatch = _searchQuery.isEmpty ||
          log.message.toLowerCase().contains(_searchQuery) ||
          (log.source?.toLowerCase().contains(_searchQuery) ?? false);
      return levelMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // -----------------------------------------------------------------------------------------------------------------------
    // Данные из бд
    // -----------------------------------------------------------------------------------------------------------------------

    final serverName = widget.server.name;
    final allLogs = ref.watch(serverLogsProvider(serverName));
    final filteredLogs = _filterLogs(allLogs);
    final totalLogsCount = allLogs.length;
    final filteredLogsCount = filteredLogs.length;

    // -----------------------------------------------------------------------------------------------------------------------
    // Данные из бд
    // -----------------------------------------------------------------------------------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: Text('$serverName - Логи'),
        actions: [
          IconButton(
            icon: Icon(_autoScroll ? Icons.arrow_downward : Icons.arrow_downward_outlined),
            onPressed: () {
              setState(() {
                _autoScroll = !_autoScroll;
              });
              if (_autoScroll) _scrollToBottom();
            },
            tooltip: _autoScroll ? 'Автопрокрутка включена' : 'Автопрокрутка выключена',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(serverLogsProvider(serverName).notifier).refresh();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Логи обновлены'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            tooltip: 'Обновить',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear') {
                ref.read(serverLogsProvider(serverName).notifier).clearLogs();
              } else if (value == 'export') {
                _showExportDialog(context, allLogs);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.clear_all, size: 20),
                    SizedBox(width: 12),
                    Text('Очистить логи'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.download, size: 20),
                    SizedBox(width: 12),
                    Text('Экспортировать'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(theme),
          _buildFilterChips(theme),
          _buildLogsInfo(theme, filteredLogsCount, totalLogsCount),
          Expanded(
            child: _buildLogsList(theme, filteredLogs),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(
          bottom: BorderSide(color: theme.dividerColor),
        ),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Поиск в логах...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildFilterChips(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(
          bottom: BorderSide(color: theme.dividerColor),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: LogLevel.values.map((level) {
            final isSelected = _selectedLevels.contains(level);
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                selected: isSelected,
                label: Text(_getLevelName(level)),
                avatar: Icon(
                  _getLevelIcon(level),
                  size: 16,
                  color: isSelected ? Colors.white : _getLevelColor(level),
                ),
                selectedColor: _getLevelColor(level),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedLevels.add(level);
                    } else {
                      _selectedLevels.remove(level);
                    }
                  });
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLogsInfo(ThemeData theme, int filtered, int total) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.5),
        border: Border(
          bottom: BorderSide(color: theme.dividerColor),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            'Показано $filtered из $total записей',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildLogsList(ThemeData theme, List<ServerLogEntry> logs) {
    if (logs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Ничего не найдено'
                  : 'Нет логов для отображения',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_autoScroll && _scrollController.hasClients) {
        _scrollToBottom();
      }
    });

    return Container(
      color: const Color(0xFF1E1E1E),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];

          // Данные записи лога
          final logTime = log.formattedTime;
          final logLevel = log.level;
          final logSource = log.source;
          final logMessage = log.message;
          final logTimestamp = log.timestamp;
          
          return _buildLogEntry(
            theme,
            logTime,
            logLevel,
            logSource,
            logMessage,
            logTimestamp,
          );
        },
      ),
    );
  }

  Widget _buildLogEntry(
    ThemeData theme,
    String formattedTime,
    LogLevel level,
    String? source,
    String message,
    DateTime timestamp,
  ) {
    final levelColor = _getLevelColor(level);

    return InkWell(
      onLongPress: () => _showLogDetails(
        context,
        formattedTime,
        level,
        source,
        message,
        timestamp,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
          border: Border(
            left: BorderSide(color: levelColor, width: 3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: levelColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    formattedTime,
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: levelColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  _getLevelIcon(level),
                  size: 14,
                  color: levelColor,
                ),
                const SizedBox(width: 4),
                Text(
                  _getLevelName(level).toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: levelColor,
                  ),
                ),
                if (source != null) ...[
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      '[$source]',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        fontFamily: 'monospace',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'monospace',
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogDetails(
    BuildContext context,
    String formattedTime,
    LogLevel level,
    String? source,
    String message,
    DateTime timestamp,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(_getLevelIcon(level), color: _getLevelColor(level)),
            const SizedBox(width: 8),
            Text(_getLevelName(level).toUpperCase()),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Время', timestamp.toString()),
              if (source != null) _buildDetailRow('Источник', source),
              const SizedBox(height: 12),
              const Text(
                'Сообщение:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SelectableText(
                message,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: message));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Скопировано в буфер обмена')),
              );
            },
            icon: const Icon(Icons.copy),
            label: const Text('Копировать'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context, List<ServerLogEntry> logs) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Экспорт логов'),
        content: const Text(
          'Функция экспорта будет реализована позже.\n\n'
          'Будет доступен экспорт в форматы:\n'
          '• TXT\n'
          '• JSON\n'
          '• CSV',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Понятно'),
          ),
        ],
      ),
    );
  }

  String _getLevelName(LogLevel level) {
    switch (level) {
      case LogLevel.info:
        return 'Info';
      case LogLevel.warn:
        return 'Warn';
      case LogLevel.error:
        return 'Error';
      case LogLevel.debug:
        return 'Debug';
      case LogLevel.fatal:
        return 'Fatal';
    }
  }

  IconData _getLevelIcon(LogLevel level) {
    switch (level) {
      case LogLevel.info:
        return Icons.info_outline;
      case LogLevel.warn:
        return Icons.warning_amber;
      case LogLevel.error:
        return Icons.error_outline;
      case LogLevel.debug:
        return Icons.bug_report;
      case LogLevel.fatal:
        return Icons.dangerous;
    }
  }

  Color _getLevelColor(LogLevel level) {
    switch (level) {
      case LogLevel.info:
        return Colors.blue;
      case LogLevel.warn:
        return Colors.orange;
      case LogLevel.error:
        return Colors.red;
      case LogLevel.debug:
        return Colors.purple;
      case LogLevel.fatal:
        return Colors.red.shade900;
    }
  }
}
