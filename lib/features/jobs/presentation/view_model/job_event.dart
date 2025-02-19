part of 'job_bloc.dart';

sealed class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class LoadJobs extends JobEvent {}

class CreateJob extends JobEvent {
  final String title;

  const CreateJob({required this.title});

  @override
  List<Object> get props => [title];
}

class GetJob extends JobEvent {
  final String id;

  const GetJob({required this.id});

  @override
  List<Object> get props => [id];
}
