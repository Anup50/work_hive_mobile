// import 'package:equatable/equatable.dart';
// import 'package:work_hive_mobile/features/user_data/domain/entity/employer_entity.dart';

// class JobEntity extends Equatable {
//   final String? jobId;
//   final String title;
//   final String description;
//   final EmployerEntity employer;
//   final String location;
//   final num? salary;
//   final String jobType;
//   final String experienceLevel;
//   final DateTime datePosted;
//   final DateTime deadline;
//   final List<String> skillsRequired;
//   final bool isActive;

//   const JobEntity({
//     this.jobId,
//     required this.title,
//     required this.description,
//     required this.employer,
//     required this.location,
//     this.salary,
//     required this.jobType,
//     required this.experienceLevel,
//     required this.datePosted,
//     required this.deadline,
//     required this.skillsRequired,
//     required this.isActive,
//   });

//   // const JobEntity.empty()
//   //     : jobId = '_empty.jobId',
//   //       title = '_empty.title',
//   //       description = '_empty.description',
//   //       employer = '_empty.employer',
//   //       location = '_empty.location',
//   //       salary = 0,
//   //       jobType = '_empty.jobType',
//   //       experienceLevel = '_empty.experienceLevel',
//   //       datePosted = DateTime.fromMillisecondsSinceEpoch(0),
//   //       deadline = null,
//   //       skillsRequired = const [],
//   //       isActive = false;

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

import 'package:equatable/equatable.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/description_entity.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/employer_entity.dart';

class JobEntity extends Equatable {
  final String? jobId;
  final String title;
  final JobDescriptionEntity description;
  final EmployerEntity employer;
  final String location;
  final num salary;
  final String jobType;
  final String experienceLevel;
  final DateTime? datePosted;
  final DateTime? deadline;
  final List<String> skillsRequired;
  final bool? isActive;

  const JobEntity({
    this.jobId,
    required this.title,
    required this.description,
    required this.employer,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.experienceLevel,
    this.datePosted,
    this.deadline,
    required this.skillsRequired,
    this.isActive,
  });

  // const JobEntity.empty()
  //     : jobId = '_empty.jobId',
  //       title = '_empty.title',
  //       description = const JobDescriptionEntity(
  //         summary: '_empty.summary',
  //         responsibilities: [],
  //       ),
  //       employer = const EmployerEntity.empty(),
  //       location = '_empty.location',
  //       salary = 0,
  //       jobType = '_empty.jobType',
  //       experienceLevel = '_empty.experienceLevel',
  //       datePosted = DateTime.fromMillisecondsSinceEpoch(0),
  //       deadline = null,
  //       skillsRequired = const [],
  //       isActive = false;

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
