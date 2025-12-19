class User {
  final String login;
  final DateTime? registrationDate;

  User({
    required this.login,
    this.registrationDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      registrationDate: json['registrationDate'] != null
          ? DateTime.parse(json['registrationDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'registrationDate': registrationDate?.toIso8601String(),
    };
  }
}