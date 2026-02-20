import 'package:flutter/material.dart';
import '../../model/minecraft_server_model.dart';
import '../../model/linux_server_model.dart';
import 'build fragments/metrics_fragment.dart';
import 'build fragments/linux_console_fragment.dart';
import 'build fragments/server_logs_fragment.dart';
import 'package:mine_com_mobile/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    
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
            _buildStatusCard(context, serverStatus, l10n),
            const SizedBox(height: 20),

            _buildInfoSection(
              context,
              minecraftVersion,
              modLoader,
              activePlayers,
              allocatedCores,
              allocatedRam,
              l10n
            ),
            const SizedBox(height: 20),

            _buildMetricsPreview(context, cpuUsage, memoryUsage, l10n),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  context,
                  icon: Icons.play_arrow,
                  label: l10n.startServerDetailServerDetail,
                  onPressed: () => _handleAction('Запуск'),
                ),
                _buildControlButton(
                  context,
                  icon: Icons.stop,
                  label: l10n.stopServerDetail,
                  onPressed: () => _handleAction('Остановка'),
                  isDanger: true,
                ),
                _buildControlButton(
                  context,
                  icon: Icons.refresh,
                  label: l10n.restartServerDetail,
                  onPressed: () => _handleAction('Перезагрузка'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildMetricsButton(context, l10n),
            const SizedBox(height: 12),
            _buildConsoleButton(
              context,
              serverName,
              sshHost,
              sshPort,
              sshUsername,
              sshPassword,
              l10n
            ),
            const SizedBox(height: 12),
            _buildLogsButton(context, l10n),
            const SizedBox(height: 12),
            _buildBackupButton(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, String status, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;
    
    final isOnline = status == l10n.onlineServerDetail;
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
                l10n.serverStatusServerDetail,
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
    AppLocalizations l10n
  ) {
    final theme = Theme.of(context);
    final tt = theme.textTheme;

    final items = [
      (l10n.minecraftVersionServerDetail, version),
      (l10n.modLoaderServerDetail, modLoader),
      (l10n.activePlayersServerDetail, '$players'),
      (l10n.dedicatedCoresServerDetail, '$cores ядер'),
      (l10n.dedicatedRamServerDetail, '$ram GB'),
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
            l10n.serverInformationServerDetail,
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

  Widget _buildMetricsPreview(BuildContext context, double cpu, double memory, AppLocalizations l10n) {
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
            l10n.currentMetricsServerDetail,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildMetricRow(context, l10n.cpuServerDetail, cpu),
          const SizedBox(height: 12),
          _buildMetricRow(context, l10n.ramServerDetail, memory),
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

  Widget _buildMetricsButton(BuildContext context, AppLocalizations l10n) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MetricsFragment(server: _server),
          ),
        );
      },
      icon: const Icon(Icons.show_chart),
      label: Text(l10n.detailedMetricsServerDetail),
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
    AppLocalizations l10n
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
      label: Text(l10n.linuxConsoleServerDetail),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildLogsButton(BuildContext context, AppLocalizations l10n) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ServerLogsFragment(server: _server),
          ),
        );
      },
      icon: const Icon(Icons.history),
      label: Text(l10n.serverLogsServerDetail),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildBackupButton(BuildContext context, AppLocalizations l10n) {
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
      label: Text(l10n.creatingServerBackupServerDetail),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
