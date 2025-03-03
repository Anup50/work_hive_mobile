// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String,
      role: json['role'] as String,
      employerId: json['employerId'] as String?,
      jobSeekerId: json['jobSeekerId'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'role': instance.role,
      'employerId': instance.employerId,
      'jobSeekerId': instance.jobSeekerId,
    };
