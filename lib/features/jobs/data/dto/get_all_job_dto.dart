import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/jobs/data/model/job_api_model.dart';

part 'get_all_job_dto.g.dart';

@JsonSerializable()
class GetAllJobDTO {
  final bool success;
  final int? count;
  final List<JobApiModel> data;

  GetAllJobDTO({
    required this.success,
    this.count,
    required this.data,
  });

  factory GetAllJobDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllJobDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllJobDTOToJson(this);
}
