import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:work_hive_mobile/app/service/sync/sync.dart';
import 'package:work_hive_mobile/core/common/internet_checker.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:work_hive_mobile/features/auth/domain/entity/auth_enity.dart';
import 'package:work_hive_mobile/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;
  final NetworkInfo _networkInfo;
  final SyncService _syncService;
  final Dio _dio;
  AuthLocalRepository(
    this._authLocalDataSource,
    this._networkInfo,
    this._syncService,
    this._dio,
  );

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final currentUser = await _authLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final token = await _authLocalDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      return Right(_authLocalDataSource.registerUser(user));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
