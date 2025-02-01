part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends SignupEvent {}

class RegisterUser extends SignupEvent {
  final BuildContext context;
  final String name;
  final String email;
  final String password;
  final String role;

  const RegisterUser({
    required this.context,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
}
