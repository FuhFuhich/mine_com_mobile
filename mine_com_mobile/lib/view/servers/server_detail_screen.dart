import 'package:flutter/material.dart';
import '../../model/minecraft_server_model.dart';
import '../../model/linux_server_model.dart';
import 'build fragments/metrics_fragment.dart';
import 'build fragments/linux_console_fragment.dart';
import 'build fragments/server_logs_fragment.dart';

class ServerDetailScreen extends StatefulWidget {
  final MinecraftServerModel server;

  const ServerDetailScreen({super.key, required this.server});

  @override
  State<ServerDetailScreen> createState() => _ServerDetailScreenState();
}

class _ServerDetailScreenState extends State<ServerDetailScreen> {
  late MinecraftServerModel _server;

  @override
  void initState() {
    super.initState();
    _server = widget.server;
  }

  void _handleAction(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action: ${_server.name}'),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // -----------------------------------------------------------------------------------------------------------------------
    // Данные из бд
    // -----------------------------------------------------------------------------------------------------------------------

    final serverName = _server.name;
    final serverStatus = 'Онлайн';
    final minecraftVersion = '1.20.1';
    final modLoader = 'Forge';
    final activePlayers = 12;
    final allocatedCores = 4;
    final allocatedRam = 8;
    final cpuUsage = 45.5;
    final memoryUsage = 65.3;
    
    // SSH данные для консоли
    final sshHost = '95.165.27.159';
    final sshPort = 22;
    final sshUsername = 'sha';
    final sshPassword = 'sharoot';

    // -----------------------------------------------------------------------------------------------------------------------
    // Данные из бд
    // -----------------------------------------------------------------------------------------------------------------------
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          serverName,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatusCard(context, serverStatus),
            const SizedBox(height: 20),

            _buildInfoSection(
              context,
              minecraftVersion,
              modLoader,
              activePlayers,
              allocatedCores,
              allocatedRam,
            ),
            const SizedBox(height: 20),

            _buildMetricsPreview(context, cpuUsage, memoryUsage),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  context,
                  icon: Icons.play_arrow,
                  label: 'Запуск',
                  onPressed: () => _handleAction('Запуск'),
                ),
                _buildControlButton(
                  context,
                  icon: Icons.stop,
                  label: 'Стоп',
                  onPressed: () => _handleAction('Остановка'),
                  isDanger: true,
                ),
                _buildControlButton(
                  context,
                  icon: Icons.refresh,
                  label: 'Перезагрузка',
                  onPressed: () => _handleAction('Перезагрузка'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildMetricsButton(context),
            const SizedBox(height: 12),
            _buildConsoleButton(
              context,
              serverName,
              sshHost,
              sshPort,
              sshUsername,
              sshPassword,
            ),
            const SizedBox(height: 12),
            _buildLogsButton(context),
            const SizedBox(height: 12),
            _buildBackupButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, String status) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;
    
    final isOnline = status == 'Онлайн';
    final statusColor = isOnline ? cs.primary : cs.error;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(
            isOnline ? Icons.cloud_done : Icons.cloud_off,
            color: statusColor,
            size: 40,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Статус сервера',
                style: tt.bodySmall?.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: tt.titleLarge?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String version,
    String modLoader,
    int players,
    int cores,
    int ram,
  ) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;

    final items = [
      ('Версия Minecraft', version),
      ('Mod Loader', modLoader),
      ('Активные игроки', '$players'),
      ('Выделенные ядра', '$cores ядер'),
      ('Выделённая ОП', '$ram GB'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Информация о сервере',
            style: tt.titleLarge,
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.$1,
                  style: tt.bodyMedium?.copyWith(fontSize: 14),
                ),
                Text(
                  item.$2,
                  style: tt.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildMetricsPreview(BuildContext context, double cpu, double memory) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Текущие метрики',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildMetricRow(context, 'CPU', cpu),
          const SizedBox(height: 12),
          _buildMetricRow(context, 'Оперативная память', memory),
        ],
      ),
    );
  }

  Widget _buildMetricRow(BuildContext context, String label, double value) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final isHighUsage = value > 80;
    final progressColor = isHighUsage ? cs.error : cs.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: tt.bodySmall?.copyWith(fontSize: 12),
            ),
            Text(
              '${value.toStringAsFixed(1)}%',
              style: tt.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 6,
            backgroundColor: theme.dividerColor,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isDanger = false,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;
    
    final buttonColor = isDanger ? cs.error : cs.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: buttonColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: buttonColor, size: 24),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: tt.bodySmall?.copyWith(fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildMetricsButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MetricsFragment(server: _server),
          ),
        );
      },
      icon: const Icon(Icons.show_chart),
      label: const Text('Подробные метрики'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildConsoleButton(
    BuildContext context,
    String serverName,
    String host,
    int port,
    String username,
    String password,
  ) {
    return ElevatedButton.icon(
      onPressed: () {
        final linuxServer = LinuxServerModel(
          id: '1',
          name: serverName,
          host: host,
          port: port,
          username: username,
          password: password,
        );
        
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => LinuxConsoleFragment(server: linuxServer),
          ),
        );
      },
      icon: const Icon(Icons.terminal),
      label: const Text('Консоль Linux'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildLogsButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ServerLogsFragment(server: _server),
          ),
        );
      },
      icon: const Icon(Icons.history),
      label: const Text('Логи сервера'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildBackupButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Бэкап будет реализован позже'),
            duration: Duration(milliseconds: 800),
          ),
        );
      },
      icon: const Icon(Icons.backup),
      label: const Text('Создание бэкапа сервера'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
