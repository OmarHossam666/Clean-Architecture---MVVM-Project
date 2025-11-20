import 'dart:async';

import 'package:clean_architecture_mvvm/application/app_preferences.dart';
import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/constants_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  void _initTimer() {
    _timer = Timer(
      const Duration(seconds: ConstantsManager.splashScreenDelay),
      _goNext,
    );
  }

  void _goNext() {
    if (_appPreferences.isOnboardingCompleted()) {
      Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, RoutesManager.onboardingRoute);
    }

    if (_appPreferences.isRegistered()) {
      Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, RoutesManager.registerRoute);
    }

    if (_appPreferences.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, RoutesManager.mainRoute);
    } else {
      Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primary,
      body: Center(child: Image.asset(AssetsManager.splashLogo)),
    );
  }
}
