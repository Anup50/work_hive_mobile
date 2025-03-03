part of 'job_bloc.dart';

class JobState extends Equatable {
  //All Jobs
  final bool isLoading;
  final List<JobEntity> jobs;
  final String error;
  // Recommended
  final bool isLoadingRecommended;
  final List<JobEntity> recommendedJobs;

  final String recommendedError;

  const JobState({
    required this.isLoading,
    required this.jobs,
    required this.error,
    required this.isLoadingRecommended,
    required this.recommendedJobs,
    required this.recommendedError,
  });

  factory JobState.initial() {
    return const JobState(
      error: '',
      jobs: [],
      isLoading: false,
      recommendedError: '',
      recommendedJobs: [],
      isLoadingRecommended: false,
    );
  }

  JobState copyWith({
    bool? isLoading,
    List<JobEntity>? jobs,
    String? error,
    // recommended jobs
    bool? isLoadingRecommended,
    List<JobEntity>? recommendedJobs,
    String? recommendedError,
  }) {
    return JobState(
      isLoading: isLoading ?? this.isLoading,
      jobs: jobs ?? this.jobs,
      error: error ?? this.error,
      // for recommended jobs
      isLoadingRecommended: isLoadingRecommended ?? this.isLoadingRecommended,
      recommendedError: recommendedError ?? this.recommendedError,
      recommendedJobs: recommendedJobs ?? this.recommendedJobs,
    );
  }

  @override
  List<Object> get props => [
        jobs,
        isLoading,
        error,
        recommendedJobs,
        isLoadingRecommended,
        recommendedError,
      ];
}
