// auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier extends StateNotifier<bool> {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _emailKey = 'user_email';
  static const String _rememberMeKey = 'remember_me';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  AuthNotifier() : super(false) {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    if (isLoggedIn) state = true;
  }

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    
    if (rememberMe) {
      await prefs.setString(_emailKey, email);
      await prefs.setBool(_rememberMeKey, true);
      
      await _storage.write(key: 'user_password_secure', value: password);
    }
    
    state = true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_rememberMeKey);
    
    await _storage.delete(key: 'user_password_secure');
    
    state = false;
  }

  Future<Map<String, String>?> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool(_rememberMeKey) ?? false;
    if (!rememberMe) return null;
    
    final email = prefs.getString(_emailKey) ?? '';
    final password = await _storage.read(key: 'user_password_secure') ?? '';
    
    return {'email': email, 'password': password};
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});
