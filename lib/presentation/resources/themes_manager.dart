import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/fonts_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ThemesManager {
  ThemesManager._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: ColorsManager.white,
    primaryColor: ColorsManager.primary,
    primaryColorDark: ColorsManager.primaryDark,
    primaryColorLight: ColorsManager.primaryLight,
    fontFamily: FontsManager.fontFamily,
    splashColor: ColorsManager.primaryDark,
    shadowColor: ColorsManager.grey,
    hintColor: ColorsManager.hintText,

    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.primary,
      shadowColor: ColorsManager.grey,
      titleTextStyle: StylesManager.titleTextStyle.copyWith(
        color: ColorsManager.white,
      ),
      centerTitle: true,
      elevation: ValuesManager.elevation4,
    ),

    cardTheme: CardThemeData(
      color: ColorsManager.white,
      shadowColor: ColorsManager.grey,
      margin: const EdgeInsets.all(ValuesManager.margin16),
      elevation: ValuesManager.elevation4,
    ),

    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorsManager.grey,
      buttonColor: ColorsManager.primary,
      splashColor: ColorsManager.primaryDark,
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorsManager.primary,
        textStyle: StylesManager.buttonTextStyle,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primary,
        foregroundColor: ColorsManager.buttonText,
        disabledBackgroundColor: ColorsManager.grey,
        disabledForegroundColor: ColorsManager.buttonText,
        minimumSize: const Size.fromHeight(ValuesManager.height50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ValuesManager.radius16),
          side: BorderSide(color: ColorsManager.border, width: 1),
        ),
        padding: const EdgeInsets.all(ValuesManager.padding16),
        textStyle: StylesManager.buttonTextStyle,
        iconColor: ColorsManager.primary,
        iconSize: ValuesManager.iconSize24,
      ),
    ),

    textTheme: TextTheme(
      titleLarge: StylesManager.titleTextStyle,
      headlineLarge: StylesManager.sectionHeaderTextStyle,
      bodyLarge: StylesManager.bodyTextStyle,
      labelLarge: StylesManager.buttonTextStyle,
    ),

    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: ColorsManager.white,
      focusColor: ColorsManager.primary,
      contentPadding: const EdgeInsets.all(ValuesManager.inputFieldPadding),
      hintStyle: StylesManager.hintTextStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.inputFieldRadius),
        borderSide: BorderSide(color: ColorsManager.border, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.inputFieldRadius),
        borderSide: BorderSide(color: ColorsManager.primary, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.inputFieldRadius),
        borderSide: BorderSide(color: ColorsManager.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.inputFieldRadius),
        borderSide: BorderSide(color: ColorsManager.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.inputFieldRadius),
        borderSide: BorderSide(color: ColorsManager.error, width: 2),
      ),
    ),
  );
}
