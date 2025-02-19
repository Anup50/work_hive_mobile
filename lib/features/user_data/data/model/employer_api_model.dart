import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/employer_entity.dart';

part 'employer_api_model.g.dart';

@JsonSerializable()
class EmployerApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String companyName;
  final String companyLogo;
  final String location;

  const EmployerApiModel({
    this.id,
    required this.companyName,
    required this.companyLogo,
    required this.location,
  });

  factory EmployerApiModel.fromJson(Map<String, dynamic> json) {
    return EmployerApiModel(
      id: json['_id'] as String?,
      companyName: json['companyName'] as String,
      companyLogo: json['companyLogo'] as String,
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$EmployerApiModelToJson(this);

  // Convert API Model to Entity
  EmployerEntity toEntity() {
    return EmployerEntity(
      employerId: id, // Map API model fields to entity fields
      companyName: companyName,
      companyLogo: companyLogo,
      location: location,
    );
  }

  // Convert Entity to API Model
  static EmployerApiModel fromEntity(EmployerEntity entity) {
    return EmployerApiModel(
      id: entity.employerId, // Map entity fields to API model fields
      companyName: entity.companyName,
      companyLogo: entity.companyLogo,
      location: entity.location,
    );
  }

  @override
  List<Object?> get props => [id, companyName, companyLogo, location];
}
