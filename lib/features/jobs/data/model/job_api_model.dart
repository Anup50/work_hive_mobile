import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/jobs/data/model/description_api_model.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/user_data/data/model/employer_api_model.dart';

part 'job_api_model.g.dart';

@JsonSerializable()
class JobApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? jobId;
  final String title;
  final DescriptionApiModel description;
  final EmployerApiModel employer;
  final String location;
  @JsonKey(nullable: true)
  final num? salary;
  final String jobType;
  final String experienceLevel;
  final DateTime? datePosted;
  final DateTime? deadline;
  final List<String> skillsRequired;
  final bool? isActive;

  const JobApiModel({
    required this.jobId,
    required this.title,
    required this.description,
    required this.location,
    required this.employer,
    this.salary,
    required this.jobType,
    required this.experienceLevel,
    this.datePosted,
    this.deadline,
    required this.skillsRequired,
    this.isActive,
  });

  factory JobApiModel.fromJson(Map<String, dynamic> json) =>
      _$JobApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobApiModelToJson(this);

  JobEntity toEntity() {
    return JobEntity(
      jobId: jobId,
      title: title,
      description: description.toEntity(),
      location: location,
      salary: salary ?? 0,
      employer: employer.toEntity(),
      jobType: jobType,
      experienceLevel: experienceLevel,
      datePosted: datePosted,
      deadline: deadline,
      skillsRequired: skillsRequired,
      isActive: isActive,
    );
  }

  factory JobApiModel.fromEntity(JobEntity entity) {
    return JobApiModel(
      jobId: entity.jobId,
      title: entity.title,
      location: entity.location,
      salary: entity.salary,
      description: DescriptionApiModel.fromEntity(entity.description),
      employer: EmployerApiModel.fromEntity(entity.employer),
      skillsRequired: entity.skillsRequired,
      jobType: entity.jobType,
      experienceLevel: entity.experienceLevel,
      datePosted: entity.datePosted,
      deadline: entity.deadline,
      isActive: entity.isActive,
    );
  }

  static List<JobEntity> toEntityList(List<JobApiModel> jobList) {
    return jobList.map((data) => data.toEntity()).toList();
  }

  @override
  List<Object?> get props => [
        jobId,
        title,
        description,
        employer,
        location,
        salary,
        jobType,
        experienceLevel,
        datePosted,
        deadline,
        skillsRequired,
        isActive,
      ];
}

// part 'job_api_model.g.dart';

// @JsonSerializable()
// class JobApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? jobId;
//   final String title;
//   final JobDescriptionEntity description;
//   final EmployerApiModel employer;
//   final String location;
//   @JsonKey(nullable: true)
//   final num? salary;
//   final String jobType;
//   final String experienceLevel;
//   final DateTime datePosted;
//   final DateTime deadline;
//   final List<String> skillsRequired;
//   final bool isActive;

//   const JobApiModel({
//     required this.jobId,
//     required this.title,
//     required this.description,
//     required this.location,
//     required this.employer,
//     this.salary,
//     required this.jobType,
//     required this.experienceLevel,
//     required this.datePosted,
//     required this.deadline,
//     required this.skillsRequired,
//     required this.isActive,
//   });

//   factory JobApiModel.fromJson(Map<String, dynamic> json) =>
//       _$JobApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$JobApiModelToJson(this);

//   JobEntity toEntity() {
//     return JobEntity(
//       jobId: jobId,
//       title: title,
//       description: description,
//       location: location,
//       salary: salary,
//       employer: employer.toEntity(),
//       jobType: jobType,
//       experienceLevel: experienceLevel,
//       datePosted: datePosted,
//       deadline: deadline,
//       skillsRequired: skillsRequired,
//       isActive: isActive,
//     );
//   }

//   factory JobApiModel.fromEntity(JobEntity entity) {
//     return JobApiModel(
//       jobId: entity.jobId,
//       title: entity.title,
//       location: entity.location,
//       salary: entity.salary,
//       description: entity.description,
//       employer: EmployerApiModel.fromEntity(entity.employer),
//       skillsRequired: entity.skillsRequired,
//       jobType: entity.jobType,
//       experienceLevel: entity.experienceLevel,
//       datePosted: entity.datePosted,
//       deadline: entity.deadline,
//       isActive: entity.isActive,
//     );
//   }

//   static List<JobEntity> toEntityList(List<JobApiModel> jobList) {
//     return jobList.map((data) => data.toEntity()).toList();
//   }

//   @override
//   List<Object?> get props => [
//         jobId,
//         title,
//         description,
//         employer,
//         location,
//         salary,
//         jobType,
//         experienceLevel,
//         datePosted,
//         deadline,
//         skillsRequired,
//         isActive,
//       ];
// }
