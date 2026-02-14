import 'package:flutter/material.dart';

class ConsoleFragment extends StatefulWidget {
  final Function(String) onServerSelected;

  const ConsoleFragment({
    super.key,
    required this.onServerSelected,
  });

  @override
  State<ConsoleFragment> createState() => _ConsoleFragmentState();
}

class _ConsoleFragmentState extends State<ConsoleFragment> {
  String? _selectedServer;
  final _consoleController = TextEditingController();
  final List<String> _consoleOutput = [
    '[INFO] Сервер запущен',
    '[INFO] Загрузка конфигурации...',
    '[INFO] Порты открыты: 25565',
  ];
  final List<String> _servers = ['Minecraft Server 1', 'Minecraft Server 2', 'Minecraft Server 3'];

  void _addConsoleOutput(String message) {
    setState(() {
      _consoleOutput.add('[${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}] $message');
      if (_consoleOutput.length > 100) {
        _consoleOutput.removeAt(0);
      }
    });
  }

  void _sendCommand() {
    if (_consoleController.text.isNotEmpty) {
      _addConsoleOutput('> ${_consoleController.text}');
      _consoleController.clear();
    }
  }

  @override
  void dispose() {
    _consoleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: DropdownButtonFormField<String>(
            value: _selectedServer,
            hint: const Text('Выберите сервер'),
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: const Icon(Icons.dns),
            ),
            items: _servers.map((server) {
              return DropdownMenuItem(value: server, child: Text(server));
            }).toList(),
            onChanged: (value) {
              setState(() => _selectedServer = value);
            },
          ),
        ),
        if (_selectedServer != null)
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: ListView.builder(
                itemCount: _consoleOutput.length,
                itemBuilder: (context, index) {
                  final line = _consoleOutput[index];
                  return Text(
                    line,
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 12,
                      color: Color(0xFF00E676),
                    ),
                  );
                },
              ),
            ),
          )
        else
          Expanded(
            child: Center(
              child: Text(
                'Выберите сервер для просмотра консоли',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        if (_selectedServer != null)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _consoleController,
                    decoration: InputDecoration(
                      hintText: 'Введите команду...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      prefixIcon: const Icon(Icons.chevron_right),
                    ),
                    onSubmitted: (_) => _sendCommand(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _sendCommand,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
      ],
    );
  }
}