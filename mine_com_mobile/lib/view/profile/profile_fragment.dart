import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/minecraft_server_provider.dart';

class ProfileFragment extends ConsumerWidget {
  const ProfileFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final servers = ref.watch(serverListProvider);
    
    // -----------------------------------------------------------------------------------------------------------------------
    // Данные из бд
    // -----------------------------------------------------------------------------------------------------------------------

    final totalServers = servers.length;
    final onlineServers = 1;
    final offlineServers = servers.length - onlineServers;
    final totalPlayers = 12;
    final avgPlayers = 6;
    final avgCpu = 52.3;
    final avgMemory = 68.7;
    final mostPopularServerName = 'Minecraft Server 1';
    final mostPopularServerPlayers = 12;

    // -----------------------------------------------------------------------------------------------------------------------
    // Данные из бд
    // -----------------------------------------------------------------------------------------------------------------------
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Редактировать профиль',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Редактирование профиля')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(theme),
            const SizedBox(height: 24),
            
            _buildStatsCards(theme, totalServers, onlineServers, totalPlayers),
            const SizedBox(height: 24),
            
            _buildServerOverview(
              theme,
              avgPlayers,
              avgCpu,
              avgMemory,
              mostPopularServerName,
              mostPopularServerPlayers,
            ),
            const SizedBox(height: 16),
            
            _buildActivitySection(theme, context, onlineServers, offlineServers),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00E676).withOpacity(0.3),
                      const Color(0xFF00E676).withOpacity(0.1),
                    ],
                  ),
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.person, size: 50),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E676),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.cardColor,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.verified,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Администратор',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'admin@minecraft-manager.com',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF00E676).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF00E676).withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.admin_panel_settings,
                  size: 16,
                  color: Color(0xFF00E676),
                ),
                const SizedBox(width: 6),
                Text(
                  'Системный администратор',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF00E676),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(ThemeData theme, int total, int online, int players) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            theme,
            Icons.dns_rounded,
            total.toString(),
            'Всего серверов',
            const Color(0xFF2196F3),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            theme,
            Icons.power_settings_new,
            online.toString(),
            'Онлайн',
            const Color(0xFF00E676),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            theme,
            Icons.people,
            players.toString(),
            'Игроков',
            const Color(0xFFFF9800),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    ThemeData theme,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServerOverview(
    ThemeData theme,
    int avgPlayers,
    double avgCpu,
    double avgMemory,
    String mostPopularName,
    int mostPopularPlayers,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E676).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                  color: Color(0xFF00E676),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Обзор серверов',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          _buildOverviewItem(
            theme,
            Icons.people_outline,
            'Среднее количество игроков',
            '$avgPlayers игр.',
            const Color(0xFFFF9800),
          ),
          const SizedBox(height: 16),
          
          _buildOverviewItem(
            theme,
            Icons.memory,
            'Средняя загрузка CPU',
            '${avgCpu.toStringAsFixed(1)}%',
            avgCpu > 70 ? const Color(0xFFFF5252) : const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 16),
          
          _buildOverviewItem(
            theme,
            Icons.storage,
            'Средняя загрузка RAM',
            '${avgMemory.toStringAsFixed(1)}%',
            avgMemory > 70 ? const Color(0xFFFF5252) : const Color(0xFF4CAF50),
          ),
          
          const SizedBox(height: 16),
          Divider(color: theme.dividerColor),
          const SizedBox(height: 16),
          
          _buildOverviewItem(
            theme,
            Icons.star,
            'Самый популярный сервер',
            '$mostPopularName ($mostPopularPlayers игр.)',
            const Color(0xFFFFC107),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(
    ThemeData theme,
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivitySection(
    ThemeData theme,
    BuildContext context,
    int online,
    int offline,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          _buildListTile(
            theme,
            Icons.terminal,
            'SSH подключения',
            'Управление ключами и сессиями',
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Управление SSH')),
              );
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildListTile(
            theme,
            Icons.history,
            'История действий',
            'Журнал операций и изменений',
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('История действий')),
              );
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildListTile(
            theme,
            Icons.assessment_outlined,
            'Статус серверов',
            'Онлайн: $online • Оффлайн: $offline',
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Детальная статистика')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    ThemeData theme,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF00E676).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF00E676),
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall,
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
