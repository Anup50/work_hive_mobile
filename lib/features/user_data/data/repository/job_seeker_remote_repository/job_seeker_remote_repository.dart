import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName =
          await _jobSeekerRemoteDataSource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserData(
      String id, JobSeekerEntity jobseeker) async {
    try {
      await _jobSeekerRemoteDataSource.updateUserData(id, jobseeker);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, JobSeekerEntity>> getUserData(String id) async {
    try {
      if (id.isEmpty) {
        throw Exception("Invalid jobseeker ID"); // Or a specific Failure
      }
      print('Fetching user data for ID: $id'); // 🟨 Add debug logging
      final jobSeekerEntity = await _jobSeekerRemoteDataSource.getUserData(id);
      print('Received entity: $jobSeekerEntity'); // 🟨 Verify response
      return Right(jobSeekerEntity);
    } on DioException catch (dioError) {
      // 🚨 Specific Dio handling
      print('Dio Error: ${dioError.response?.data}'); // Actual server response
      return Left(ApiFailure(
        message: dioError.response?.data['message'] ?? 'Network error',
        statusCode: dioError.response?.statusCode ?? 500,
      ));
    } catch (e, stackTrace) {
      // 🚨 Capture stack trace
      print('Unexpected error: $e');
      print('Stack trace: $stackTrace'); // 🟨 Critical for null errors
      return const Left(ApiFailure(message: 'Unexpected error occurred'));
    }
  }
}
