// lib/models/user_model.dart

class User {
  String email;
  String password;

  User({
    required this.email,
    required this.password,
  });

  // To create a User from a Map (useful when deserializing from JSON or a database)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  // To convert User to a Map (useful when serializing to send to an API or save locally)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}

