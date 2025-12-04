import 'package:flutter/material.dart';

/// Breakpoints for responsive design following common device sizes
class Breakpoints {
  Breakpoints._();

  /// Mobile: 0 - 599dp
  static const double mobile = 600;

  /// Tablet: 600 - 904dp
  static const double tablet = 905;

  /// Desktop: 905dp+
  static const double desktop = 1240;
}

/// Screen size type for responsive layouts
enum ScreenSize { mobile, tablet, desktop }

/// A responsive layout builder that adapts to different screen sizes
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Widget to display on mobile devices
  final Widget mobile;

  /// Widget to display on tablet devices (falls back to mobile if null)
  final Widget? tablet;

  /// Widget to display on desktop devices (falls back to tablet or mobile if null)
  final Widget? desktop;

  /// Returns the current screen size based on width
  static ScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= Breakpoints.tablet) {
      return ScreenSize.desktop;
    } else if (width >= Breakpoints.mobile) {
      return ScreenSize.tablet;
    }
    return ScreenSize.mobile;
  }

  /// Returns true if the current device is mobile
  static bool isMobile(BuildContext context) =>
      getScreenSize(context) == ScreenSize.mobile;

  /// Returns true if the current device is tablet
  static bool isTablet(BuildContext context) =>
      getScreenSize(context) == ScreenSize.tablet;

  /// Returns true if the current device is desktop
  static bool isDesktop(BuildContext context) =>
      getScreenSize(context) == ScreenSize.desktop;

  /// Returns the width of the screen
  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  /// Returns the height of the screen
  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  /// Returns responsive value based on screen size
  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final screenSize = getScreenSize(context);
    switch (screenSize) {
      case ScreenSize.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenSize.tablet:
        return tablet ?? mobile;
      case ScreenSize.mobile:
        return mobile;
    }
  }

  /// Returns responsive padding based on screen size
  static EdgeInsets responsivePadding(BuildContext context) {
    return value<EdgeInsets>(
      context: context,
      mobile: const EdgeInsets.all(16),
      tablet: const EdgeInsets.all(24),
      desktop: const EdgeInsets.all(32),
    );
  }

  /// Returns responsive number of columns for grids
  static int gridColumns(BuildContext context) {
    return value<int>(context: context, mobile: 2, tablet: 3, desktop: 4);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenSize.tablet:
        return tablet ?? mobile;
      case ScreenSize.mobile:
        return mobile;
    }
  }
}

/// A widget that provides responsive spacing
class ResponsiveSpacing extends StatelessWidget {
  const ResponsiveSpacing({
    super.key,
    this.mobileSpacing = 8,
    this.tabletSpacing = 12,
    this.desktopSpacing = 16,
    this.axis = Axis.vertical,
  });

  final double mobileSpacing;
  final double tabletSpacing;
  final double desktopSpacing;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveLayout.value<double>(
      context: context,
      mobile: mobileSpacing,
      tablet: tabletSpacing,
      desktop: desktopSpacing,
    );

    return axis == Axis.vertical
        ? SizedBox(height: spacing)
        : SizedBox(width: spacing);
  }
}

/// Extension methods for responsive design
extension ResponsiveExtension on BuildContext {
  /// Get the current screen size
  ScreenSize get screenSize => ResponsiveLayout.getScreenSize(this);

  /// Check if the device is mobile
  bool get isMobile => ResponsiveLayout.isMobile(this);

  /// Check if the device is tablet
  bool get isTablet => ResponsiveLayout.isTablet(this);

  /// Check if the device is desktop
  bool get isDesktop => ResponsiveLayout.isDesktop(this);

  /// Get the screen width
  double get screenWidth => ResponsiveLayout.screenWidth(this);

  /// Get the screen height
  double get screenHeight => ResponsiveLayout.screenHeight(this);

  /// Get responsive padding
  EdgeInsets get responsivePadding => ResponsiveLayout.responsivePadding(this);

  /// Get responsive value
  T responsive<T>({required T mobile, T? tablet, T? desktop}) {
    return ResponsiveLayout.value<T>(
      context: this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
