import 'package:clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/styles_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  popupLoadingState,
  popupErrorState,
  popupSuccessState,
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  contentState,
}

class StateRenderer extends StatelessWidget {
  const StateRenderer({
    required this.stateRendererType,
    this.message = StringsManager.loading,
    this.title = StringsManager.success,
    required this.action,
    super.key,
  });

  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return _getState(context);
  }

  Widget _getState(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopupDialog([
          _getLottie(AssetsManager.loadingLottie),
          _getMessage(
            message.isNotEmpty ? message : StringsManager.loading.tr(),
          ),
        ], context);
      case StateRendererType.popupErrorState:
        return _getPopupDialog([
          _getLottie(AssetsManager.errorLottie),
          _getMessage(message.isNotEmpty ? message : StringsManager.error.tr()),
          _getButton(StringsManager.tryAgain.tr(), context),
        ], context);
      case StateRendererType.fullScreenLoadingState:
        return _getItems([
          _getLottie(AssetsManager.loadingLottie),
          _getMessage(
            message.isNotEmpty ? message : StringsManager.loading.tr(),
          ),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItems([
          _getLottie(AssetsManager.errorLottie),
          _getMessage(message.isNotEmpty ? message : StringsManager.error.tr()),
          _getButton(StringsManager.tryAgain.tr(), context),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItems([
          _getLottie(AssetsManager.emptyLottie),
          _getMessage(message.isNotEmpty ? message : StringsManager.empty.tr()),
        ]);
      case StateRendererType.contentState:
        return Container();
      case StateRendererType.popupSuccessState:
        return _getPopupDialog([
          _getLottie(AssetsManager.successLottie),
          _getTitle(title),
          _getMessage(
            message.isNotEmpty ? message : StringsManager.successMessage.tr(),
          ),
          _getButton(StringsManager.ok.tr(), context),
        ], context);
    }
  }

  Widget _getItems(List<Widget> children) {
    return Column(
      spacing: ValuesManager.spacing12,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getLottie(String lottiePath) {
    return Lottie.asset(
      lottiePath,
      width: ValuesManager.width100,
      height: ValuesManager.height100,
    );
  }

  Widget _getMessage(String message) {
    return Text(
      message,
      style: StylesManager.titleTextStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget _getTitle(String title) {
    return Text(
      title,
      style: StylesManager.sectionHeaderTextStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget _getButton(String text, BuildContext context) {
    return ElevatedButton(
      child: Text(text, style: StylesManager.buttonTextStyle),
      onPressed: () {
        if (stateRendererType == StateRendererType.fullScreenErrorState) {
          action.call();
        } else {
          Navigator.pop(context);
          action.call();
        }
      },
    );
  }

  Widget _getPopupDialog(List<Widget> children, BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesManager.radius16),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.black26,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(ValuesManager.radius16),
          boxShadow: [
            BoxShadow(
              color: Colors.white70,
              blurRadius: 4.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(ValuesManager.padding16),
          child: _getDialogContent(children, context),
        ),
      ),
    );
  }

  Widget _getDialogContent(List<Widget> children, BuildContext context) {
    return Column(
      spacing: ValuesManager.spacing12,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
