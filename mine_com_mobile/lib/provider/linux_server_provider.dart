import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/linux_server_model.dart';

final linuxServerListProvider = StateNotifierProvider<LinuxServerListNotifier, List<LinuxServerModel>>((ref) {
  return LinuxServerListNotifier();
});

class LinuxServerListNotifier extends StateNotifier<List<LinuxServerModel>> {
  LinuxServerListNotifier() : super([
    LinuxServerModel(
      id: '1',
      name: 'Production Server',
      host: 'demo.linux-server.com',
      port: 22,
      username: 'demo-user',
      password: 'demo-password-123',
    ),
    LinuxServerModel(
      id: '2',
      name: 'Development Server',
      host: 'dev.linux-server.com',
      port: 22,
      username: 'dev-user',
      password: 'dev-pass-456',
    ),
  ]);

  void addServer(LinuxServerModel server) {
    state = [...state, server];
  }

  void removeServer(String id) {
    state = state.where((server) => server.id != id).toList();
  }

  void updateServer(LinuxServerModel updatedServer) {
    state = [
      for (final server in state)
        if (server.id == updatedServer.id) updatedServer else server,
    ];
  }
}
