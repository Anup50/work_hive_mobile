import 'package:dartz/dartz.dart';
import 'package:work_hive_mobile/core/common/internet_checker.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:work_hive_mobile/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:work_hive_mobile/features/auth/domain/entity/auth_enity.dart';
import 'package:work_hive_mobile/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final NetworkInfo _networkInfo;

  AuthRemoteRepository(
      this._authRemoteDataSource, this._networkInfo, this._authLocalDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  // Future<Either<Failure, String>> loginUser(
  //     String email, String password) async {
  //   if (await _networkInfo.isConnected) {
  //     // Check internet
  //     try {
  //       final token = await _authRemoteDataSource.loginUser(email, password);
  //       return Right(token);
  //     } catch (e) {
  //       return Left(ApiFailure(message: e.toString()));
  //     }
  //   } else {
  //     return const Left(NetworkFailure(message: "No internet connection"));
  //   }
  // }
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    if (await _networkInfo.isConnected) {
      try {
        final token = await _authRemoteDataSource.loginUser(email, password);
        return Right(token);
      } catch (e) {
        // Remote failed, try local
        return _attemptLocalLogin(email, password);
      }
    } else {
      // No internet, try local
      return _attemptLocalLogin(email, password);
    }
  }

  Future<Either<Failure, String>> _attemptLocalLogin(
      String email, String password) async {
    try {
      final token = await _authLocalDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
//   Future<Either<Failure, void>> registerUser(AuthEntity user) async {
//     try {
//       await _authRemoteDataSource.registerUser(user);
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }
// }

  // Future<Either<Failure, void>> registerUser(AuthEntity user) async {
  //   if (await _networkInfo.isConnected) {
  //     // Check internet
  //     try {
  //       await _authRemoteDataSource.registerUser(user);
  //       return const Right(null);
  //     } catch (e) {
  //       return Left(ApiFailure(message: e.toString()));
  //     }
  //   } else {
  //     return const Left(NetworkFailure(message: "No internet connection"));
  //   }
  // }

  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    if (await _networkInfo.isConnected) {
      // Check internet
      try {
        await _authRemoteDataSource.registerUser(user);
        return const Right(null);
      } catch (e) {
        //remote failed, try local.
        return _attemptLocalRegister(user);
      }
    } else {
      //no internet, try local.
      return _attemptLocalRegister(user);
    }
  }

  Future<Either<Failure, void>> _attemptLocalRegister(AuthEntity user) async {
    try {
      await _authLocalDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
