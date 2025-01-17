import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String name;
  final String email;
  final String password;
  final String role;

  const AuthEntity({
    this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [userId, name, email, password, role];
}
