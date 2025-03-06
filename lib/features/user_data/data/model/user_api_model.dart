import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/user_entity.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  final String? name;

  const UserApiModel({
    this.userId,
    this.name,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return UserApiModel(
      userId: json['_id'] as String?,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  // Convert API Model to Entity
  UserEntity toEntity() {
    return UserEntity(
      userId: userId, // Map API model fields to entity fields
      name: name,
    );
  }

  // Convert Entity to API Model
  static UserApiModel fromEntity(UserEntity entity) {
    return UserApiModel(
      userId: entity.userId, // Map entity fields to API model fields
      name: entity.name,
    );
  }

  @override
  List<Object?> get props => [userId, name];
}
