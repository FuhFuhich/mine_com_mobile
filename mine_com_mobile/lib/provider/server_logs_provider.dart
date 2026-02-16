import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/server_log_model.dart';

final serverLogsProvider = StateNotifierProvider.family<ServerLogsNotifier, List<ServerLogEntry>, String>(
  (ref, serverId) => ServerLogsNotifier(serverId),
);

class ServerLogsNotifier extends StateNotifier<List<ServerLogEntry>> {
  final String serverId;

  ServerLogsNotifier(this.serverId) : super([]) {
    _loadMockLogs();
  }

  void _loadMockLogs() {
    final now = DateTime.now();
    
    state = [
      ServerLogEntry(
        id: '1',
        timestamp: now.subtract(const Duration(minutes: 10)),
        level: LogLevel.info,
        message: 'Starting minecraft server version 1.20.1',
        source: 'ServerMain',
      ),
      ServerLogEntry(
        id: '2',
        timestamp: now.subtract(const Duration(minutes: 9, seconds: 45)),
        level: LogLevel.info,
        message: 'Loading properties',
        source: 'DedicatedServer',
      ),
      ServerLogEntry(
        id: '3',
        timestamp: now.subtract(const Duration(minutes: 9, seconds: 30)),
        level: LogLevel.info,
        message: 'Preparing level "world"',
        source: 'MinecraftServer',
      ),
      ServerLogEntry(
        id: '4',
        timestamp: now.subtract(const Duration(minutes: 9, seconds: 15)),
        level: LogLevel.info,
        message: 'Preparing start region for dimension minecraft:overworld',
        source: 'MinecraftServer',
      ),
      ServerLogEntry(
        id: '5',
        timestamp: now.subtract(const Duration(minutes: 8, seconds: 50)),
        level: LogLevel.warn,
        message: 'Can\'t keep up! Is the server overloaded? Running 2034ms or 40 ticks behind',
        source: 'MinecraftServer',
      ),
      ServerLogEntry(
        id: '6',
        timestamp: now.subtract(const Duration(minutes: 8, seconds: 30)),
        level: LogLevel.info,
        message: 'Done (15.243s)! For help, type "help"',
        source: 'DedicatedServer',
      ),
      ServerLogEntry(
        id: '7',
        timestamp: now.subtract(const Duration(minutes: 7, seconds: 20)),
        level: LogLevel.info,
        message: 'Player123[/192.168.1.100:54321] logged in with entity id 147 at (125.5, 64.0, -230.8)',
        source: 'ServerPlayNetHandler',
      ),
      ServerLogEntry(
        id: '8',
        timestamp: now.subtract(const Duration(minutes: 6, seconds: 45)),
        level: LogLevel.info,
        message: '<Player123> Hello server!',
        source: 'Server thread/INFO',
      ),
      ServerLogEntry(
        id: '9',
        timestamp: now.subtract(const Duration(minutes: 5, seconds: 30)),
        level: LogLevel.debug,
        message: 'Autosaving chunks in dimension minecraft:overworld',
        source: 'MinecraftServer',
      ),
      ServerLogEntry(
        id: '10',
        timestamp: now.subtract(const Duration(minutes: 4, seconds: 15)),
        level: LogLevel.info,
        message: 'Gamer456 joined the game',
        source: 'Server',
      ),
      ServerLogEntry(
        id: '11',
        timestamp: now.subtract(const Duration(minutes: 3, seconds: 50)),
        level: LogLevel.warn,
        message: 'Mod forge-1.20.1-47.2.0 is requesting immediate world save',
        source: 'ForgeMod',
      ),
      ServerLogEntry(
        id: '12',
        timestamp: now.subtract(const Duration(minutes: 3, seconds: 20)),
        level: LogLevel.error,
        message: 'Encountered an unexpected exception',
        source: 'MinecraftServer',
      ),
      ServerLogEntry(
        id: '13',
        timestamp: now.subtract(const Duration(minutes: 3, seconds: 19)),
        level: LogLevel.error,
        message: 'java.lang.NullPointerException: Cannot invoke method getBlockState() on null object',
        source: 'StackTrace',
      ),
      ServerLogEntry(
        id: '14',
        timestamp: now.subtract(const Duration(minutes: 2, seconds: 45)),
        level: LogLevel.info,
        message: 'Saving chunks for level \'ServerLevel[world]\'',
        source: 'MinecraftServer',
      ),
      ServerLogEntry(
        id: '15',
        timestamp: now.subtract(const Duration(minutes: 2, seconds: 10)),
        level: LogLevel.info,
        message: '<Gamer456> Anyone want to trade?',
        source: 'Server thread/INFO',
      ),
      ServerLogEntry(
        id: '16',
        timestamp: now.subtract(const Duration(minutes: 1, seconds: 30)),
        level: LogLevel.info,
        message: 'Player123 has made the advancement [Stone Age]',
        source: 'Server',
      ),
      ServerLogEntry(
        id: '17',
        timestamp: now.subtract(const Duration(minutes: 1)),
        level: LogLevel.debug,
        message: 'Tick duration: 45.23ms (avg: 42.15ms)',
        source: 'Performance',
      ),
      ServerLogEntry(
        id: '18',
        timestamp: now.subtract(const Duration(seconds: 45)),
        level: LogLevel.info,
        message: 'Preparing spawn area: 97%',
        source: 'MinecraftServer',
      ),
      ServerLogEntry(
        id: '19',
        timestamp: now.subtract(const Duration(seconds: 20)),
        level: LogLevel.fatal,
        message: 'Critical error in world generation! Server shutting down...',
        source: 'WorldGen',
      ),
      ServerLogEntry(
        id: '20',
        timestamp: now.subtract(const Duration(seconds: 5)),
        level: LogLevel.info,
        message: 'ThreadedAnvilChunkStorage: All chunks are saved',
        source: 'ChunkStorage',
      ),
    ];
  }

  void addLog(ServerLogEntry log) {
    state = [...state, log];
  }

  void clearLogs() {
    state = [];
  }

  void refresh() {
    _loadMockLogs();
  }
}
