class User {
  final int id;
  final bool statusenabled;
  final String username;
  final String password;
  final String createdAt;

  User({
    required this.id,
    required this.statusenabled,
    required this.username,
    required this.password,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        statusenabled: json['statusenabled'],
        username: json['username'],
        password: json['password'],
        createdAt: json['createdAt']);
  }
}
