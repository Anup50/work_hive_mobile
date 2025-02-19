class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  //for emulator
  // static const String baseUrl = "http://10.0.2.2:3000/api/";
  static const String baseUrl = "http://192.168.18.11:3000/api/";
  // For iphone
  // static const String baseUrl = "http://localhost:3000/api/v1/";

  // ==================== User Routes ====================
  static const String login = "user/login";
  static const String register = "user/register";

  // ==================== JobSeeker Routes ====================
  static const String addJobseeker = "jobseeker/";
  static const String uploadProfilePicturee = "jobseeker/uploadImage";

  // ==================== Job Routes ====================
  static const String createJob = "job/";
  static const String deleteJob = "job/";
  static const String getAllJob = "job/getall";
  static const String getRecommended = "job/recommended";
  static const String getById = "job/";
}
