class MinecraftServerModel {
  final String name;
  final String status;
  final int players;
  final String version;
  final String modLoader;
  final int allocatedCores;
  final int allocatedRam;
  final double cpuUsage;
  final double memoryUsage;

  MinecraftServerModel({
    required this.name,
    required this.status,
    required this.players,
    required this.version,
    required this.modLoader,
    required this.allocatedCores,
    required this.allocatedRam,
    this.cpuUsage = 0.0,
    this.memoryUsage = 0.0,
  });
}
