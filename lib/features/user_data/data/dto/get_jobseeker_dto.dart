import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/user_data/data/model/job_seeker_api_model.dart';

part 'get_jobseeker_dto.g.dart';

@JsonSerializable()
class GetJobseekerDto {
  final bool success;
  final JobSeekerApiModel data;

  GetJobseekerDto({
    required this.success,
    required this.data,
  });

  factory GetJobseekerDto.fromJson(Map<String, dynamic> json) =>
      _$GetJobseekerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetJobseekerDtoToJson(this);
}
