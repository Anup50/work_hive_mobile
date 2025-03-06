// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_seeker_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobSeekerApiModel _$JobSeekerApiModelFromJson(Map<String, dynamic> json) =>
    JobSeekerApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      profilePicture: json['profilePicture'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$JobSeekerApiModelToJson(JobSeekerApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'profilePicture': instance.profilePicture,
      'bio': instance.bio,
      'location': instance.location,
      'skills': instance.skills,
    };
