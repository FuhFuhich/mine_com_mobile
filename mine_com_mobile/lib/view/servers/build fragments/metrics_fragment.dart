import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../model/minecraft_server_model.dart';

class MetricsFragment extends StatefulWidget {
  final MinecraftServerModel server;

  const MetricsFragment({super.key, required this.server});

  @override
  State<MetricsFragment> createState() => _MetricsFragmentState();
}

class _MetricsFragmentState extends State<MetricsFragment> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    
    // -----------------------------------------------------------------------------------------------------------------------
    // Данные из бд
    // -----------------------------------------------------------------------------------------------------------------------

    final serverName = widget.server.name;
    
    // Исторические данные метрик
    final List<double> cpuData = [10, 20, 35, 45, 50, 48, 52, 60, 55, 50];
    final List<double> ramData = [30, 40, 50, 60, 65, 62, 68, 72, 70, 68];
    
    // Текущие значения
    final currentCpu = 50.0;
    final currentRam = 68.0;
    
    // Статистика (средние и максимальные значения)
    final avgCpu = 42.5;
    final avgRam = 58.5;
    final maxCpu = 60.0;
    final maxRam = 72.0;

    // -----------------------------------------------------------------------------------------------------------------------
    // Данные из бд
    // -----------------------------------------------------------------------------------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: Text('$serverName - Метрики'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildTab(context, 'CPU', 0),
                _buildTab(context, 'Память', 1),
                _buildTab(context, 'Обзор', 2),
              ],
            ),
            const SizedBox(height: 20),
            if (_selectedTab == 0) _buildCpuChart(context, cpuData),
            if (_selectedTab == 1) _buildRamChart(context, ramData),
            if (_selectedTab == 2) _buildOverview(context, currentCpu, currentRam),
            const SizedBox(height: 20),
            _buildStatsCard(context, avgCpu, avgRam, maxCpu, maxRam),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, String label, int index) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final isSelected = _selectedTab == index;

    final selectedTextColor = cs.primary;
    final unselectedTextColor = cs.onSurface.withOpacity(0.70);

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? cs.primary.withOpacity(0.16) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: (tt.bodyMedium ?? const TextStyle()).copyWith(
                color: isSelected ? selectedTextColor : unselectedTextColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCpuChart(BuildContext context, List<double> cpuData) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final gridColor = cs.onSurface.withOpacity(0.18);
    final borderColor = cs.outline.withOpacity(0.50);
    final labelColor = cs.onSurface.withOpacity(0.70);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Нагрузка CPU (последние 10 измерений)',
          style: tt.titleSmall,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 20,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: gridColor,
                    strokeWidth: 0.5,
                  ),
                  getDrawingVerticalLine: (_) => FlLine(
                    color: gridColor,
                    strokeWidth: 0.5,
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toInt()}',
                        style: (tt.bodySmall ?? const TextStyle()).copyWith(
                          color: labelColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toInt()}%',
                        style: (tt.bodySmall ?? const TextStyle()).copyWith(
                          color: labelColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: borderColor,
                    width: 1,
                  ),
                ),
                minX: 0,
                maxX: 9,
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: cpuData
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value))
                        .toList(),
                    isCurved: true,
                    color: cs.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) {
                        return FlDotCirclePainter(
                          radius: 2.6,
                          color: cs.primary,
                          strokeWidth: 1,
                          strokeColor: cs.surface,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: cs.primary.withOpacity(0.12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRamChart(BuildContext context, List<double> ramData) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final gridColor = cs.onSurface.withOpacity(0.18);
    final borderColor = cs.outline.withOpacity(0.50);
    final labelColor = cs.onSurface.withOpacity(0.70);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Использование ОП (последние 10 измерений)',
          style: tt.titleSmall,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 20,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: gridColor,
                    strokeWidth: 0.5,
                  ),
                  getDrawingVerticalLine: (_) => FlLine(
                    color: gridColor,
                    strokeWidth: 0.5,
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toInt()}',
                        style: (tt.bodySmall ?? const TextStyle()).copyWith(
                          color: labelColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toInt()}%',
                        style: (tt.bodySmall ?? const TextStyle()).copyWith(
                          color: labelColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: borderColor,
                    width: 1,
                  ),
                ),
                minX: 0,
                maxX: 9,
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: ramData
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value))
                        .toList(),
                    isCurved: true,
                    color: cs.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) {
                        return FlDotCirclePainter(
                          radius: 2.6,
                          color: cs.primary,
                          strokeWidth: 1,
                          strokeColor: cs.surface,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: cs.primary.withOpacity(0.12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverview(BuildContext context, double currentCpu, double currentRam) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Общий обзор метрик',
          style: tt.titleSmall,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildCircularMetric(
                context: context,
                label: 'CPU',
                value: currentCpu,
                color: cs.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildCircularMetric(
                context: context,
                label: 'ОП',
                value: currentRam,
                color: cs.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircularMetric({
    required BuildContext context,
    required String label,
    required double value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final cardColor = theme.cardColor;
    final borderColor = cs.outline.withOpacity(0.50);
    final trackColor = cs.onSurface.withOpacity(0.18);
    final secondaryText = cs.onSurface.withOpacity(0.70);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: value / 100,
                  strokeWidth: 6,
                  backgroundColor: trackColor,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${value.toStringAsFixed(1)}%',
                        style: (tt.titleLarge ?? const TextStyle()).copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: cs.onSurface,
                        ),
                      ),
                      Text(
                        label,
                        style: (tt.bodySmall ?? const TextStyle()).copyWith(
                          fontSize: 12,
                          color: secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(
    BuildContext context,
    double avgCpu,
    double avgRam,
    double maxCpu,
    double maxRam,
  ) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final cardColor = theme.cardColor;
    final borderColor = cs.outline.withOpacity(0.50);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Статистика', style: tt.titleSmall),
          const SizedBox(height: 12),
          _buildStatRow(
            context,
            'Среднее CPU',
            '${avgCpu.toStringAsFixed(1)}%',
          ),
          const SizedBox(height: 8),
          _buildStatRow(
            context,
            'Среднее ОП',
            '${avgRam.toStringAsFixed(1)}%',
          ),
          const SizedBox(height: 8),
          _buildStatRow(
            context,
            'Макс CPU',
            '${maxCpu.toStringAsFixed(1)}%',
          ),
          const SizedBox(height: 8),
          _buildStatRow(
            context,
            'Макс ОП',
            '${maxRam.toStringAsFixed(1)}%',
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    final labelColor = cs.onSurface.withOpacity(0.70);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: (tt.bodySmall ?? const TextStyle()).copyWith(
            color: labelColor,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: (tt.bodyMedium ?? const TextStyle()).copyWith(
            color: cs.onSurface,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
