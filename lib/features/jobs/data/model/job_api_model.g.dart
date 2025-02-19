// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobApiModel _$JobApiModelFromJson(Map<String, dynamic> json) => JobApiModel(
      jobId: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      employer:
          EmployerApiModel.fromJson(json['employer'] as Map<String, dynamic>),
      salary: json['salary'] as num?,
      jobType: json['jobType'] as String,
      experienceLevel: json['experienceLevel'] as String,
      datePosted: DateTime.parse(json['datePosted'] as String),
      deadline: DateTime.parse(json['deadline'] as String),
      skillsRequired: (json['skillsRequired'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isActive: json['isActive'] as bool,
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
      'datePosted': instance.datePosted.toIso8601String(),
      'deadline': instance.deadline.toIso8601String(),
      'skillsRequired': instance.skillsRequired,
      'isActive': instance.isActive,
    };
