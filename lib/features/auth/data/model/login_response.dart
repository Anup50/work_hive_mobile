import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String token;
  final String role;

  @JsonKey(name: 'employerId')
  final String? employerId;

  @JsonKey(name: 'jobSeekerId')
  final String? jobSeekerId;

  LoginResponse({
    required this.token,
    required this.role,
    this.employerId,
    this.jobSeekerId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
