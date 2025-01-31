part of 'job_seeker_bloc.dart';

sealed class JobSeekerEvent extends Equatable {
  const JobSeekerEvent();

  @override
  List<Object> get props => [];
}

class UploadImage extends JobSeekerEvent {
  final File file;

  const UploadImage({
    required this.file,
  });
}

class AddJobSeeker extends JobSeekerEvent {
  final BuildContext context;
  final String? userId;
  final String? profilePicture;
  final String? bio;
  final String? location;
  final List<String> skills;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AddJobSeeker({
    required this.context,
    this.userId,
    this.profilePicture,
    this.bio,
    this.location,
    this.skills = const [],
    this.createdAt,
    this.updatedAt,
  });
}
