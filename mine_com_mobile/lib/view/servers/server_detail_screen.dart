import 'package:flutter/material.dart';
import '../../model/server_model.dart';
import 'metrics_fragment.dart';

class ServerDetailScreen extends StatefulWidget {
  final ServerModel server;

  const ServerDetailScreen({super.key, required this.server});

  @override
  State<ServerDetailScreen> createState() => _ServerDetailScreenState();
}

class _ServerDetailScreenState extends State<ServerDetailScreen> {
  late ServerModel _server;

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
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _server.name,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatusCard(context),
            const SizedBox(height: 20),

            _buildInfoSection(context),
            const SizedBox(height: 20),

            _buildMetricsPreview(context),
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
            _buildConsoleButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;
    
    final isOnline = _server.status == 'Онлайн';
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
                _server.status,
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

  Widget _buildInfoSection(BuildContext context) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;
    final cs = theme.colorScheme;

    final items = [
      ('Версия Minecraft', _server.version),
      ('Mod Loader', _server.modLoader),
      ('Активные игроки', '${_server.players}'),
      ('Выделенные ядра', '${_server.allocatedCores} ядер'),
      ('Выделённая ОП', '${_server.allocatedRam} GB'),
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

  Widget _buildMetricsPreview(BuildContext context) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;

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
          _buildMetricRow(context, 'CPU', _server.cpuUsage),
          const SizedBox(height: 12),
          _buildMetricRow(context, 'Оперативная память', _server.memoryUsage),
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

  Widget _buildConsoleButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('CMD будет реализован позже'),
            duration: Duration(milliseconds: 800),
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
}
