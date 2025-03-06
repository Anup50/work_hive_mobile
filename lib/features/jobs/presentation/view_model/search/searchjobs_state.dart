part of 'searchjobs_bloc.dart';

abstract class SearchjobsState extends Equatable {
  const SearchjobsState();

  @override
  List<Object?> get props => [];
}

class SearchjobsInitial extends SearchjobsState {}

class SearchJobsLoading extends SearchjobsState {}

class SearchJobsLoadingMore extends SearchjobsState {
  final List<JobEntity> jobs;

  const SearchJobsLoadingMore(this.jobs);

  @override
  List<Object?> get props => [jobs];
}

class SearchJobsLoaded extends SearchjobsState {
  final List<JobEntity> jobs;

  const SearchJobsLoaded(this.jobs);

  @override
  List<Object?> get props => [jobs];
}

class SearchJobsError extends SearchjobsState {
  final String message;

  const SearchJobsError(this.message);

  @override
  List<Object?> get props => [message];
}
