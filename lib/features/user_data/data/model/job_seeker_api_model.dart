// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'job_seeker_api_model.g.dart';

// @JsonSerializable()
// class JobSeekerApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? id;
//   final String? userId;
//   final String? profilePicture;
//   final String? bio;
//   final String? location;
//   final List<String> skills;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   const JobSeekerApiModel({
//     this.id,
//     this.userId,
//     this.profilePicture,
//     this.bio,
//     this.location,
//     this.skills = const [],
//     this.createdAt,
//     this.updatedAt,
//   });
//   factory JobSeekerApiModel.fromJson(Map<String, dynamic> json) =>
//       _$JobSeekerApiModelFromJson(json);

//   // To JSON
//   Map<String, dynamic> toJson() => _$JobSeekerApiModelToJson(this);

//   // To Entity
//   JobSeekerEntity toEntity() {
//     return JobSeekerEntity(
//       userId: userId,
//       profilePicture: profilePicture,
//       bio: bio,
//       location: location,
//       skills: skills,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//     );
//   }

//   // From Entity
//   factory JobSeekerApiModel.fromEntity(JobSeekerEntity entity) {
//     return JobSeekerApiModel(
//       userId: entity.userId,
//       profilePicture: entity.profilePicture,
//       bio: entity.bio,
//       location: entity.location,
//       skills: entity.skills,
//       createdAt: entity.createdAt,
//       updatedAt: entity.updatedAt,
//     );
//   }
//   @override
//   List<Object?> get props => [
//         id,
//         userId,
//         profilePicture,
//         bio,
//         location,
//         skills,
//         createdAt,
//         updatedAt,
//       ];
// }
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';

// part 'job_seeker_api_model.g.dart';

// @JsonSerializable()
// class JobSeekerApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? id;
//   final UserIdModel? userId;
//   final String? profilePicture;
//   final String? bio;
//   final String? location;
//   final List<String> skills;

//   const JobSeekerApiModel({
//     this.id,
//     this.userId,
//     this.profilePicture,
//     this.bio,
//     this.location,
//     this.skills = const [],
//   });

//   factory JobSeekerApiModel.fromJson(Map<String, dynamic> json) =>
//       _$JobSeekerApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$JobSeekerApiModelToJson(this);

//   JobSeekerEntity toEntity() {
//     return JobSeekerEntity(
//       id: id,
//       userId: userId?.id,
//       userName: userId?.name,
//       profilePicture: profilePicture,
//       bio: bio,
//       location: location,
//       skills: skills,
//     );
//   }

//   factory JobSeekerApiModel.fromEntity(JobSeekerEntity entity) {
//     return JobSeekerApiModel(
//       id: entity.id,
//       userId: entity.userId != null
//           ? UserIdModel(
//               id: entity.userId!,
//               name: entity.userName ?? '',
//             )
//           : null,
//       profilePicture: entity.profilePicture,
//       bio: entity.bio,
//       location: entity.location,
//       skills: entity.skills,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         userId,
//         profilePicture,
//         bio,
//         location,
//         skills,
//       ];
// }

// @JsonSerializable()
// class UserIdModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String id;
//   final String name;

//   const UserIdModel({
//     required this.id,
//     required this.name,
//   });

//   factory UserIdModel.fromJson(Map<String, dynamic> json) =>
//       _$UserIdModelFromJson(json);

//   Map<String, dynamic> toJson() => _$UserIdModelToJson(this);

//   @override
//   List<Object?> get props => [id, name];
// }
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';

part 'job_seeker_api_model.g.dart';

@JsonSerializable()
class JobSeekerApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? userId; // Now a string
  final String? userName; // Add userName
  final String? profilePicture;
  final String? bio;
  final String? location;
  final List<String> skills;

  const JobSeekerApiModel({
    this.id,
    this.userId,
    this.userName, // Add userName
    this.profilePicture,
    this.bio,
    this.location,
    this.skills = const [],
  });

  factory JobSeekerApiModel.fromJson(Map<String, dynamic> json) =>
      _$JobSeekerApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobSeekerApiModelToJson(this);

  JobSeekerEntity toEntity() {
    return JobSeekerEntity(
      id: id,
      userId: userId,
      userName: userName,
      profilePicture: profilePicture,
      bio: bio,
      location: location,
      skills: skills,
    );
  }

  factory JobSeekerApiModel.fromEntity(JobSeekerEntity entity) {
    return JobSeekerApiModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      profilePicture: entity.profilePicture,
      bio: entity.bio,
      location: entity.location,
      skills: entity.skills,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        userName, // Add userName
        profilePicture,
        bio,
        location,
        skills,
      ];
}
