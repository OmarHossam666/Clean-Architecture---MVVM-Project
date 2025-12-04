import 'package:clean_architecture_mvvm/application/app_preferences.dart';
import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:clean_architecture_mvvm/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/constants_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final OnboardingViewModel _onboardingViewModel = OnboardingViewModel();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    _onboardingViewModel.start();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _onboardingViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OnboardingModel>(
      stream: _onboardingViewModel.output,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _getContentWidget(snapshot.data);
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: ColorsManager.primary),
            ),
          );
        }
      },
    );
  }

  Widget _getContentWidget(OnboardingModel? onboardingModel) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingModel?.totalPages,
        itemBuilder: (context, index) {
          if (onboardingModel == null) {
            return const SizedBox();
          }
          return OnboardingPage(
            onboardingData: onboardingModel.onboardingDataList[index],
          );
        },
        onPageChanged: _onboardingViewModel.onPageChanged,
      ),

      bottomSheet: Container(
        height: ValuesManager.height100,
        color: Colors.white,
        child: Column(
          spacing: ValuesManager.spacing12,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _navigateToLogin,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: ColorsManager.primary,
                  textStyle: StylesManager.skipTextStyle,
                ),
                child: Text(StringsManager.skip.tr()),
              ),
            ),
            Expanded(
              child: Container(
                height: ValuesManager.height50,
                color: ColorsManager.primary,
                child: Padding(
                  padding: const EdgeInsets.all(ValuesManager.padding16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: ValuesManager.spacing8,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            _onboardingViewModel.goToPreviousPage(),
                            duration: Duration(
                              microseconds: ConstantsManager.onboardingDelay,
                            ),
                            curve: Curves.bounceInOut,
                          );
                        },
                        child: SvgPicture.asset(AssetsManager.leftArrowIcon),
                      ),
                      if (onboardingModel != null)
                        for (int i = 0; i < onboardingModel.totalPages; i++)
                          _getIndicator(i),
                      GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            _onboardingViewModel.goToNextPage(),
                            duration: Duration(
                              microseconds: ConstantsManager.onboardingDelay,
                            ),
                            curve: Curves.bounceInOut,
                          );
                        },
                        child: SvgPicture.asset(AssetsManager.rightArrowIcon),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLogin() async {
    await _appPreferences.setOnboardingCompleted(true);
    if (mounted) {
      Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
    }
  }

  Widget _getIndicator(int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: Duration(microseconds: ConstantsManager.onboardingDelay),
          curve: Curves.bounceInOut,
        );
      },
      child: SvgPicture.asset(
        _onboardingViewModel.currentIndex == index
            ? AssetsManager.solidCircleIcon
            : AssetsManager.hollowCircleIcon,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.onboardingData});

  final OnboardingData onboardingData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: ValuesManager.spacing12,
      children: [
        Text(onboardingData.title, style: StylesManager.titleTextStyle),
        Text(onboardingData.subtitle, style: StylesManager.subtitleTextStyle),
        SvgPicture.asset(onboardingData.image),
      ],
    );
  }
}
