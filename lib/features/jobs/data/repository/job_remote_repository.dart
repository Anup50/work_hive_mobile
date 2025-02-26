import 'package:dartz/dartz.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/jobs/data/data_source/remote_data_source/job_remote_data_source.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/repository/job_repository.dart';

class JobRemoteRepository implements IJobRepository {
  final JobRemoteDataSource _jobRemoteDataSource;

  JobRemoteRepository(this._jobRemoteDataSource);

  @override
  Future<Either<Failure, void>> createJob(JobEntity job) {
    // TODO: implement createJob
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteJob(String id) {
    // TODO: implement deleteJob
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, JobEntity>> getJob(String id) async {
    try {
      final job = await _jobRemoteDataSource.getJob(id);
      return Right(job);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> getJobs() async {
    try {
      final jobs = await _jobRemoteDataSource.getJobs();
      return Right(jobs);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
