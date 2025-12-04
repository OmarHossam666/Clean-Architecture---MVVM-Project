import 'dart:async';
import 'dart:io';
import 'package:clean_architecture_mvvm/application/functions.dart';
import 'package:clean_architecture_mvvm/domain/usecases/register_usecase.dart';
import 'package:clean_architecture_mvvm/presentation/base/base_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/common/freezed_data_classes.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/resources/constants_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController<String> nameStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> countryCodeStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> phoneNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> emailStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController<XFile> profilePictureStreamController =
      StreamController<XFile>.broadcast();
  final StreamController<bool> isRegisterValidStreamController =
      StreamController<bool>.broadcast();
  final StreamController<bool> isRegisteredStreamController =
      StreamController<bool>();

  final RegisterUsecase registerUsecase;
  RegisterObject registerObject = RegisterObject('', '', '', '', '', XFile(''));

  RegisterViewModel({required this.registerUsecase});

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    nameStreamController.close();
    countryCodeStreamController.close();
    phoneNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    isRegisterValidStreamController.close();
    isRegisteredStreamController.close();
    super.dispose();
  }

  @override
  Stream<String?> get countryCodeErrorOutput => isCountryCodeValidOutput.map(
    (isValid) => isValid ? null : StringsManager.countryCodeError.tr(),
  );

  @override
  Sink get countryCodeInput => countryCodeStreamController.sink;

  @override
  Stream<String?> get emailErrorOutput => isEmailValidOutput.map(
    (isValid) => isValid ? null : StringsManager.emailError.tr(),
  );

  @override
  Sink get emailInput => emailStreamController.sink;

  @override
  Stream<bool> get isCountryCodeValidOutput => countryCodeStreamController
      .stream
      .map((countryCode) => _isCountryCodeValid(countryCode));

  @override
  Stream<bool> get isEmailValidOutput =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get isNameValidOutput =>
      nameStreamController.stream.map((name) => _isNameValid(name));

  @override
  Stream<bool> get isPasswordValidOutput => passwordStreamController.stream.map(
    (password) => _isPasswordValid(password),
  );

  @override
  Stream<bool> get isPhoneNumberValidOutput => phoneNumberStreamController
      .stream
      .map((phoneNumber) => _isPhoneNumberValid(phoneNumber));

  @override
  Stream<String?> get nameErrorOutput => isNameValidOutput.map(
    (isValid) => isValid ? null : StringsManager.nameError.tr(),
  );

  @override
  Sink get nameInput => nameStreamController.sink;

  @override
  Stream<String?> get passwordErrorOutput => isPasswordValidOutput.map(
    (isValid) => isValid ? null : StringsManager.passwordError.tr(),
  );

  @override
  Sink get passwordInput => passwordStreamController.sink;

  @override
  Stream<String?> get phoneNumberErrorOutput => isPhoneNumberValidOutput.map(
    (isValid) => isValid ? null : StringsManager.phoneNumberError.tr(),
  );

  @override
  Sink get phoneNumberInput => phoneNumberStreamController.sink;

  bool _isNameValid(String name) =>
      name.length >= ConstantsManager.minNameLength;

  bool _isCountryCodeValid(String countryCode) => countryCode.isNotEmpty;

  bool _isPasswordValid(String password) =>
      password.length >= ConstantsManager.minPasswordLength;

  bool _isPhoneNumberValid(String phoneNumber) => phoneNumber.isNotEmpty;

  @override
  Future<void> register() async {
    if (!streamController.isClosed) {
      inputState.add(
        LoadingState(
          stateRendererType: StateRendererType.popupLoadingState,
          message: StringsManager.loading.tr(),
        ),
      );
    }

    await registerUsecase
        .execute(
          RegisterUsecaseInput(
            name: registerObject.name,
            countryCode: registerObject.countryCode,
            phoneNumber: registerObject.phoneNumber,
            email: registerObject.email,
            password: registerObject.password,
          ),
        )
        .then((value) {
          value.fold(
            (failure) {
              if (!streamController.isClosed) {
                inputState.add(
                  ErrorState(
                    message: failure.message,
                    stateRendererType: StateRendererType.popupErrorState,
                  ),
                );
              }
            },
            (authentication) {
              if (!streamController.isClosed) {
                inputState.add(ContentState());
              }
              if (!isRegisteredStreamController.isClosed) {
                isRegisteredInput.add(true);
              }
            },
          );
        });
  }

  @override
  void setCountryCode(String countryCode) {
    countryCodeInput.add(countryCode);

    if (_isCountryCodeValid(countryCode)) {
      registerObject = registerObject.copyWith(countryCode: countryCode);
    } else {
      registerObject = registerObject.copyWith(countryCode: '');
    }
    isRegisterValidInput.add(_isRegisterValid());
  }

  @override
  void setEmail(String email) {
    emailInput.add(email);

    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: '');
    }
    isRegisterValidInput.add(_isRegisterValid());
  }

  @override
  void setName(String name) {
    nameInput.add(name);
    if (_isNameValid(name)) {
      registerObject = registerObject.copyWith(name: name);
    } else {
      registerObject = registerObject.copyWith(name: '');
    }
    isRegisterValidInput.add(_isRegisterValid());
  }

  @override
  void setPassword(String password) {
    passwordInput.add(password);

    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: '');
    }
    isRegisterValidInput.add(_isRegisterValid());
  }

  @override
  void setPhoneNumber(String phoneNumber) {
    phoneNumberInput.add(phoneNumber);

    if (_isPhoneNumberValid(phoneNumber)) {
      registerObject = registerObject.copyWith(phoneNumber: phoneNumber);
    } else {
      registerObject = registerObject.copyWith(phoneNumber: '');
    }
    isRegisterValidInput.add(_isRegisterValid());
  }

  @override
  Sink get isRegisterValidInput => isRegisterValidStreamController.sink;

  @override
  Stream<bool> get isRegisterValidOutput =>
      isRegisterValidStreamController.stream.map((_) => _isRegisterValid());

  bool _isRegisterValid() =>
      _isNameValid(registerObject.name) &&
      _isCountryCodeValid(registerObject.countryCode) &&
      _isPhoneNumberValid(registerObject.phoneNumber) &&
      isEmailValid(registerObject.email) &&
      _isProfilePictureValid(registerObject.profilePicture) &&
      _isPasswordValid(registerObject.password);

  @override
  Stream<bool> get isProfilePictureValidOutput => profilePictureStreamController
      .stream
      .map((profilePicture) => _isProfilePictureValid(profilePicture));

  @override
  Sink get profilePictureInput => profilePictureStreamController.sink;

  @override
  void setProfilePicture(XFile profilePicture) {
    profilePictureInput.add(profilePicture);
    if (_isProfilePictureValid(profilePicture)) {
      registerObject = registerObject.copyWith(profilePicture: profilePicture);
    } else {
      registerObject = registerObject.copyWith(profilePicture: XFile(''));
    }
    isRegisterValidInput.add(_isRegisterValid());
  }

  bool _isProfilePictureValid(XFile profilePicture) =>
      profilePicture.path.isNotEmpty && profilePicture.path.endsWith('.png') ||
      profilePicture.path.endsWith('.jpg') ||
      profilePicture.path.endsWith('.jpeg');
  @override
  Stream<File> get outputProfilePicture =>
      profilePictureStreamController.stream.map((file) => File(file.path));

  @override
  Sink get isRegisteredInput => isRegisteredStreamController.sink;

  @override
  Stream<bool> get isRegisteredOutput => isRegisteredStreamController.stream;
}

