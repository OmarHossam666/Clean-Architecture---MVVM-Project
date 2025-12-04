import 'package:clean_architecture_mvvm/application/app_constants.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState extends FlowState {
  LoadingState({required this.stateRendererType, required this.message});

  final StateRendererType stateRendererType;
  final String message;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class SuccessState extends FlowState {
  SuccessState({required this.stateRendererType, required this.message});

  final StateRendererType stateRendererType;
  final String message;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  ErrorState({required this.message, required this.stateRendererType});

  final StateRendererType stateRendererType;
  final String message;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  @override
  String getMessage() => AppConstants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

class EmptyState extends FlowState {
  EmptyState({required this.message});

  final String message;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreen(
    BuildContext context,
    VoidCallback action,
    Widget contentScreen,
  ) {
    switch (runtimeType) {
      case const (LoadingState):
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            showPopup(context, getMessage(), getStateRendererType(), action);
            return contentScreen;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              action: action,
            );
          }
        }
      case const (ErrorState):
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            showPopup(context, getMessage(), getStateRendererType(), action);
            return contentScreen;
          } else {
            return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              action: action,
            );
          }
        }
      case const (ContentState):
        {
          dismissDialog(context);
          return contentScreen;
        }
      case const (EmptyState):
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            action: action,
          );
        }
      case const (SuccessState):
        {
          dismissDialog(context);
          showPopup(context, getMessage(), getStateRendererType(), action);
          return contentScreen;
        }
      default:
        {
          dismissDialog(context);
          return contentScreen;
        }
    }
  }
}

void showPopup(
  BuildContext context,
  String message,
  StateRendererType stateRendererType,
  VoidCallback action,
) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          action: action,
        ),
      );
    }
  });
}

bool isDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent == false;

void dismissDialog(BuildContext context) {
  if (isDialogShowing(context)) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted && isDialogShowing(context)) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }
}
