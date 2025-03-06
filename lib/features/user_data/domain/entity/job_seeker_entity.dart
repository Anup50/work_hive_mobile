import 'package:equatable/equatable.dart';

class JobSeekerEntity extends Equatable {
  final String? id;
  final String? userId;
  final String? userName;
  final String? profilePicture;
  final String? bio;
  final String? location;
  final List<String> skills;

  const JobSeekerEntity({
    this.id,
    this.userId,
    this.userName,
    this.profilePicture,
    this.bio,
    this.location,
    this.skills = const [],
  });

  const JobSeekerEntity.empty()
      : id = null,
        userId = null,
        userName = null,
        profilePicture = null,
        bio = null,
        location = null,
        skills = const [];

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        profilePicture,
        bio,
        location,
        skills,
      ];
}
