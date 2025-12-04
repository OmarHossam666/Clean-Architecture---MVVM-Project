import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/application/my_app.dart';
import 'package:clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initDependencyInjection();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        LanguageManager.englishLocale,
        LanguageManager.arabicLocale,
      ],
      path: AssetsManager.translationBasePath,
      fallbackLocale: LanguageManager.englishLocale,
      child: Phoenix(child: MyApp()),
    ),
  );
}
