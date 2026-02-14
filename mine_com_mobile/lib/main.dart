import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view/auth/login_screen.dart';
import 'view/main/home_screen.dart';
import 'theme/app_theme.dart';
import '../../provider/settings_provider.dart';
import '../../provider/auth_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authProvider);

    return MaterialApp(
      title: 'Auth Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ref.watch(darkThemeProvider) ? ThemeMode.dark : ThemeMode.light,
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
