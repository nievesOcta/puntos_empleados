// lib/models/user.dart
class User {
  final String username;
  final String password; // En una app real, ¡nunca guardarías contraseñas así!

  User({required this.username, required this.password});
}