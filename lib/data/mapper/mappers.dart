import 'package:clean_architecture_mvvm/application/app_constants.dart';
import 'package:clean_architecture_mvvm/application/extensions.dart';
import 'package:clean_architecture_mvvm/data/response/responses.dart';
import 'package:clean_architecture_mvvm/domain/models/models.dart';

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
      id: this?.id.orZero() ?? AppConstants.zero,
      name: this?.name.orEmpty() ?? AppConstants.empty,
      email: this?.email.orEmpty() ?? AppConstants.empty,
      password: this?.password.orEmpty() ?? AppConstants.empty,
      phone: this?.phone.orEmpty() ?? AppConstants.empty,
      age: this?.age.orZero() ?? AppConstants.zero,
      gender: this?.gender.orEmpty() ?? AppConstants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      user: this?.user.toDomain(),
      token: this?.token.orEmpty() ?? AppConstants.empty,
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  ForgotPassword toDomain() {
    return ForgotPassword(
      support: this?.support.orEmpty() ?? AppConstants.empty,
    );
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      id: this?.id.orZero() ?? AppConstants.zero,
      title: this?.title.orEmpty() ?? AppConstants.empty,
      image: this?.image.orEmpty() ?? AppConstants.empty,
    );
  }
}

extension BannerResponseMapper on BannerResponse? {
  Banner toDomain() {
    return Banner(
      id: this?.id.orZero() ?? AppConstants.zero,
      title: this?.title.orEmpty() ?? AppConstants.empty,
      image: this?.image.orEmpty() ?? AppConstants.empty,
      link: this?.link.orEmpty() ?? AppConstants.empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      id: this?.id.orZero() ?? AppConstants.zero,
      title: this?.title.orEmpty() ?? AppConstants.empty,
      image: this?.image.orEmpty() ?? AppConstants.empty,
    );
  }
}

extension HomeDataResponseMapper on HomeDataResponse? {
  HomeData toDomain() {
    return HomeData(
      services:
          this?.services?.map((service) => service.toDomain()).toList() ?? [],
      banners: this?.banners?.map((banner) => banner.toDomain()).toList() ?? [],
      stores: this?.stores?.map((store) => store.toDomain()).toList() ?? [],
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeModel toDomain() {
    return HomeModel(data: (this?.data).toDomain());
  }
}
