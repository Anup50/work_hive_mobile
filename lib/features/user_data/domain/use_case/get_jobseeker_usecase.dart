import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:work_hive_mobile/app/usecase/usecase.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';
import 'package:work_hive_mobile/features/user_data/domain/repository/job_seeker_repository.dart';

class GetJobSeekerParams extends Equatable {
  final String id;

  const GetJobSeekerParams({required this.id});

  const GetJobSeekerParams.empty() : id = '_empty.string';
  @override
  List<Object?> get props => [id];
}

class GetJobseekerUsecase
    implements UsecaseWithParams<void, GetJobSeekerParams> {
  final IJobSeekerRepository _jobSeekerRepository;

  GetJobseekerUsecase({required IJobSeekerRepository jobSeekerRepository})
      : _jobSeekerRepository = jobSeekerRepository;

  @override
  Future<Either<Failure, JobSeekerEntity>> call(GetJobSeekerParams params) {
    return _jobSeekerRepository.getUserData(params.id);
  }
}
