import 'package:clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';

enum LanguageType { arabic, english }

class LanguageManager {
  LanguageManager._();

  static const String translationPath = AssetsManager.translationBasePath;
  static const String arabic = 'ar';
  static const String english = 'en';
  static const Locale arabicLocale = Locale(arabic, 'SA');
  static const Locale englishLocale = Locale(english, 'US');

  static String getLanguageCode(LanguageType languageType) {
    switch (languageType) {
      case LanguageType.arabic:
        return arabic;
      case LanguageType.english:
        return english;
    }
  }
}
