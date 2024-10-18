class User {
  final String id;
  final String email;
  final bool isAdmin;

  User({
    required this.id,
    required this.email,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      isAdmin: json['is_admin'] == true || json['is_admin'] == 'true',  // Handle both boolean and string types
    );
  }
}
