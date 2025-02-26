part of 'job_bloc.dart';

class JobState extends Equatable {
  final bool isLoading;
  final List<JobEntity> jobs;
  final String error;

  const JobState({
    required this.isLoading,
    required this.jobs,
    required this.error,
  });

  factory JobState.initial() {
    return const JobState(
      error: '',
      jobs: [],
      isLoading: false,
    );
  }

  JobState copyWith({
    bool? isLoading,
    List<JobEntity>? jobs,
    String? error,
  }) {
    return JobState(
      isLoading: isLoading ?? this.isLoading,
      jobs: jobs ?? this.jobs,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [jobs, isLoading, error];
}
