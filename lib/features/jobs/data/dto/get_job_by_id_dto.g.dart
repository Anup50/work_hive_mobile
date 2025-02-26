// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_job_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetJobByIdDTO _$GetJobByIdDTOFromJson(Map<String, dynamic> json) =>
    GetJobByIdDTO(
      success: json['success'] as bool,
      data: JobApiModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetJobByIdDTOToJson(GetJobByIdDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
