import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/jobs/data/model/job_api_model.dart';

part 'get_job_by_id_dto.g.dart';

@JsonSerializable()
class GetJobByIdDTO {
  final bool success;
  final JobApiModel data;

  GetJobByIdDTO({
    required this.success,
    required this.data,
  });

  factory GetJobByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetJobByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetJobByIdDTOToJson(this);
}
