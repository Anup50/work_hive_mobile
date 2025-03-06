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

class NavigateDashEvent extends JobSeekerEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateDashEvent({
    required this.context,
    required this.destination,
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

class LoadJobSeekerProfileEvent extends JobSeekerEvent {
  final String id;

  const LoadJobSeekerProfileEvent({required this.id});

  @override
  List<Object> get props => [id];
}

// Event to update the job seeker profile
class UpdateJobSeekerEvent extends JobSeekerEvent {
  final String id;
  final JobSeekerEntity jobSeeker;

  const UpdateJobSeekerEvent({
    required this.id,
    required this.jobSeeker,
  });

  @override
  List<Object> get props => [id, jobSeeker];
}
