import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/fonts_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemesManager {
  ThemesManager._();

  static final ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: ColorsManager.primary,
    onPrimary: ColorsManager.textOnPrimary,
    primaryContainer: ColorsManager.primaryLight,
    onPrimaryContainer: ColorsManager.primaryText,
    secondary: ColorsManager.primaryDark,
    onSecondary: ColorsManager.white,
    secondaryContainer: ColorsManager.primaryVariant,
    onSecondaryContainer: ColorsManager.primaryText,
    tertiary: ColorsManager.info,
    onTertiary: ColorsManager.white,
    error: ColorsManager.error,
    onError: ColorsManager.textOnError,
    errorContainer: ColorsManager.errorLight,
    onErrorContainer: ColorsManager.error,
    surface: ColorsManager.surface,
    onSurface: ColorsManager.primaryText,
    surfaceContainerHighest: ColorsManager.surfaceVariant,
    onSurfaceVariant: ColorsManager.secondaryText,
    outline: ColorsManager.border,
    outlineVariant: ColorsManager.borderLight,
    shadow: ColorsManager.grey,
    scrim: ColorsManager.overlay,
    inverseSurface: ColorsManager.primaryText,
    onInverseSurface: ColorsManager.white,
    inversePrimary: ColorsManager.primaryLight,
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _lightColorScheme,

    scaffoldBackgroundColor: ColorsManager.scaffoldBackground,
    primaryColor: ColorsManager.primary,
    primaryColorDark: ColorsManager.primaryDark,
    primaryColorLight: ColorsManager.primaryLight,
    fontFamily: FontsManager.fontFamily,
    splashColor: ColorsManager.primaryDark.withValues(alpha: 0.1),
    highlightColor: ColorsManager.primaryLight.withValues(alpha: 0.1),
    shadowColor: ColorsManager.grey.withValues(alpha: 0.3),
    hintColor: ColorsManager.hintText,
    dividerColor: ColorsManager.divider,
    disabledColor: ColorsManager.disabledText,

    // Visual Density for better touch targets
    visualDensity: VisualDensity.adaptivePlatformDensity,

    // Page Transitions
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
      },
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.primary,
      foregroundColor: ColorsManager.white,
      shadowColor: ColorsManager.grey.withValues(alpha: 0.3),
      titleTextStyle: StylesManager.titleTextStyle.copyWith(
        color: ColorsManager.white,
      ),
      centerTitle: true,
      elevation: ValuesManager.elevation2,
      scrolledUnderElevation: ValuesManager.elevation4,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: const IconThemeData(
        color: ColorsManager.white,
        size: ValuesManager.iconSize24,
      ),
    ),

    cardTheme: CardThemeData(
      color: ColorsManager.surface,
      shadowColor: ColorsManager.grey.withValues(alpha: 0.2),
      margin: const EdgeInsets.all(ValuesManager.margin8),
      elevation: ValuesManager.elevation2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesManager.radius12),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    ),

    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorsManager.greyLight,
      buttonColor: ColorsManager.primary,
      splashColor: ColorsManager.primaryDark,
      minWidth: ValuesManager.minTouchTarget,
      height: ValuesManager.height48,
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorsManager.primary,
        textStyle: StylesManager.buttonTextStyle,
        minimumSize: const Size(
          ValuesManager.minTouchTarget,
          ValuesManager.minTouchTarget,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ValuesManager.padding16,
          vertical: ValuesManager.padding8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ValuesManager.radius8),
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primary,
        foregroundColor: ColorsManager.buttonText,
        disabledBackgroundColor: ColorsManager.greyLight,
        disabledForegroundColor: ColorsManager.disabledText,
        minimumSize: const Size.fromHeight(ValuesManager.height50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ValuesManager.radius16),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ValuesManager.padding24,
          vertical: ValuesManager.padding16,
        ),
        textStyle: StylesManager.buttonTextStyle,
        iconColor: ColorsManager.white,
        iconSize: ValuesManager.iconSize24,
        elevation: ValuesManager.elevation2,
        shadowColor: ColorsManager.primary.withValues(alpha: 0.3),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorsManager.primary,
        minimumSize: const Size.fromHeight(ValuesManager.height50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ValuesManager.radius16),
        ),
        side: const BorderSide(color: ColorsManager.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(
          horizontal: ValuesManager.padding24,
          vertical: ValuesManager.padding16,
        ),
        textStyle: StylesManager.buttonTextStyle.copyWith(
          color: ColorsManager.primary,
        ),
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: ColorsManager.primary,
        minimumSize: const Size(
          ValuesManager.minTouchTarget,
          ValuesManager.minTouchTarget,
        ),
        padding: const EdgeInsets.all(ValuesManager.padding8),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.primary,
      foregroundColor: ColorsManager.white,
      elevation: ValuesManager.elevation4,
      focusElevation: ValuesManager.elevation8,
      hoverElevation: ValuesManager.elevation8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesManager.radius16),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: StylesManager.displayLarge,
      displayMedium: StylesManager.displayMedium,
      titleLarge: StylesManager.titleLarge,
      titleMedium: StylesManager.sectionHeaderTextStyle,
      titleSmall: StylesManager.subtitleMedium,
      bodyLarge: StylesManager.bodyLarge,
      bodyMedium: StylesManager.bodyTextStyle,
      bodySmall: StylesManager.bodySmall,
      labelLarge: StylesManager.buttonTextStyle,
      labelMedium: StylesManager.labelTextStyle,
      labelSmall: StylesManager.captionTextStyle,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsManager.surface,
      focusColor: ColorsManager.primary,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: ValuesManager.padding16,
        vertical: ValuesManager.padding16,
      ),
      hintStyle: StylesManager.hintTextStyle,
      labelStyle: StylesManager.labelTextStyle,
      errorStyle: StylesManager.errorTextStyle,
      floatingLabelStyle: StylesManager.labelTextStyle.copyWith(
        color: ColorsManager.primary,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.inputFieldRadius),
        borderSide: const BorderSide(
          color: ColorsManager.borderLight,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.inputFieldRadius),
        borderSide: const BorderSide(
          color: ColorsManager.borderLight,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.inputFieldRadius),
        borderSide: const BorderSide(color: ColorsManager.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.inputFieldRadius),
        borderSide: const BorderSide(color: ColorsManager.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.inputFieldRadius),
        borderSide: const BorderSide(color: ColorsManager.error, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ValuesManager.inputFieldRadius),
        borderSide: const BorderSide(color: ColorsManager.greyLight, width: 1),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorsManager.surface,
      selectedItemColor: ColorsManager.primary,
      unselectedItemColor: ColorsManager.grey,
      selectedLabelStyle: StylesManager.captionTextStyle.copyWith(
        color: ColorsManager.primary,
        fontWeight: FontsManager.medium,
      ),
      unselectedLabelStyle: StylesManager.captionTextStyle,
      elevation: ValuesManager.elevation8,
      showUnselectedLabels: true,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorsManager.primaryText,
      contentTextStyle: StylesManager.bodyTextStyle.copyWith(
        color: ColorsManager.white,
      ),
      actionTextColor: ColorsManager.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesManager.radius8),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: ColorsManager.surface,
      elevation: ValuesManager.elevation8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesManager.radius16),
      ),
      titleTextStyle: StylesManager.sectionHeaderTextStyle,
      contentTextStyle: StylesManager.bodyTextStyle,
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorsManager.surface,
      elevation: ValuesManager.elevation8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ValuesManager.radius16),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    ),

    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: ValuesManager.padding16,
        vertical: ValuesManager.padding8,
      ),
      minVerticalPadding: ValuesManager.padding8,
      horizontalTitleGap: ValuesManager.spacing16,
      minLeadingWidth: ValuesManager.iconSize24,
      iconColor: ColorsManager.primary,
      textColor: ColorsManager.primaryText,
      titleTextStyle: StylesManager.bodyLarge,
      subtitleTextStyle: StylesManager.bodySmall,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesManager.radius8),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: ColorsManager.divider,
      thickness: 1,
      space: ValuesManager.spacing16,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorsManager.primary,
      linearTrackColor: ColorsManager.primaryLight,
      circularTrackColor: ColorsManager.primaryLight,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: ColorsManager.surfaceVariant,
      selectedColor: ColorsManager.primaryLight,
      disabledColor: ColorsManager.greyLight,
      labelStyle: StylesManager.labelTextStyle,
      padding: const EdgeInsets.symmetric(
        horizontal: ValuesManager.padding12,
        vertical: ValuesManager.padding8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesManager.radius8),
      ),
    ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: ColorsManager.primaryText.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(ValuesManager.radius4),
      ),
      textStyle: StylesManager.bodySmall.copyWith(color: ColorsManager.white),
      padding: const EdgeInsets.symmetric(
        horizontal: ValuesManager.padding12,
        vertical: ValuesManager.padding8,
      ),
    ),
  );
}
