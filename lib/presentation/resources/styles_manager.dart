import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StylesManager {
  StylesManager._();

  static const TextStyle titleTextStyle = TextStyle(
    color: ColorsManager.primaryText,
    fontSize: FontsManager.titleSize,
    fontWeight: FontsManager.bold,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    color: ColorsManager.primaryText,
    fontSize: FontsManager.subTitleSize,
    fontWeight: FontsManager.regular,
  );

  static const TextStyle sectionHeaderTextStyle = TextStyle(
    color: ColorsManager.primaryText,
    fontSize: FontsManager.sectionHeaderSize,
    fontWeight: FontsManager.bold,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    color: ColorsManager.primaryText,
    fontSize: FontsManager.subTitleSize,
    fontWeight: FontsManager.medium,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: ColorsManager.buttonText,
    fontSize: FontsManager.titleSize,
    fontWeight: FontsManager.regular,
  );

  static const TextStyle hintTextStyle = TextStyle(
    color: ColorsManager.hintText,
    fontSize: FontsManager.subTitleSize,
    fontWeight: FontsManager.regular,
  );

  static const TextStyle skipTextStyle = TextStyle(
    color: ColorsManager.primary,
    fontSize: FontsManager.titleSize,
    fontWeight: FontsManager.medium,
  );

  static const TextStyle authenticationTextStyle = TextStyle(
    color: ColorsManager.primary,
    fontSize: FontsManager.bodySize,
    fontWeight: FontsManager.medium,
  );

  static const TextStyle errorTextStyle = TextStyle(
    color: ColorsManager.error,
    fontSize: FontsManager.bodySize,
    fontWeight: FontsManager.bold,
  );
}
