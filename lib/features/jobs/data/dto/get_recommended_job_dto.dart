import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/jobs/data/model/job_api_model.dart';

part 'get_recommended_job_dto.g.dart';

@JsonSerializable()
class GetRecommendedJobDto {
  final bool success;
  final int? count;
  final List<JobApiModel> data;

  GetRecommendedJobDto({
    required this.success,
    this.count,
    required this.data,
  });

  factory GetRecommendedJobDto.fromJson(Map<String, dynamic> json) =>
      _$GetRecommendedJobDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetRecommendedJobDtoToJson(this);
}
