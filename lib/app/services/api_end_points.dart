class AppUrls {
  AppUrls._();

  static const String _baseUrl = 'http://10.0.20.36:8001/api/v1';
  static const String register = '$_baseUrl/auth/register-user';
  static const String login = '$_baseUrl/auth/login';
  static const String forgotPassword = '$_baseUrl/auth/forgot-password';
  static const String verifyOtp = '$_baseUrl/auth/verify-reset-password-otp';
  static const String resetPassword = '$_baseUrl/auth/reset-password';
  static const String getProfile = '$_baseUrl/users/me';
  static const String updateProfile = '$_baseUrl/users/update';

}
