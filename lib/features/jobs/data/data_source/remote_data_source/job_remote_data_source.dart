import 'package:dio/dio.dart';
import 'package:work_hive_mobile/app/constants/api_endpoints.dart';
import 'package:work_hive_mobile/features/jobs/data/data_source/job_data_source.dart';
import 'package:work_hive_mobile/features/jobs/data/dto/get_all_job_dto.dart';
import 'package:work_hive_mobile/features/jobs/data/dto/get_job_by_id_dto.dart';
import 'package:work_hive_mobile/features/jobs/data/model/job_api_model.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';

class JobRemoteDataSource implements IJobDataSource {
  final Dio _dio;

  JobRemoteDataSource(this._dio);

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
}
