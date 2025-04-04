// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobApiModel _$JobApiModelFromJson(Map<String, dynamic> json) => JobApiModel(
      jobId: json['_id'] as String?,
      title: json['title'] as String,
      description: DescriptionApiModel.fromJson(
          json['description'] as Map<String, dynamic>),
      location: json['location'] as String,
      employer:
          EmployerApiModel.fromJson(json['employer'] as Map<String, dynamic>),
      salary: json['salary'] as num?,
      jobType: json['jobType'] as String,
      experienceLevel: json['experienceLevel'] as String,
      datePosted: json['datePosted'] == null
          ? null
          : DateTime.parse(json['datePosted'] as String),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      skillsRequired: (json['skillsRequired'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$JobApiModelToJson(JobApiModel instance) =>
    <String, dynamic>{
      '_id': instance.jobId,
      'title': instance.title,
      'description': instance.description,
      'employer': instance.employer,
      'location': instance.location,
      'salary': instance.salary,
      'jobType': instance.jobType,
      'experienceLevel': instance.experienceLevel,
      'datePosted': instance.datePosted?.toIso8601String(),
      'deadline': instance.deadline?.toIso8601String(),
      'skillsRequired': instance.skillsRequired,
    };
