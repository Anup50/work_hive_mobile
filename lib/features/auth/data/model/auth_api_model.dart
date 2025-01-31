import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/auth/domain/entity/auth_enity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String email;
  final String role;
  final String? password;

  const AuthApiModel({
    this.id,
    required this.name,
    required this.email,
    required this.role,
    this.password,
  });
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      name: name,
      email: email,
      role: role,
      password: password ?? '',
    );
  }

  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      name: entity.name,
      email: entity.email,
      role: entity.role,
      password: entity.password,
    );
  }
}
