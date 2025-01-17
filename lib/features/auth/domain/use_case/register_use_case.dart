import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:work_hive_mobile/app/usecase/usecase.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/auth/domain/entity/auth_enity.dart';
import 'package:work_hive_mobile/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String name;
  final String role;
  final String email;
  final String password;

  const RegisterUserParams({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [name, email, role, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      name: params.name,
      email: params.email,
      password: params.password,
      role: params.role,
    );
    return repository.registerUser(authEntity);
  }
}
