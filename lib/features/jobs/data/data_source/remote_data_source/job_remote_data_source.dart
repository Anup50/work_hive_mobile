import 'package:dio/dio.dart';
import 'package:work_hive_mobile/app/constants/api_endpoints.dart';
import 'package:work_hive_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:work_hive_mobile/features/jobs/data/data_source/job_data_source.dart';
import 'package:work_hive_mobile/features/jobs/data/dto/get_all_job_dto.dart';
import 'package:work_hive_mobile/features/jobs/data/dto/get_job_by_id_dto.dart';
import 'package:work_hive_mobile/features/jobs/data/dto/get_recommended_job_dto.dart';
import 'package:work_hive_mobile/features/jobs/data/dto/search_jobs_dto.dart';
import 'package:work_hive_mobile/features/jobs/data/model/job_api_model.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';

class JobRemoteDataSource implements IJobDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;
  JobRemoteDataSource(
      {required Dio dio, required TokenSharedPrefs tokenSharedPrefs})
      : _dio = dio,
        _tokenSharedPrefs = tokenSharedPrefs;

  Future<String?> _getToken() async {
    final tokenResult = await _tokenSharedPrefs.getToken();
    return tokenResult.getOrElse(() => '');
  }

  @override
  Future<void> createJob(JobEntity job) {
    // TODO: implement createJob
    throw UnimplementedError();
  }

  @override
  Future<void> deleteJob(String id) {
    // TODO: implement deleteJob
    throw UnimplementedError();
  }

  @override
  Future<JobEntity> getJob(String id) async {
    try {
      var response = await _dio.get(
        ApiEndpoints.getById + id,
      );

      if (response.statusCode == 200) {
        var jobDTO = GetJobByIdDTO.fromJson(response.data);
        return jobDTO.data.toEntity();
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
  Future<List<JobEntity>> getJobs() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllJob);
      if (response.statusCode == 200) {
        // Convert API response to DTO
        var jobDTO = GetAllJobDTO.fromJson(response.data);
        // Convert DTO to Entity
        return JobApiModel.toEntityList(jobDTO.data);
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
  Future<List<JobEntity>> getRecommended(String jobSeekerId) async {
    try {
      final token = await _getToken();
      final response = await _dio.get(ApiEndpoints.getRecommended + jobSeekerId,
          options: Options(
              headers:
                  token != null ? {'Authorization': 'Bearer $token'} : {}));

      if (response.statusCode == 200) {
        var recJobDTO = GetRecommendedJobDto.fromJson(response.data);
        return JobApiModel.toEntityList(recJobDTO.data);
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
  @override
  Future<List<JobEntity>> searchJobs(String query) async {
    try {
      final response = await _dio.get(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.searchJobs}$query",
      );

      if (response.statusCode == 200) {
        // Use SearchJobsDTO to parse the response
        final searchDTO = SearchJobsDto.fromJson(response.data);
        return JobApiModel.toEntityList(searchDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? "Failed to search jobs");
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}
