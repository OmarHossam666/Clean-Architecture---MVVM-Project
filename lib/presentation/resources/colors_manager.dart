import 'package:flutter/material.dart';

class ColorsManager {
  ColorsManager._();

  // Primary Colors
  static const Color primary = Color(0xFFED9728);
  static const Color primaryLight = Color(0xCCED9728);
  static const Color primaryDark = Color(0xFFD17E0F);
  static const Color primaryVariant = Color(0x80ED9728);

  // Semantic Colors - Text
  static const Color primaryText = Color(0xFF212121);
  static const Color secondaryText = Color(0xFF525252);
  static const Color hintText = Color(0xFF737477);
  static const Color disabledText = Color(0xFF9E9E9E);
  static const Color buttonText = Color(0xFFFFFFFF);

  // Semantic Colors - Status
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFF3E0);
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFFFEBEE);
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFFE3F2FD);

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color background = Color(0xFFFAFAFA);
  static const Color scaffoldBackground = Color(0xFFFFFFFF);

  // Border & Divider Colors
  static const Color border = Color(0xFF304654);
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x0D000000);

  // Basic Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color greyLight = Color(0xFFBDBDBD);
  static const Color greyDark = Color(0xFF616161);

  // Accessibility - High Contrast (WCAG AA compliant)
  static const Color textOnPrimary = Color(0xFF000000);
  static const Color textOnError = Color(0xFFFFFFFF);
  static const Color focusIndicator = Color(0xFF1976D2);

  // Shimmer Colors for Skeleton Loading
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
}
