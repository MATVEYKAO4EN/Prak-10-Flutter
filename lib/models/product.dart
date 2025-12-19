class Product {
  String id;
  String name;
  String category;
  int quantity;
  DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      quantity: json['quantity'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Метод для форматирования даты
  String get formattedDate {
    return '${updatedAt.day.toString().padLeft(2, '0')}.'
        '${updatedAt.month.toString().padLeft(2, '0')}.'
        '${updatedAt.year} '
        '${updatedAt.hour.toString().padLeft(2, '0')}:'
        '${updatedAt.minute.toString().padLeft(2, '0')}';
  }

  Product copyWith({
    String? id,
    String? name,
    String? category,
    int? quantity,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}