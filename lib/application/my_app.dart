import 'package:clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/themes_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // Implementing Singleton Design Pattern on Application Class
  const MyApp._internal();

  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringsManager.appName.tr(),
      onGenerateRoute: RoutesManager.generateRoute,
      initialRoute: RoutesManager.splashRoute,
      theme: ThemesManager.lightTheme,
      themeMode: ThemeMode.light,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
