enum LogLevel {
  info,
  warn,
  error,
  debug,
  fatal,
}

class ServerLogEntry {
  final String id;
  final DateTime timestamp;
  final LogLevel level;
  final String message;
  final String? source;

  ServerLogEntry({
    required this.id,
    required this.timestamp,
    required this.level,
    required this.message,
    this.source,
  });

  String get formattedTime {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final second = timestamp.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }
}
