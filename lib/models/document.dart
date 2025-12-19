class Document {
  final String id;
  final String title;
  final DateTime createdAt;

  Document({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  Document.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        title = json['title'] ?? '',
        createdAt = DateTime.parse(json['createdAt']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'createdAt': createdAt.toIso8601String(),
  };

  Document copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
  }) {
    return Document(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}