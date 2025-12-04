import 'dart:async';

import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:clean_architecture_mvvm/presentation/base/base_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class OnboardingViewModel extends BaseViewModel
    implements OnboardingViewModelInput, OnboardingViewModelOutput {
  final StreamController<OnboardingModel> _streamController =
      StreamController<OnboardingModel>();
  int currentIndex = 0;
  List<OnboardingData> get onboardingDataList => [
    OnboardingData(
      image: AssetsManager.onboardingLogo1,
      title: StringsManager.onboardingTitle1.tr(),
      subtitle: StringsManager.onboardingSubtitle1.tr(),
    ),
    OnboardingData(
      image: AssetsManager.onboardingLogo2,
      title: StringsManager.onboardingTitle2.tr(),
      subtitle: StringsManager.onboardingSubtitle2.tr(),
    ),
    OnboardingData(
      image: AssetsManager.onboardingLogo3,
      title: StringsManager.onboardingTitle3.tr(),
      subtitle: StringsManager.onboardingSubtitle3.tr(),
    ),
    OnboardingData(
      image: AssetsManager.onboardingLogo4,
      title: StringsManager.onboardingTitle4.tr(),
      subtitle: StringsManager.onboardingSubtitle4.tr(),
    ),
  ];
  bool get isLastPage => currentIndex == onboardingDataList.length - 1;
  PageController pageController = PageController();

  @override
  void start() {
    sendDataToView();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  int goToNextPage() {
    if (currentIndex == onboardingDataList.length - 1) {
      currentIndex = 0;
    } else {
      currentIndex++;
    }
    return currentIndex;
  }

  @override
  int goToPreviousPage() {
    if (currentIndex == 0) {
      currentIndex = onboardingDataList.length - 1;
    } else {
      currentIndex--;
    }
    return currentIndex;
  }

  @override
  void onPageChanged(int index) {
    currentIndex = index;
    sendDataToView();
  }

  void sendDataToView() {
    input.add(
      OnboardingModel(
        currentIndex: currentIndex,
        totalPages: onboardingDataList.length,
        isLastPage: isLastPage,
        onboardingDataList: onboardingDataList,
      ),
    );
  }

  @override
  Sink<OnboardingModel> get input => _streamController.sink;

  @override
  Stream<OnboardingModel> get output => _streamController.stream;

  @override
  void navigateToLogin() {}
}

abstract class OnboardingViewModelInput {
  void navigateToLogin();

  void onPageChanged(int index);

  void goToNextPage();

  void goToPreviousPage();

  Sink<OnboardingModel> get input;
}

abstract class OnboardingViewModelOutput {
  Stream<OnboardingModel> get output;
}
