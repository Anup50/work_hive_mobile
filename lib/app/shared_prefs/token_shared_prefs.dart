import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_hive_mobile/core/error/failure.dart';

enum AuthStatus { authenticated, unauthenticated }

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> saveUserId(String userId) async {
    try {
      await _sharedPreferences.setString('userId', userId);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getUserId() async {
    try {
      final userId = _sharedPreferences.getString('Id');
      return Right(userId ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> saveRole(String role) async {
    try {
      await _sharedPreferences.setString('userRole', role);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String?>> getRole() async {
    try {
      final role = _sharedPreferences.getString('userRole');
      return Right(role ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> saveJobSeekerId(String? jobSeekerId) async {
    try {
      if (jobSeekerId?.isNotEmpty == true) {
        await _sharedPreferences.setString('jobSeekerId', jobSeekerId!);
      } else {
        await _sharedPreferences
            .remove('jobSeekerId'); // Remove if jobSeekerId is empty
      }
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String?>> getJobSeekerId() async {
    try {
      final jobSeekerId = _sharedPreferences.getString('jobSeekerId');
      return Right(jobSeekerId);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
