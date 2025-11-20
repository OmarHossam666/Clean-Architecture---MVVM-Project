import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/presentation/details/details_screen.dart';
import 'package:clean_architecture_mvvm/presentation/forgot_password/view/forgot_password_screen.dart';
import 'package:clean_architecture_mvvm/presentation/login/view/login_screen.dart';
import 'package:clean_architecture_mvvm/presentation/main/main_screen.dart';
import 'package:clean_architecture_mvvm/presentation/onboarding/view/onboarding_screen.dart';
import 'package:clean_architecture_mvvm/presentation/register/view/register_screen.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  RoutesManager._();

  static const String splashRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
  static const String detailsRoute = '/details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesManager.onboardingRoute:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case RoutesManager.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesManager.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case RoutesManager.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case RoutesManager.mainRoute:
        return MaterialPageRoute(builder: (context) => const MainScreen());
      case RoutesManager.detailsRoute:
        return MaterialPageRoute(builder: (context) => const DetailsScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(
            StringsManager.noRouteFound,
            style: StylesManager.titleTextStyle,
          ),
        ),
      ),
    );
  }
}
