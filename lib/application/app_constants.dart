class AppConstants {
  AppConstants._();

  // API Configuration
  static const String baseUrl = 'https://omar-hossam.wiremockapi.cloud';
  static const String loginEndpoint = '/users/login/';
  static const String forgotPasswordEndpoint = '/users/forgot-password/';
  static const String registerEndpoint = '/users/register/';
  static const String homeEndpoint = '/home/';
  static const String storeDetailsEndpoint = '/store/';

  // Default Values
  static const String empty = '';
  static const int zero = 0;

  // Network Configuration
  static const Duration timeOut = Duration(seconds: 60);
  static const String authorization = 'Authorization Token';

  // Cache Configuration
  static const String homeCacheKey = 'home';
  static const String storeDetailsCacheKey = 'storeDetails';
  static const int cacheDurationMs = 60 * 1000; // 60 seconds in milliseconds
}
