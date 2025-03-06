// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_jobs_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchJobsDto _$SearchJobsDtoFromJson(Map<String, dynamic> json) =>
    SearchJobsDto(
      success: json['success'] as bool,
      count: (json['count'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => JobApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchJobsDtoToJson(SearchJobsDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
