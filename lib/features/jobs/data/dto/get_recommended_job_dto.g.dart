// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_recommended_job_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRecommendedJobDto _$GetRecommendedJobDtoFromJson(
        Map<String, dynamic> json) =>
    GetRecommendedJobDto(
      success: json['success'] as bool,
      count: (json['count'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => JobApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetRecommendedJobDtoToJson(
        GetRecommendedJobDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
