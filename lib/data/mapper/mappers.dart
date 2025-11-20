import 'package:clean_architecture_mvvm/application/extensions.dart';
import 'package:clean_architecture_mvvm/data/response/responses.dart';
import 'package:clean_architecture_mvvm/domain/models/models.dart';

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
      id: this?.id.orZero() ?? 0,
      name: this?.name.orEmpty() ?? '',
      email: this?.email.orEmpty() ?? '',
      password: this?.password.orEmpty() ?? '',
      phone: this?.phone.orEmpty() ?? '',
      age: this?.age.orZero() ?? 0,
      gender: this?.gender.orEmpty() ?? '',
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      user: this?.user.toDomain(),
      token: this?.token.orEmpty() ?? '',
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  ForgotPassword toDomain() {
    return ForgotPassword(support: this?.support.orEmpty() ?? '');
  }
}
