import 'dart:async';
import 'package:clean_architecture_mvvm/domain/usecases/login_usecase.dart';
import 'package:clean_architecture_mvvm/presentation/base/base_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/common/freezed_data_classes.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController nameStreamController =
      StreamController<String>.broadcast();

  final StreamController passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController areAllInputsValidStreamController =
      StreamController<bool>.broadcast();

  final StreamController isLoggedInStreamController = StreamController<bool>();

  LoginObject loginObject = LoginObject('', '');

  final LoginUsecase loginUsecase;

  LoginViewModel({required this.loginUsecase});

  @override
  void dispose() {
    super.dispose();
    nameStreamController.close();
    passwordStreamController.close();
    areAllInputsValidStreamController.close();
    isLoggedInStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Stream<bool> get isNameValid =>
      nameStreamController.stream.map((name) => _isNameValid(name));

  @override
  Stream<bool> get isPasswordValid => passwordStreamController.stream.map(
    (password) => _isPasswordValid(password),
  );

  bool _isNameValid(String name) {
    return name.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  @override
  Future<void> login() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
        message: StringsManager.loading,
      ),
    );
    await loginUsecase
        .execute(
          LoginUsecaseInput(
            name: loginObject.name,
            password: loginObject.password,
          ),
        )
        .then((value) {
          value.fold(
            (failure) => inputState.add(
              ErrorState(
                message: failure.message,
                stateRendererType: StateRendererType.popupErrorState,
              ),
            ),
            (authentication) {
              inputState.add(ContentState());
              isLoggedInStreamController.add(true);
            },
          );
        });
  }

  @override
  Sink get nameInput => nameStreamController.sink;

  @override
  Sink get passwordInput => passwordStreamController.sink;

  @override
  Sink get areAllInputsValidInput => areAllInputsValidStreamController.sink;

  @override
  void setName(String name) {
    nameInput.add(name);
    loginObject = loginObject.copyWith(name: name);
    areAllInputsValidInput.add(_areAllInputsValid());
  }

  @override
  void setPassword(String password) {
    passwordInput.add(password);
    loginObject = loginObject.copyWith(password: password);
    areAllInputsValidInput.add(_areAllInputsValid());
  }

  @override
  Stream<bool> get areAllInputsValid => areAllInputsValidStreamController.stream
      .map((event) => _areAllInputsValid());

  bool _areAllInputsValid() {
    return _isNameValid(loginObject.name) &&
        _isPasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  void setName(String name);
  void setPassword(String password);

  void login();

  Sink get nameInput;
  Sink get passwordInput;
  Sink get areAllInputsValidInput;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get isNameValid;
  Stream<bool> get isPasswordValid;
  Stream<bool> get areAllInputsValid;
}
