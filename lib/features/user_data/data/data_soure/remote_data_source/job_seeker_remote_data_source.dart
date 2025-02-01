import 'dart:io';

import 'package:dio/dio.dart';
import 'package:work_hive_mobile/app/constants/api_endpoints.dart';
import 'package:work_hive_mobile/features/user_data/data/data_soure/job_seeker_data_source.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';

class JobSeekerRemoteDataSource implements IJobSeekerDataSource {
  final Dio _dio;
  JobSeekerRemoteDataSource(this._dio);
  @override
  Future<void> addJobSeekerData(JobSeekerEntity jobseeker) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.addJobseeker,
        data: {
          "userId": jobseeker.userId,
          "skill": jobseeker.skills,
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
  Future<JobSeekerEntity> getUserData() {
    throw UnimplementedError();
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
        // Extract the image name from the response
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
}
