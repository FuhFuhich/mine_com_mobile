import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/minecraft_server_model.dart';
import '../../provider/minecraft_server_provider.dart';
import 'server_detail_screen.dart';

class ServerListWrapper extends ConsumerWidget {
  const ServerListWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servers = ref.watch(serverListProvider);
    final serverNotifier = ref.read(serverListProvider.notifier);

    void handleServerAction(String action, int index) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$action: ${servers[index].name}'),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }

    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Серверы'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // TODO: Обновить список серверов
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Обновление списка серверов'),
                  duration: Duration(milliseconds: 800),
                ),
              );
            },
            tooltip: 'Обновить',
          ),
        ],
      ),
      body: servers.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.dns_outlined,
                    size: 64,
                    color: cs.primary.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Нет серверов',
                    style: tt.titleMedium?.copyWith(
                      color: tt.bodySmall?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Добавьте новый сервер',
                    style: tt.bodySmall,
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: servers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final server = servers[index];
                
                // Данные "из базы данных" (в будущем будут парситься реально)
                final serverName = server.name;
                final serverStatus = server.status;
                final serverPlayers = server.players;
                final serverVersion = server.version;
                final cpuUsage = server.cpuUsage;
                final memoryUsage = server.memoryUsage;
                
                final isOnline = serverStatus == 'Онлайн';
                final statusColor = isOnline ? cs.primary : cs.error;

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ServerDetailScreen(server: server),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isOnline
                            ? cs.primary.withOpacity(0.3)
                            : theme.dividerColor,
                        width: isOnline ? 1.5 : 1,
                      ),
                      boxShadow: [
                        if (isOnline)
                          BoxShadow(
                            color: cs.primary.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Иконка статуса
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      isOnline ? Icons.dns : Icons.dns_outlined,
                                      color: statusColor,
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  
                                  // Информация о сервере
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                serverName,
                                                style: tt.titleMedium?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            // Чип статуса
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: statusColor.withOpacity(0.15),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: 6,
                                                    height: 6,
                                                    decoration: BoxDecoration(
                                                      color: statusColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    serverStatus,
                                                    style: tt.bodySmall?.copyWith(
                                                      color: statusColor,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.people_outline,
                                              size: 14,
                                              color: tt.bodySmall?.color,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '$serverPlayers игроков',
                                              style: tt.bodySmall,
                                            ),
                                            const SizedBox(width: 12),
                                            Icon(
                                              Icons.grid_view,
                                              size: 14,
                                              color: tt.bodySmall?.color,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              serverVersion,
                                              style: tt.bodySmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              // Метрики (если сервер онлайн)
                              if (isOnline) ...[
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildMetricBar(
                                        theme,
                                        'CPU',
                                        cpuUsage,
                                        Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildMetricBar(
                                        theme,
                                        'RAM',
                                        memoryUsage,
                                        Colors.purple,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        
                        // Разделитель
                        Divider(height: 1, color: theme.dividerColor),
                        
                        // Кнопки управления
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActionButton(
                                context,
                                icon: Icons.play_arrow,
                                label: 'Запуск',
                                color: Colors.green,
                                onPressed: () =>
                                    handleServerAction('Запуск', index),
                              ),
                              _buildActionButton(
                                context,
                                icon: Icons.stop,
                                label: 'Стоп',
                                color: Colors.red,
                                onPressed: () =>
                                    handleServerAction('Остановка', index),
                              ),
                              _buildActionButton(
                                context,
                                icon: Icons.refresh,
                                label: 'Рестарт',
                                color: Colors.orange,
                                onPressed: () =>
                                    handleServerAction('Перезагрузка', index),
                              ),
                              _buildActionButton(
                                context,
                                icon: Icons.info_outline,
                                label: 'Инфо',
                                color: cs.primary,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ServerDetailScreen(server: server),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildMetricBar(
    ThemeData theme,
    String label,
    double value,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${value.toStringAsFixed(0)}%',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 5,
            backgroundColor: theme.dividerColor,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: tt.bodySmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
