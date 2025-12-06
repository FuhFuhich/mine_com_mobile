import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/settings_provider.dart';

class SettingsFragment extends ConsumerWidget {
  const SettingsFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsEnabled = ref.watch(notificationsProvider);
    final darkTheme = ref.watch(darkThemeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        title: const Text('Настройки'),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            activeThumbColor: const Color(0xFF00E676),
            title: const Text('Уведомления', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Получать уведомления о статусе серверов',
                style: TextStyle(color: Color(0xFFBBBBBB))),
            value: notificationsEnabled,
            onChanged: (val) {
              ref.read(notificationsProvider.notifier).state = val;
            },
          ),
          const Divider(color: Color(0xFF333333)),
          SwitchListTile(
            activeThumbColor: const Color(0xFF00E676),
            title: const Text('Тёмная тема', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Изменить внешний вид приложения',
                style: TextStyle(color: Color(0xFFBBBBBB))),
            value: darkTheme,
            onChanged: (val) {
              ref.read(darkThemeProvider.notifier).state = val;
            },
          ),
          const Divider(color: Color(0xFF333333)),
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xFF00E676)),
            title: const Text('Выйти из аккаунта', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
