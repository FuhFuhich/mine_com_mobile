import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/minecraft_server_model.dart';
import 'package:mine_com_mobile/l10n/app_localizations.dart';

final serverListProvider = StateNotifierProvider<MinecraftServerListNotifier, List<MinecraftServerModel>>((ref) {
  return MinecraftServerListNotifier();
});

class MinecraftServerListNotifier extends StateNotifier<List<MinecraftServerModel>> {
  MinecraftServerListNotifier() : super([
    MinecraftServerModel(
      name: 'Minecraft Server 1',
      status: 'Online',
      players: 12,
      version: '1.20.1',
      modLoader: 'Forge',
      allocatedCores: 4,
      allocatedRam: 8,
      cpuUsage: 45.5,
      memoryUsage: 65.3,
    ),
    MinecraftServerModel(
      name: 'Minecraft Server 2',
      status: 'Offline',
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

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredServerListProvider = Provider<List<MinecraftServerModel>>((ref) {
  final servers = ref.watch(serverListProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  
  if (query.isEmpty) return servers;
  
  return servers.where((server) {
    return server.name.toLowerCase().contains(query);
  }).toList();
});
