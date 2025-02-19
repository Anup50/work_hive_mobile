// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployerApiModel _$EmployerApiModelFromJson(Map<String, dynamic> json) =>
    EmployerApiModel(
      id: json['_id'] as String?,
      companyName: json['companyName'] as String,
      companyLogo: json['companyLogo'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$EmployerApiModelToJson(EmployerApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'companyName': instance.companyName,
      'companyLogo': instance.companyLogo,
      'location': instance.location,
    };
