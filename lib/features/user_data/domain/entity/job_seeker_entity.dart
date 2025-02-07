import 'package:equatable/equatable.dart';

class JobSeekerEntity extends Equatable {
  final String? userId;
  final String? profilePicture;
  final String? bio;
  final String? location;
  final List<String> skills;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const JobSeekerEntity({
    this.userId,
    this.profilePicture,
    this.bio,
    this.location,
    this.skills = const [],
    this.createdAt,
    this.updatedAt,
  });

  const JobSeekerEntity.empty()
      : userId = null,
        profilePicture = null,
        bio = null,
        location = null,
        skills = const [],
        createdAt = null,
        updatedAt = null;

  @override
  List<Object?> get props =>
      [userId, profilePicture, bio, location, skills, createdAt, updatedAt];
}
