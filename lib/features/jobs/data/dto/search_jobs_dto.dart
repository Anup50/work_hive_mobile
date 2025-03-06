import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/jobs/data/model/job_api_model.dart';

part 'search_jobs_dto.g.dart';

@JsonSerializable()
class SearchJobsDto {
  final bool success;
  final int? count;
  final List<JobApiModel> data;

  SearchJobsDto({
    required this.success,
    this.count,
    required this.data,
  });

  factory SearchJobsDto.fromJson(Map<String, dynamic> json) =>
      _$SearchJobsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SearchJobsDtoToJson(this);
}
