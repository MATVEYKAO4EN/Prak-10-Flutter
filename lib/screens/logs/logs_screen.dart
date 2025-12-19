// screens/logs_screen.dart
import 'package:flutter/material.dart';
import '../../models/log_entry.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  // Заглушки для логов (в реальном приложении будут получаться из MobX)
  final List<LogEntry> _logs = [
    LogEntry(
      action: LogAction.create,
      entityType: EntityType.product,
      entityName: 'Ноутбук Dell XPS 13',
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    LogEntry(
      action: LogAction.update,
      entityType: EntityType.document,
      entityName: 'Поступление товаров №123',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      changes: {'quantity': '100 → 120'},
    ),
    LogEntry(
      action: LogAction.delete,
      entityType: EntityType.product,
      entityName: 'Офисный стул',
      timestamp: DateTime.now().subtract(const Duration(hours: 2))
    ),
    LogEntry(
      action: LogAction.create,
      entityType: EntityType.document,
      entityName: 'Акт списания №45',
      timestamp: DateTime.now().subtract(const Duration(days: 1))
    ),
    LogEntry(
      action: LogAction.update,
      entityType: EntityType.product,
      entityName: 'Монитор Samsung 27"',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      changes: {'category': 'Электроника → Офисная техника'},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Журнал действий'),
        centerTitle: true
      ),
      body: _logs.isEmpty
          ? const Center(
        child: Text('Нет записей в журнале'),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _logs.length,
        itemBuilder: (context, index) {
          return _buildLogItem(_logs[index]);
        },
      ),
    );
  }

  Widget _buildLogItem(LogEntry log) {
    Color getActionColor(LogAction action) {
      switch (action) {
        case LogAction.create:
          return Colors.green;
        case LogAction.update:
          return Colors.blue;
        case LogAction.delete:
          return Colors.red;
      }
    }

    IconData getActionIcon(LogAction action) {
      switch (action) {
        case LogAction.create:
          return Icons.add_circle_outline;
        case LogAction.update:
          return Icons.edit_outlined;
        case LogAction.delete:
          return Icons.delete_outline;
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: getActionColor(log.action).withOpacity(0.1),
          child: Icon(
            getActionIcon(log.action),
            color: getActionColor(log.action),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                log.entityName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: getActionColor(log.action).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                log.actionText.toUpperCase(),
                style: TextStyle(
                  color: getActionColor(log.action),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            if (log.changes != null) ...[
              const SizedBox(height: 4),
              Text(
                'Изменения: ${log.changes!.values.join(', ')}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, size: 12),
                const SizedBox(width: 4),
                Text(
                  '${log.formattedDate} ${log.formattedTime}',
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          // В будущем можно добавить детальный просмотр
        },
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Фильтр журнала'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Здесь можно добавить элементы фильтрации
              const Text('Фильтрация будет реализована позже'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Закрыть'),
              ),
            ],
          ),
        );
      },
    );
  }
}