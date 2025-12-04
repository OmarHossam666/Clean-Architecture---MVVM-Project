import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/application/my_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initDependencyInjection();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}
