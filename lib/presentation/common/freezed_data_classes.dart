import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
abstract class LoginObject with _$LoginObject {
  const factory LoginObject(String name, String password) = _LoginObject;
}

@freezed
abstract class ForgotPasswordObject with _$ForgotPasswordObject {
  const factory ForgotPasswordObject(String email) = _ForgotPasswordObject;
}

@freezed
abstract class RegisterObject with _$RegisterObject {
  const factory RegisterObject(
    String name,
    String countryCode,
    String phoneNumber,
    String email,
    String password,
    XFile profilePicture,
  ) = _RegisterObject;
}
