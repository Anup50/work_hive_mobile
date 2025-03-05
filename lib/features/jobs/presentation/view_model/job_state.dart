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
  //GetById
  final bool isLoadingJob;
  final JobEntity? job;
  final String jobError;
  const JobState({
    required this.isLoading,
    required this.jobs,
    required this.error,
    required this.isLoadingRecommended,
    required this.recommendedJobs,
    required this.recommendedError,
    required this.isLoadingJob,
    this.job,
    required this.jobError,
  });

  factory JobState.initial() {
    return const JobState(
      error: '',
      jobs: [],
      isLoading: false,
      recommendedError: '',
      recommendedJobs: [],
      isLoadingRecommended: false,
      isLoadingJob: false,
      job: null,
      jobError: '',
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
    //get job
    bool? isLoadingJob,
    JobEntity? job,
    String? jobError,
  }) {
    return JobState(
      isLoading: isLoading ?? this.isLoading,
      jobs: jobs ?? this.jobs,
      error: error ?? this.error,
      // for recommended jobs
      isLoadingRecommended: isLoadingRecommended ?? this.isLoadingRecommended,
      recommendedError: recommendedError ?? this.recommendedError,
      recommendedJobs: recommendedJobs ?? this.recommendedJobs,
      isLoadingJob: isLoadingJob ?? this.isLoadingJob,
      job: job ?? this.job,
      jobError: jobError ?? this.jobError,
    );
  }

  @override
  List<Object?> get props => [
        jobs,
        isLoading,
        error,
        recommendedJobs,
        isLoadingRecommended,
        recommendedError,
        isLoadingJob,
        job,
        jobError,
      ];
}
