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

    void addServer() {
      serverNotifier.addServer(ServerModel(
        name: 'Новый сервер ${servers.length + 1}',
        status: 'Онлайн',
        players: 0,
        version: '1.20.1',
        modLoader: 'Vanilla',
        allocatedCores: 2,
        allocatedRam: 4,
        cpuUsage: 10.0,
        memoryUsage: 20.0,
      ));
    }

    void removeServer() {
      serverNotifier.removeServer();
    }

    void handleServerAction(String action, int index) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$action: ${servers[index].name}'),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        title: const Text(
          'Список серверов',
          style: TextStyle(color: Colors.white),
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: addServer,
            icon: const Icon(Icons.add, color: Color(0xFF00E676)),
            tooltip: 'Добавить сервер',
          ),
          IconButton(
            onPressed: removeServer,
            icon: const Icon(Icons.remove, color: Colors.redAccent),
            tooltip: 'Удалить последний',
          ),
        ],
      ),
      body: servers.isEmpty
          ? const Center(
              child: Text(
                'Нет серверов',
                style: TextStyle(color: Color(0xFFBBBBBB)),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: servers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final server = servers[index];
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
                      color: const Color(0xFF222222),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF404040)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                server.status == 'Онлайн'
                                    ? Icons.cloud_done
                                    : Icons.cloud_off,
                                color: server.status == 'Онлайн'
                                    ? const Color(0xFF00E676)
                                    : Colors.redAccent,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      server.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Игроков: ${server.players} | ${server.version}',
                                      style: const TextStyle(
                                        color: Color(0xFFBBBBBB),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: const Color(0xFF404040),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActionButton(
                                icon: Icons.play_arrow,
                                label: 'Запуск',
                                onPressed: () =>
                                    handleServerAction('Запуск', index),
                              ),
                              _buildActionButton(
                                icon: Icons.stop,
                                label: 'Стоп',
                                onPressed: () =>
                                    handleServerAction('Остановка', index),
                              ),
                              _buildActionButton(
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

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00E676).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF00E676),
              size: 20,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFBBBBBB),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
