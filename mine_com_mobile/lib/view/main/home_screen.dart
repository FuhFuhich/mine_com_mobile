import 'package:flutter/material.dart';
import '../profile/profile_fragment.dart';
import '../servers/server_list_fragment.dart';
import '../settings/settings_fragment.dart';
import 'package:mine_com_mobile/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final List<Widget> _pages = const [
    ProfileFragment(),
    ServerListWrapper(),
    SettingsFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme.cardColor,
        selectedItemColor: const Color(0xFF00E676),
        unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
        selectedFontSize: 12,
        unselectedFontSize: 11,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: l10n.profileMainMenu,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.dns_outlined),
            activeIcon: const Icon(Icons.dns),
            label: l10n.serversMainMenu,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: l10n.settingsMainMenu,
          ),
        ],
      ),
    );
  }
}
