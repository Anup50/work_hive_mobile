import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';

abstract interface class IJobSeekerRepository {
  Future<Either<Failure, void>> addJobSeekerData(JobSeekerEntity jobseeker);
  Future<Either<Failure, void>> updateUserData(
      String id, JobSeekerEntity jobseeker);

  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, JobSeekerEntity>> getUserData(String id);
}
