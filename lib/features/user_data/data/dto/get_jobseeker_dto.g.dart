// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_jobseeker_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetJobseekerDto _$GetJobseekerDtoFromJson(Map<String, dynamic> json) =>
    GetJobseekerDto(
      success: json['success'] as bool,
      data: JobSeekerApiModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetJobseekerDtoToJson(GetJobseekerDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
