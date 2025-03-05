import 'package:dio/dio.dart';
import 'package:work_hive_mobile/app/constants/api_endpoints.dart';
import 'package:work_hive_mobile/features/auth/data/data_source/auth_data_source.dart';
import 'package:work_hive_mobile/features/auth/data/model/login_response.dart';
import 'package:work_hive_mobile/features/auth/domain/entity/auth_enity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  // Future<String?> _getToken() async {
  //   final tokenResult = await _tokenSharedPrefs.getToken();
  //   return tokenResult.getOrElse(() => '');
  // }

  // Future<String?> _getRole() async {
  //   final roleResult = await _tokenSharedPrefs.getRole();
  //   return roleResult.getOrElse(() => '');
  // }

  // Future<String?> _getUserId() async {
  //   final idResult = await _tokenSharedPrefs.getUserId();
  //   return idResult.getOrElse(() => '');
  // }

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  // Future<String> loginUser(String email, String password) async {
  //   try {
  //     Response response = await _dio.post(
  //       ApiEndpoints.login,
  //       data: {
  //         "email": email,
  //         "password": password,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final str = response.data['token'];
  //       return str;
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "name": user.name,
          "email": user.email,
          "role": user.role,
          "password": user.password,
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<LoginResponse> loginUser(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        // Parse full response using DTO
        return LoginResponse.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: "Login failed: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        error: "Login error: ${e.message}",
      );
    }
  }
}


  // @override
  // Future<String> loginUser(String email, String password) async {
  //   try {
  //     Response response = await _dio.post(
  //       ApiEndpoints.login,
  //       data: {
  //         "email": email,
  //         "password": password,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final str = response.data['token'];
  //       return str;
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }