import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:work_hive_mobile/app/constants/hive_table_constant.dart';
import 'package:work_hive_mobile/features/auth/domain/entity/auth_enity.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String role;
  @HiveField(4)
  final String password;

  AuthHiveModel({
    String? userId,
    required this.name,
    required this.email,
    required this.role,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : userId = '',
        name = '',
        email = '',
        password = '',
        role = '';

  // fromEntity - Converts from domain entity to data model
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      name: entity.name,
      email: entity.email,
      role: entity.role,
      password: entity.password,
    );
  }

  // toEntity - Converts from data model to domain entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      name: name,
      email: email,
      role: role,
      password: password,
    );
  }

  @override
  List<Object?> get props => [userId, name, email, role, password];
}
