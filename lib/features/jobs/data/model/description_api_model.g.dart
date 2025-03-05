// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'description_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DescriptionApiModel _$DescriptionApiModelFromJson(Map<String, dynamic> json) =>
    DescriptionApiModel(
      summary: json['summary'] as String,
      responsibilities: (json['responsibilities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DescriptionApiModelToJson(
        DescriptionApiModel instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'responsibilities': instance.responsibilities,
    };
