import 'package:dartz/dartz.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';

abstract interface class IJobRepository {
  Future<Either<Failure, List<JobEntity>>> getJobs();
  Future<Either<Failure, JobEntity>> getJob(String id);
  Future<Either<Failure, void>> createJob(JobEntity job);
  Future<Either<Failure, void>> deleteJob(String id);
}
