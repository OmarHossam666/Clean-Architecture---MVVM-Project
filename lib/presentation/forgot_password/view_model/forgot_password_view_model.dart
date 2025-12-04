import 'dart:async';

import 'package:clean_architecture_mvvm/application/functions.dart';
import 'package:clean_architecture_mvvm/domain/usecases/forgot_password_usecase.dart';
import 'package:clean_architecture_mvvm/presentation/base/base_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/common/freezed_data_classes.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends BaseViewModel
    implements ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController<String> emailStreamController =
      StreamController<String>.broadcast();
  final StreamController<bool> isEmailValidStreamController =
      StreamController<bool>.broadcast();
  final StreamController<bool> isPasswordResetStreamController =
      StreamController<bool>();

  ForgotPasswordObject forgotPasswordObject = ForgotPasswordObject('');

  final ForgotPasswordUsecase forgotPasswordUsecase;

  ForgotPasswordViewModel({required this.forgotPasswordUsecase});

  @override
  void start() => inputState.add(ContentState());

  @override
  void dispose() {
    super.dispose();
    emailStreamController.close();
    isEmailValidStreamController.close();
    isPasswordResetStreamController.close();
  }

  @override
  Sink get emailInput => emailStreamController.sink;

  @override
  Future<void> forgotPassword() async {
    if (!streamController.isClosed) {
      inputState.add(
        LoadingState(
          stateRendererType: StateRendererType.popupLoadingState,
          message: StringsManager.loading,
        ),
      );
    }

    await forgotPasswordUsecase
        .execute(ForgotPasswordUsecaseInput(email: forgotPasswordObject.email))
        .then((value) {
          value.fold(
            (failure) {
              if (!streamController.isClosed) {
                inputState.add(
                  ErrorState(
                    stateRendererType: StateRendererType.popupErrorState,
                    message: failure.message,
                  ),
                );
              }
            },
            (forgotPassword) {
              if (!streamController.isClosed) {
                inputState.add(
                  SuccessState(
                    stateRendererType: StateRendererType.popupSuccessState,
                    message:
                        forgotPassword.support ?? StringsManager.successMessage,
                  ),
                );
              }
              if (!isPasswordResetStreamController.isClosed) {
                isPasswordResetInput.add(true);
              }
            },
          );
        });
  }

  void navigateToLogin(BuildContext context) => Navigator.pop(context);
  @override
  Sink get isEmailValidInput => isEmailValidStreamController.sink;

  @override
  Stream<bool> get isEmailValidOutput => isEmailValidStreamController.stream;

  @override
  void setEmail(String email) {
    emailInput.add(email);
    forgotPasswordObject = forgotPasswordObject.copyWith(email: email);
    isEmailValidInput.add(isEmailValid(email));
  }

  @override
  Sink get isPasswordResetInput => isPasswordResetStreamController.sink;
}

abstract class ForgotPasswordViewModelInputs {
  void setEmail(String email);
  Future<void> forgotPassword();

  Sink get emailInput;
  Sink get isEmailValidInput;
  Sink get isPasswordResetInput;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get isEmailValidOutput;
}
