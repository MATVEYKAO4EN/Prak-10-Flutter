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