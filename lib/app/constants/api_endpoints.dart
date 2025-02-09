class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/";
  // For iphone
  // static const String baseUrl = "http://localhost:3000/api/v1/";

  // ==================== User Routes ====================
  static const String login = "user/login";
  static const String register = "user/register";

  // ==================== JobSeeker Routes ====================
  static const String addJobseeker = "jobseeker/";
  static const String uploadProfilePicturee = "jobseeker/uploadImage";
}
