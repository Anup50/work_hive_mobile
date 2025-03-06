part of 'job_seeker_bloc.dart';

class JobSeekerState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  final JobSeekerEntity? jobSeeker;
  final String? errorMessage;

  const JobSeekerState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
    this.jobSeeker,
    this.errorMessage,
  });

  // Initial state with default values
  const JobSeekerState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null,
        jobSeeker = null,
        errorMessage = null;

  // Create a copy of the state with updated values
  JobSeekerState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
    JobSeekerEntity? jobSeeker,
    String? errorMessage, // Fixed typo here
  }) {
    return JobSeekerState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
      jobSeeker: jobSeeker ?? this.jobSeeker,
      errorMessage: errorMessage ?? this.errorMessage, // Fixed typo here
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isSuccess, imageName, jobSeeker, errorMessage];
}
