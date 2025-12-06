class ServerModel {
  final String name;
  final String status;
  final int players;
  final String version;
  final String modLoader;
  final int allocatedCores;
  final int allocatedRam;
  final double cpuUsage;
  final double memoryUsage;

  ServerModel({
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

class UserModel {
  final String name;
  final String email;

  UserModel({required this.name, required this.email});
}
