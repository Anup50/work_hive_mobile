import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:work_hive_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:work_hive_mobile/app/usecase/usecase.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/auth/data/model/login_response.dart';
import 'package:work_hive_mobile/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : email = '',
        password = '';

  @override
  List<Object> get props => [email, password];
}

class LoginUseCase implements UsecaseWithParams<LoginResponse, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;
  LoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams params) async {
    return repository.loginUser(params.email, params.password).then((value) {
      return value.fold(
        (failure) => Left(failure),
        (loginResponse) async {
          try {
            // Save token and role from response
            await tokenSharedPrefs.saveToken(loginResponse.token);
            await tokenSharedPrefs.saveRole(loginResponse.role);

            // Decode token to get user ID
            final decodedToken = JwtDecoder.decode(loginResponse.token);
            final userId = decodedToken['id'] as String?;

            if (userId != null) {
              await tokenSharedPrefs.saveUserId(userId);
              print("User ID saved: $userId");
            } else {
              print("User ID not found in token!");
            }

            // Save role-specific ID based on user type
            if (loginResponse.role == 'Employer' &&
                loginResponse.employerId != null) {
              await tokenSharedPrefs.saveJobSeekerId(loginResponse.employerId!);
              print("Employer ID saved: ${loginResponse.employerId}");
            } else if (loginResponse.role == 'User' &&
                loginResponse.jobSeekerId != null) {
              await tokenSharedPrefs
                  .saveJobSeekerId(loginResponse.jobSeekerId!);
              print("Job Seeker ID saved: ${loginResponse.jobSeekerId}");
            }

            return Right(loginResponse);
          } catch (e) {
            return Left(CacheFailure(
                message: "Failed to save auth data: ${e.toString()}"));
          }
        },
      );
    });
  }
}
