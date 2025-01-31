import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';

part 'job_seeker_api_model.g.dart';

@JsonSerializable()
class JobSeekerApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? userId;
  final String? profilePicture;
  final String? bio;
  final String? location;
  final List<String> skills;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const JobSeekerApiModel({
    this.id,
    this.userId,
    this.profilePicture,
    this.bio,
    this.location,
    this.skills = const [],
    this.createdAt,
    this.updatedAt,
  });
  factory JobSeekerApiModel.fromJson(Map<String, dynamic> json) =>
      _$JobSeekerApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$JobSeekerApiModelToJson(this);

  // To Entity
  JobSeekerEntity toEntity() {
    return JobSeekerEntity(
      userId: userId,
      profilePicture: profilePicture,
      bio: bio,
      location: location,
      skills: skills,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // From Entity
  factory JobSeekerApiModel.fromEntity(JobSeekerEntity entity) {
    return JobSeekerApiModel(
      userId: entity.userId,
      profilePicture: entity.profilePicture,
      bio: entity.bio,
      location: entity.location,
      skills: entity.skills,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
  @override
  List<Object?> get props => [
        id,
        userId,
        profilePicture,
        bio,
        location,
        skills,
        createdAt,
        updatedAt,
      ];
}
