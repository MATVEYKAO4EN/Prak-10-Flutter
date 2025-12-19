// models/log_entry.dart
enum LogAction {
  create,
  update,
  delete,
}

enum EntityType {
  document,
  product,
}

class LogEntry {
  final LogAction action;
  final EntityType entityType;
  final String entityName;
  final DateTime timestamp;
  final Map<String, dynamic>? changes;

  LogEntry({
    required this.action,
    required this.entityType,
    required this.entityName,
    required this.timestamp,
    this.changes,
  });

  String get actionText {
    switch (action) {
      case LogAction.create:
        return 'Создан';
      case LogAction.update:
        return 'Обновлен';
      case LogAction.delete:
        return 'Удален';
    }
  }

  String get entityTypeText {
    switch (entityType) {
      case EntityType.document:
        return 'Документ';
      case EntityType.product:
        return 'Продукт';
    }
  }

  String get formattedTime {
    return '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}';
  }

  String get formattedDate {
    return '${timestamp.day.toString().padLeft(2, '0')}.'
        '${timestamp.month.toString().padLeft(2, '0')}.'
        '${timestamp.year}';
  }
}