abstract class RegisterViewModelInputs {
  Sink get nameInput;
  Sink get countryCodeInput;
  Sink get phoneNumberInput;
  Sink get emailInput;
  Sink get passwordInput;
  Sink get profilePictureInput;
  Sink get isRegisterValidInput;
  Sink get isRegisteredInput;

  Future<void> register();

  void setName(String name);
  void setCountryCode(String countryCode);
  void setPhoneNumber(String phoneNumber);
  void setEmail(String email);
  void setPassword(String password);
  void setProfilePicture(XFile profilePicture);
}

abstract class RegisterViewModelOutputs {
  Stream<String?> get nameErrorOutput;
  Stream<bool> get isNameValidOutput;

  Stream<String?> get countryCodeErrorOutput;
  Stream<bool> get isCountryCodeValidOutput;

  Stream<String?> get phoneNumberErrorOutput;
  Stream<bool> get isPhoneNumberValidOutput;

  Stream<String?> get emailErrorOutput;
  Stream<bool> get isEmailValidOutput;

  Stream<String?> get passwordErrorOutput;
  Stream<bool> get isPasswordValidOutput;

  Stream<bool> get isProfilePictureValidOutput;

  Stream<bool> get isRegisterValidOutput;

  Stream<bool> get isRegisteredOutput;

  Stream<File> get outputProfilePicture;
}
