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
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        title: Text(
          _server.name,
          style: const TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // СТАТУС КАРТОЧКА
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF222222),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF404040)),
              ),
              child: Row(
                children: [
                  Icon(
                    _server.status == 'Онлайн'
                        ? Icons.cloud_done
                        : Icons.cloud_off,
                    color: _server.status == 'Онлайн'
                        ? const Color(0xFF00E676)
                        : Colors.redAccent,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Статус сервера',
                        style: TextStyle(
                          color: Color(0xFFBBBBBB),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _server.status,
                        style: TextStyle(
                          color: _server.status == 'Онлайн'
                              ? const Color(0xFF00E676)
                              : Colors.redAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ИНФОРМАЦИЯ О СЕРВЕРЕ
            _buildInfoSection(
              title: 'Информация о сервере',
              items: [
                ('Версия Minecraft', _server.version),
                ('Mod Loader', _server.modLoader),
                ('Активные игроки', '${_server.players}'),
                ('Выделенные ядра', '${_server.allocatedCores} ядер'),
                ('Выделённая ОП', '${_server.allocatedRam} GB'),
              ],
            ),
            const SizedBox(height: 20),

            // ТЕКУЩИЕ МЕТРИКИ
            _buildMetricsPreview(),
            const SizedBox(height: 20),

            // КНОПКИ УПРАВЛЕНИЯ
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  icon: Icons.play_arrow,
                  label: 'Запуск',
                  color: const Color(0xFF00E676),
                  onPressed: () => _handleAction('Запуск'),
                ),
                _buildControlButton(
                  icon: Icons.stop,
                  label: 'Стоп',
                  color: Colors.redAccent,
                  onPressed: () => _handleAction('Остановка'),
                ),
                _buildControlButton(
                  icon: Icons.refresh,
                  label: 'Перезагрузка',
                  color: const Color(0xFF2196F3),
                  onPressed: () => _handleAction('Перезагрузка'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // КНОПКИ НАВИГАЦИИ
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MetricsFragment(server: _server),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E676),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.show_chart, color: Colors.white),
              label: const Text(
                'Подробные метрики',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('CMD будет реализован позже'),
                    duration: Duration(milliseconds: 800),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.terminal, color: Colors.white),
              label: const Text(
                'Консоль Linux (скоро)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<(String, String)> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF404040)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.$1,
                    style: const TextStyle(
                      color: Color(0xFFBBBBBB),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    item.$2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMetricsPreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF404040)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Текущие метрики',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildMetricRow('CPU', _server.cpuUsage),
          const SizedBox(height: 12),
          _buildMetricRow('Оперативная память', _server.memoryUsage),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFBBBBBB),
                fontSize: 12,
              ),
            ),
            Text(
              '${value.toStringAsFixed(1)}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
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
            backgroundColor: const Color(0xFF404040),
            valueColor: AlwaysStoppedAnimation<Color>(
              value > 80 ? Colors.redAccent : const Color(0xFF00E676),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFBBBBBB),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
