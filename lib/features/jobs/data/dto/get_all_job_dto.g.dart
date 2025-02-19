// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_job_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllJobDTO _$GetAllJobDTOFromJson(Map<String, dynamic> json) => GetAllJobDTO(
      success: json['success'] as bool,
      count: (json['count'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => JobApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllJobDTOToJson(GetAllJobDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
