import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/server_model.dart';

final serverListProvider = StateNotifierProvider<ServerListNotifier, List<ServerModel>>((ref) {
  return ServerListNotifier();
});

class ServerListNotifier extends StateNotifier<List<ServerModel>> {
  ServerListNotifier() : super([
    ServerModel(
      name: 'Minecraft Server 1',
      status: 'Онлайн',
      players: 12,
      version: '1.20.1',
      modLoader: 'Forge',
      allocatedCores: 4,
      allocatedRam: 8,
      cpuUsage: 45.5,
      memoryUsage: 65.3,
    ),
    ServerModel(
      name: 'Minecraft Server 2',
      status: 'Оффлайн',
      players: 0,
      version: '1.19.2',
      modLoader: 'Fabric',
      allocatedCores: 2,
      allocatedRam: 4,
      cpuUsage: 0.0,
      memoryUsage: 0.0,
    ),
  ]);
}
