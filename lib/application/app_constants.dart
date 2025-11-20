class AppConstants {
  AppConstants._();

  static const String baseUrl = 'https://omar-hossam.wiremockapi.cloud/';
  static const String loginEndpoint = '/users/login/';
  static const String forgotPasswordEndpoint = '/users/forgot-password/';
  static const String registerEndpoint = '/users/register/';
  static const String empty = '';
  static const int zero = 0;
  static const Duration timeOut = Duration(seconds: 60);
  static const String authorization = 'Authorization Token';
}
