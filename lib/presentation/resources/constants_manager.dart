class ConstantsManager {
  ConstantsManager._();

  // Screen Delays (in seconds)
  static const int splashScreenDelay = 4;
  static const int onboardingDelay = 300;

  // Carousel Animation Durations
  static const Duration carouselAutoPlayInterval = Duration(seconds: 4);
  static const Duration carouselAnimationDuration = Duration(milliseconds: 800);

  // Validation Constraints
  static const int minNameLength = 8;
  static const int minPasswordLength = 8;

  // Bottom Navigation
  static const double bottomNavSelectedFontSize = 12.0;
  static const double bottomNavUnselectedFontSize = 12.0;
}
