import 'package:dartz/dartz.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/auth/domain/entity/auth_enity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, String>> loginUser(String username, String password);

  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
