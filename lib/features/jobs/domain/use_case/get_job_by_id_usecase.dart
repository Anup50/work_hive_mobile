import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:work_hive_mobile/app/usecase/usecase.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/repository/job_repository.dart';

class GetJobByIdParams extends Equatable {
  final String id;

  const GetJobByIdParams({required this.id});

  const GetJobByIdParams.empty() : id = '_empty.string';
  @override
  List<Object?> get props => [id];
}

class GetJobByIdUsecase implements UsecaseWithParams<void, GetJobByIdParams> {
  final IJobRepository _jobRepository;

  GetJobByIdUsecase({required IJobRepository jobRepository})
      : _jobRepository = jobRepository;

  @override
  Future<Either<Failure, JobEntity>> call(GetJobByIdParams params) {
    return _jobRepository.getJob(params.id);
  }
}
