import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/user_data/data/data_soure/remote_data_source/job_seeker_remote_data_source.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';
import 'package:work_hive_mobile/features/user_data/domain/repository/job_seeker_repository.dart';

class JobSeekerRemoteRepository implements IJobSeekerRepository {
  final JobSeekerRemoteDataSource _jobSeekerRemoteDataSource;
  JobSeekerRemoteRepository(this._jobSeekerRemoteDataSource);
  @override
  Future<Either<Failure, void>> addJobSeekerData(
      JobSeekerEntity jobseeker) async {
    try {
      await _jobSeekerRemoteDataSource.addJobSeekerData(jobseeker);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, JobSeekerEntity>> getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName =
          await _jobSeekerRemoteDataSource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
