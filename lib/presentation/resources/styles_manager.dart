import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/fonts_manager.dart';
import 'package:flutter/material.dart';

class StylesManager {
  StylesManager._();

  // Display Styles
  static const TextStyle displayLarge = TextStyle(
    color: ColorsManager.primaryText,
    fontSize: 32.0,
    fontWeight: FontsManager.bold,
    letterSpacing: -0.5,
  );

  static const TextStyle displayMedium = TextStyle(
    color: ColorsManager.primaryText,
    fontSize: 24.0,
    fontWeight: FontsManager.bold,
    letterSpacing: 0,
  );

  // Title Styles
  static const TextStyle titleTextStyle = TextStyle(
    color: ColorsManager.white,
    fontSize: FontsManager.titleSize,
    fontWeight: FontsManager.bold,
  );

  static const TextStyle titleLarge = TextStyle(
    color: ColorsManager.primaryText,
    fontSize: 20.0,
    fontWeight: FontsManager.semiBold,
    letterSpacing: 0.15,
  );

  // Subtitle Styles
  static const TextStyle subtitleTextStyle = TextStyle(
    color: ColorsManager.secondaryText,
    fontSize: FontsManager.subTitleSize,
    fontWeight: FontsManager.regular,
  );

  static const TextStyle subtitleMedium = TextStyle(
    color: ColorsManager.secondaryText,
    fontSize: FontsManager.subTitleSize,
    fontWeight: FontsManager.medium,
    letterSpacing: 0.1,
  );

  // Section Header Styles
  static const TextStyle sectionHeaderTextStyle = TextStyle(
    color: ColorsManager.primaryText,
    fontSize: FontsManager.sectionHeaderSize,
    fontWeight: FontsManager.bold,
  );

  // Body Styles
  static const TextStyle bodyTextStyle = TextStyle(
    color: ColorsManager.secondaryText,
    fontSize: FontsManager.subTitleSize,
    fontWeight: FontsManager.medium,
  );

  static const TextStyle bodyLarge = TextStyle(
    color: ColorsManager.primaryText,
    fontSize: 16.0,
    fontWeight: FontsManager.regular,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    color: ColorsManager.secondaryText,
    fontSize: 12.0,
    fontWeight: FontsManager.regular,
    letterSpacing: 0.4,
  );

  // Button Styles
  static const TextStyle buttonTextStyle = TextStyle(
    color: ColorsManager.buttonText,
    fontSize: FontsManager.titleSize,
    fontWeight: FontsManager.regular,
  );

  static const TextStyle buttonSmall = TextStyle(
    color: ColorsManager.buttonText,
    fontSize: FontsManager.bodySize,
    fontWeight: FontsManager.medium,
    letterSpacing: 1.25,
  );

  // Hint & Caption Styles
  static const TextStyle hintTextStyle = TextStyle(
    color: ColorsManager.hintText,
    fontSize: FontsManager.subTitleSize,
    fontWeight: FontsManager.regular,
  );

  static const TextStyle captionTextStyle = TextStyle(
    color: ColorsManager.hintText,
    fontSize: FontsManager.bodySize,
    fontWeight: FontsManager.regular,
    letterSpacing: 0.4,
  );

  // Link Styles
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

  static const TextStyle linkTextStyle = TextStyle(
    color: ColorsManager.primary,
    fontSize: FontsManager.subTitleSize,
    fontWeight: FontsManager.medium,
    decoration: TextDecoration.underline,
  );

  // Error Styles
  static const TextStyle errorTextStyle = TextStyle(
    color: ColorsManager.error,
    fontSize: FontsManager.bodySize,
    fontWeight: FontsManager.medium,
  );

  // Label Styles (for form fields)
  static const TextStyle labelTextStyle = TextStyle(
    color: ColorsManager.secondaryText,
    fontSize: FontsManager.bodySize,
    fontWeight: FontsManager.medium,
    letterSpacing: 0.1,
  );

  // Overline Style
  static const TextStyle overlineTextStyle = TextStyle(
    color: ColorsManager.hintText,
    fontSize: 10.0,
    fontWeight: FontsManager.medium,
    letterSpacing: 1.5,
  );
}
