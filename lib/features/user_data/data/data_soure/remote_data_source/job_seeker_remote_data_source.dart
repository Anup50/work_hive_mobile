import 'dart:io';

import 'package:dio/dio.dart';
import 'package:work_hive_mobile/app/constants/api_endpoints.dart';
import 'package:work_hive_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:work_hive_mobile/features/user_data/data/data_soure/job_seeker_data_source.dart';
import 'package:work_hive_mobile/features/user_data/data/dto/get_jobseeker_dto.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';

class JobSeekerRemoteDataSource implements IJobSeekerDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;
  JobSeekerRemoteDataSource(this._dio, this._tokenSharedPrefs);

  Future<String?> _getToken() async {
    final tokenResult = await _tokenSharedPrefs.getToken();
    return tokenResult.getOrElse(() => '');
  }

  Future<String?> _getId() async {
    final tokenResult = await _tokenSharedPrefs.getJobSeekerId();
    return tokenResult.getOrElse(() => '');
  }

  @override
  Future<void> addJobSeekerData(JobSeekerEntity jobseeker) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.addJobseeker,
        data: {
          "userId": jobseeker.userId,
          "skills": jobseeker.skills,
          "location": jobseeker.location,
          "bio": jobseeker.bio,
          "profilePicture": jobseeker.profilePicture,
        },
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadProfilePicturee,
        data: formData,
      );

      if (response.statusCode == 200) {
        final str = response.data['data'];

        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<JobSeekerEntity> getUserData(String id) async {
    try {
      final token = await _getToken(); // Get the token
      print("Fetching jobseeker with ID: $id | Token: $token");

      final response = await _dio.get(
        '${ApiEndpoints.getJobSeeker}$id', // URL: jobseeker/simplegetbyid/{id}
        options: Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : {},
        ),
      );

      print("Response: ${response.data}");
      return GetJobseekerDto.fromJson(response.data).data.toEntity();
    } on DioException catch (e) {
      print("Dio Error: ${e.response?.data}"); // Detailed error log
      throw Exception("Failed to fetch user: ${e.message}");
    }
  }

  @override
  Future<void> updateUserData(String id, JobSeekerEntity jobseeker) async {
    try {
      final id = await _getId();
      print("id in update: $id");
      final token = await _getToken();
      print("Token in update: $token");
      Response response = await _dio.put(
        ApiEndpoints.updateJobseeker + id!,
        data: {
          "userId": jobseeker.userId,
          "skills": jobseeker.skills,
          "location": jobseeker.location,
          "bio": jobseeker.bio,
          "profilePicture": jobseeker.profilePicture,
        },
        options: Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : {},
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception("Failed to update user: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unknown error: ${e.toString()}");
    }
  }
}
