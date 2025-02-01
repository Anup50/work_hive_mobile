part of 'job_seeker_bloc.dart';

class JobSeekerState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;

  const JobSeekerState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
  });
  const JobSeekerState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null;
  JobSeekerState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
  }) {
    return JobSeekerState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName];
}
