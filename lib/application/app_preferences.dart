import 'package:clean_architecture_mvvm/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  static const String _languageKey = 'language_key';
  static const String _onboardingKey = 'onboarding_key';
  static const String _isLoggedInKey = 'is_logged_in_key';
  static const String _isRegisteredKey = 'is_registered_key';

  String getLanguage() {
    String? language = sharedPreferences.getString(_languageKey);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageManager.english;
    }
  }

  Future<void> setOnboardingCompleted(bool isCompleted) async {
    await sharedPreferences.setBool(_onboardingKey, isCompleted);
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    await sharedPreferences.setBool(_isLoggedInKey, isLoggedIn);
  }

  Future<void> setRegistered(bool isRegistered) async {
    await sharedPreferences.setBool(_isRegisteredKey, isRegistered);
  }

  bool isOnboardingCompleted() {
    return sharedPreferences.getBool(_onboardingKey) ?? false;
  }

  bool isLoggedIn() {
    return sharedPreferences.getBool(_isLoggedInKey) ?? false;
  }

  bool isRegistered() {
    return sharedPreferences.getBool(_isRegisteredKey) ?? false;
  }

  Future<void> clear() async {
    await sharedPreferences.clear();
  }

  
}
