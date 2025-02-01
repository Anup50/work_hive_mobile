// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_seeker_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobSeekerApiModel _$JobSeekerApiModelFromJson(Map<String, dynamic> json) =>
    JobSeekerApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      profilePicture: json['profilePicture'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$JobSeekerApiModelToJson(JobSeekerApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'profilePicture': instance.profilePicture,
      'bio': instance.bio,
      'location': instance.location,
      'skills': instance.skills,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
