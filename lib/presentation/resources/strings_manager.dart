class StringsManager {
  StringsManager._();

  // General
  static const String appName = 'Clean Architecture With MVVM';
  static const String noRouteFound = 'No Route Found';
  static const String loading = 'Loading...';
  static const String error = 'An error occurred, please try again later.';
  static const String tryAgain = 'Try again';
  static const String ok = 'OK';
  static const String empty = 'No data available';
  static const String successMessage = 'Operation completed successfully';
  static const String nameError = 'Name must be at least 8 characters long';
  static const String countryCodeError = 'Country code cannot be empty';
  static const String phoneNumberError = 'Phone number cannot be empty';
  static const String phoneNumber = 'Phone Number';
  static const String profilePictureError =
      'Profile picture should be png or jpg or jpeg';

  // Onboarding Screen
  static const String onboardingTitle1 = 'Onboarding Title 1';
  static const String onboardingTitle2 = 'Onboarding Title 2';
  static const String onboardingTitle3 = 'Onboarding Title 3';
  static const String onboardingTitle4 = 'Onboarding Title 4';
  static const String onboardingSubtitle1 = 'Onboarding Subtitle 1';
  static const String onboardingSubtitle2 = 'Onboarding Subtitle 2';
  static const String onboardingSubtitle3 = 'Onboarding Subtitle 3';
  static const String onboardingSubtitle4 = 'Onboarding Subtitle 4';
  static const String skip = 'Skip';

  // Login Screen
  static const String userName = 'User Name';
  static const String userNameError = 'Please enter your user name';
  static const String password = 'Password';
  static const String passwordError = 'Please enter your password';
  static const String login = 'Login';
  static const String forgotPassword = 'Forgot Password?';
  static const String registerText = "Don't have an account? Register";

  // Register Screen
  static const String register = 'Register';
  static const String loginText = 'Already have an account? Login';
  static const String countryCode = 'Country Code';
  static const String plus20 = '+20';

  // Forgot Password Screen
  static const String email = 'Email';
  static const String resetPassword = 'Reset Password';
  static const String resetPasswordSuccess =
      'Password reset link has been sent to your email';
  static const String emailError = 'Please enter your email';

  // Main Screen
  static const String home = 'Home';
  static const String search = 'Search';
  static const String notifications = 'Notifications';
  static const String settings = 'Settings';

  // Home Screen
  static const String services = 'Services';
  static const String stores = 'Stores';

  // Store Details Screen
  static const String storeDetails = 'Store Details';
  static const String details = 'Details';
  static const String about = 'About';

  // Settings Screen
  static const String changeLanguage = 'Change Language';
  static const String contactUs = 'Contact Us';
  static const String inviteYourFriends = 'Invite Your Friends';
  static const String logout = 'Logout';

  // Response Messages
  static const String success = "Your request was completed successfully.";
  static const String noContent =
      "Your request was processed successfully, but no data was returned.";
  static const String badRequest =
      "Sorry, we couldn't process your request. Please check your information and try again.";
  static const String forbidden =
      "You don't have permission to access this resource. Please contact support if you believe this is an error.";
  static const String unauthorised =
      "Please log in again to continue. Your session may have expired.";
  static const String notFound =
      "We couldn't find what you're looking for. The resource may have been moved or deleted.";
  static const String internalServerError =
      "Something went wrong on our end. We're working to fix it. Please try again later.";

  // Local Response Message
  static const String connectTimeout =
      "The connection timed out. Please check your internet and try again.";
  static const String cancel =
      "The request was cancelled. Please try again if needed.";
  static const String recieveTimeout =
      "Taking too long to receive data. Please check your connection and try again.";
  static const String sendTimeout =
      "Taking too long to send data. Please check your connection and try again.";
  static const String cacheError =
      "There was an issue with the cached data. Please refresh and try again.";
  static const String noInternetConnection =
      "No internet connection available. Please check your network settings and try again.";
  static const String unknown =
      "An unexpected error occurred. Please try again or contact support if the problem persists.";
}
