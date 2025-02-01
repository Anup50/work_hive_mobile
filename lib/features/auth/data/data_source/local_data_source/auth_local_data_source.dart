import 'package:work_hive_mobile/core/network/hive_service.dart';
import 'package:work_hive_mobile/features/auth/data/data_source/auth_data_source.dart';
import 'package:work_hive_mobile/features/auth/data/model/auth_hive_model.dart';
import 'package:work_hive_mobile/features/auth/domain/entity/auth_enity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    // Return Empty AuthEntity
    return Future.value(const AuthEntity(
      name: '',
      email: '',
      password: '',
      role: '',
    ));
  }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      await _hiveService.login(username, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(user);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }
}
