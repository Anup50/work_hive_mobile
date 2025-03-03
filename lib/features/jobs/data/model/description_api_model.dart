import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/description_entity.dart';

part 'description_api_model.g.dart';

@JsonSerializable()
class DescriptionApiModel extends Equatable {
  final String summary;
  final List<String> responsibilities;

  const DescriptionApiModel({
    required this.summary,
    required this.responsibilities,
  });

  factory DescriptionApiModel.fromJson(Map<String, dynamic> json) =>
      _$DescriptionApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$DescriptionApiModelToJson(this);

  JobDescriptionEntity toEntity() {
    return JobDescriptionEntity(
      summary: summary,
      responsibilities: responsibilities,
    );
  }

  factory DescriptionApiModel.fromEntity(JobDescriptionEntity entity) {
    return DescriptionApiModel(
      summary: entity.summary,
      responsibilities: entity.responsibilities,
    );
  }

  @override
  List<Object?> get props => [summary, responsibilities];
}
