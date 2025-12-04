import 'dart:async';

import 'package:clean_architecture_mvvm/application/app_preferences.dart';
import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/constants_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupSystemUI();
    _setupAnimations();
    _initTimer();
  }

  void _setupSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _animationController.forward();
  }

  void _initTimer() {
    _timer = Timer(
      const Duration(seconds: ConstantsManager.splashScreenDelay),
      _goNext,
    );
  }

  void _goNext() {
    if (!_appPreferences.isOnboardingCompleted()) {
      Navigator.pushReplacementNamed(context, RoutesManager.onboardingRoute);
    } else if (_appPreferences.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, RoutesManager.mainRoute);
    } else {
      Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
            );
          },
          child: Semantics(
            image: true,
            label: 'App logo',
            child: Image.asset(
              AssetsManager.splashLogo,
              width: ValuesManager.width200,
              height: ValuesManager.height200,
            ),
          ),
        ),
      ),
    );
  }
}
