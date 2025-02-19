import 'package:dartz/dartz.dart';
import 'package:work_hive_mobile/app/usecase/usecase.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/repository/job_repository.dart';

class GetAllJobsUsecase implements UsecaseWithoutParams<List<JobEntity>> {
  final IJobRepository _jobRepository;

  GetAllJobsUsecase({required IJobRepository jobRepository})
      : _jobRepository = jobRepository;

  @override
  Future<Either<Failure, List<JobEntity>>> call() {
    return _jobRepository.getJobs();
  }
}
