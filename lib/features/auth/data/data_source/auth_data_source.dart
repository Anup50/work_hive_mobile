import 'package:work_hive_mobile/features/auth/data/model/login_response.dart';
import 'package:work_hive_mobile/features/auth/domain/entity/auth_enity.dart';

abstract interface class IAuthDataSource {
  Future<LoginResponse> loginUser(String email, String password);

  Future<void> registerUser(AuthEntity user);

  Future<AuthEntity> getCurrentUser();
}
