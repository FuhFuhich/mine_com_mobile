import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/settings_provider.dart';
import '../../provider/auth_provider.dart';
import '../auth/login_screen.dart';

class SettingsFragment extends ConsumerWidget {
  const SettingsFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // -----------------------------------------------------------------------------------------------------------------------
    // Данные из бд
    // -----------------------------------------------------------------------------------------------------------------------

    final notificationsEnabled = ref.watch(notificationsProvider);
    final darkThemeEnabled = ref.watch(darkThemeProvider);
    final appVersion = '1.0.0';

    // -----------------------------------------------------------------------------------------------------------------------
    // Данные из бд
    // -----------------------------------------------------------------------------------------------------------------------
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle(theme, 'Внешний вид'),
          _buildAppearanceSection(theme, context, ref, darkThemeEnabled),
          const SizedBox(height: 16),
          
          _buildSectionTitle(theme, 'Уведомления'),
          _buildNotificationsSection(theme, context, ref, notificationsEnabled),
          const SizedBox(height: 16),
          
          _buildSectionTitle(theme, 'О приложении'),
          _buildAboutSection(theme, context, appVersion),
          const SizedBox(height: 16),
          
          _buildSectionTitle(theme, 'Аккаунт'),
          _buildAccountSection(theme, context, ref),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8, top: 8),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildAppearanceSection(
    ThemeData theme,
    BuildContext context,
    WidgetRef ref,
    bool darkThemeEnabled,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          _buildSwitchTile(
            theme,
            icon: Icons.dark_mode_outlined,
            title: 'Темная тема',
            subtitle: 'Изменить внешний вид приложения',
            value: darkThemeEnabled,
            onChanged: (val) {
              ref.read(darkThemeProvider.notifier).toggle(val);
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildListTile(
            theme,
            icon: Icons.language,
            title: 'Язык',
            subtitle: 'Русский',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Смена языка будет добавлена позже')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsSection(
    ThemeData theme,
    BuildContext context,
    WidgetRef ref,
    bool notificationsEnabled,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: _buildSwitchTile(
        theme,
        icon: Icons.notifications_outlined,
        title: 'Уведомления',
        subtitle: 'Получать уведомления о статусе серверов',
        value: notificationsEnabled,
        onChanged: (val) {
          ref.read(notificationsProvider.notifier).toggle(val);
        },
      ),
    );
  }

  Widget _buildAboutSection(
    ThemeData theme,
    BuildContext context,
    String version,
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
            icon: Icons.info_outline,
            title: 'О приложении',
            subtitle: 'Версия $version',
            onTap: () {
              _showAboutDialog(context, theme, version);
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildListTile(
            theme,
            icon: Icons.help_outline,
            title: 'Помощь и поддержка',
            subtitle: 'Документация и FAQ',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Открыть справку')),
              );
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildListTile(
            theme,
            icon: Icons.privacy_tip_outlined,
            title: 'Политика конфиденциальности',
            subtitle: 'Условия использования',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Политика конфиденциальности')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection(
    ThemeData theme,
    BuildContext context,
    WidgetRef ref,
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
            icon: Icons.security_outlined,
            title: 'Безопасность',
            subtitle: 'Пароль и двухфакторная аутентификация',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Настройки безопасности')),
              );
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          _buildListTile(
            theme,
            icon: Icons.logout,
            iconColor: Colors.red,
            title: 'Выйти из аккаунта',
            titleColor: Colors.red,
            onTap: () => _showLogoutDialog(context, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
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
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildListTile(
    ThemeData theme, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    bool showArrow = true,
    Color? iconColor,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? const Color(0xFF00E676)).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: iconColor ?? const Color(0xFF00E676),
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: titleColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: theme.textTheme.bodySmall,
            )
          : null,
      trailing: trailing ??
          (showArrow
              ? const Icon(Icons.arrow_forward_ios, size: 16)
              : null),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выход из аккаунта'),
        content: const Text('Вы уверены, что хотите выйти из аккаунта?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(authProvider.notifier).logout();
              
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context, ThemeData theme, String version) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF00E676).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.dns_rounded,
                color: Color(0xFF00E676),
                size: 32,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text('О приложении'),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Программный комплекс автоматизации развертывания и управления Minecraft-серверами',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Версия', version),
              _buildInfoRow('Платформа', 'Unix-подобные системы'),
              _buildInfoRow('Разработчик', 'Minecraft Manager Team'),
              const SizedBox(height: 16),
              Text(
                'Возможности:',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              _buildFeatureItem('SSH консоль для управления'),
              _buildFeatureItem('Мониторинг метрик в реальном времени'),
              _buildFeatureItem('Просмотр логов серверов'),
              _buildFeatureItem('Автоматизация развертывания'),
              _buildFeatureItem('Управление бэкапами'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF00E676),
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
