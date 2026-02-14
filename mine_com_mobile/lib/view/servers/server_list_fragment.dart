import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/server_model.dart';
import '../../provider/server_provider.dart';
import 'server_detail_screen.dart';

class ServerListWrapper extends ConsumerWidget {
  const ServerListWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servers = ref.watch(serverListProvider);
    final serverNotifier = ref.read(serverListProvider.notifier);

    void handleServerAction(String action, int index) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$action: ${servers[index].name}'),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }

    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список серверов'),
      ),
      body: servers.isEmpty
          ? Center(
              child: Text(
                'Нет серверов',
                style: tt.bodySmall,
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: servers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final server = servers[index];
                final isOnline = server.status == 'Онлайн';
                final statusColor = isOnline ? cs.primary : cs.error;

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ServerDetailScreen(server: server),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                isOnline ? Icons.cloud_done : Icons.cloud_off,
                                color: statusColor,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      server.name,
                                      style: tt.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Игроков: ${server.players} | ${server.version}',
                                      style: tt.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: theme.dividerColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActionButton(
                                context,
                                icon: Icons.play_arrow,
                                label: 'Запуск',
                                onPressed: () =>
                                    handleServerAction('Запуск', index),
                              ),
                              _buildActionButton(
                                context,
                                icon: Icons.stop,
                                label: 'Стоп',
                                onPressed: () =>
                                    handleServerAction('Остановка', index),
                              ),
                              _buildActionButton(
                                context,
                                icon: Icons.refresh,
                                label: 'Перезагрузка',
                                onPressed: () =>
                                    handleServerAction('Перезагрузка', index),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: cs.primary,
              size: 20,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: tt.bodySmall?.copyWith(fontSize: 10),
        ),
      ],
    );
  }
}
