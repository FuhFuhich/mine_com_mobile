import 'package:flutter/material.dart';
import '../../model/user_model.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 60),
              ),
              const SizedBox(height: 16),
              const Text('Имя пользователя'),
              const SizedBox(height: 8),
              const Text('email@example.com'),
              const SizedBox(height: 32),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Информация профиля'),
                subtitle: const Text('Статистика, серверы, активность'),
                onTap: () {},
              ),
              const Divider(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
