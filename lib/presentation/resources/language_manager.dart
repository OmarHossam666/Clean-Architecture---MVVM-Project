enum LanguageType { arabic, english }

class LanguageManager {
  LanguageManager._();

  static const String arabic = 'ar';
  static const String english = 'en';

  static String getLanguageCode(LanguageType languageType) {
    switch (languageType) {
      case LanguageType.arabic:
        return arabic;
      case LanguageType.english:
        return english;
    }
  }
}
