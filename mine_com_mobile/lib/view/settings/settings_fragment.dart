import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/settings_provider.dart';
import '../auth/login_screen.dart';
import '../../provider/auth_provider.dart';

class SettingsFragment extends ConsumerWidget {
  const SettingsFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsEnabled = ref.watch(notificationsProvider);
    final darkThemeEnabled = ref.watch(darkThemeProvider);

    Future<void> _logout() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Выход из аккаунта'),
          content: const Text('Вы уверены, что хотите выйти?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Выйти'),
            ),
          ],
        ),
      );

      if (confirmed == true && context.mounted) {
        await ref.read(authProvider.notifier).logout();
        
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Уведомления'),
            subtitle: const Text('Получать уведомления о статусе серверов'),
            value: notificationsEnabled,
            onChanged: (val) async {
              await ref.read(notificationsProvider.notifier).toggle(val);
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Тёмная тема'),
            subtitle: const Text('Изменить внешний вид приложения'),
            value: darkThemeEnabled,
            onChanged: (val) async {
              await ref.read(darkThemeProvider.notifier).toggle(val);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Выйти из аккаунта',
              style: TextStyle(color: Colors.red), 
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}
