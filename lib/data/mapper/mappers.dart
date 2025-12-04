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

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      id: this?.id.orZero() ?? 0,
      title: this?.title.orEmpty() ?? '',
      image: this?.image.orEmpty() ?? '',
    );
  }
}

extension BannerResponseMapper on BannerResponse? {
  Banner toDomain() {
    return Banner(
      id: this?.id.orZero() ?? 0,
      title: this?.title.orEmpty() ?? '',
      image: this?.image.orEmpty() ?? '',
      link: this?.link.orEmpty() ?? '',
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      id: this?.id.orZero() ?? 0,
      title: this?.title.orEmpty() ?? '',
      image: this?.image.orEmpty() ?? '',
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

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
      id: this?.id.orZero() ?? 0,
      image: this?.image.orEmpty() ?? '',
      title: this?.title.orEmpty() ?? '',
      details: this?.details.orEmpty() ?? '',
      services: this?.services.orEmpty() ?? '',
      about: this?.about.orEmpty() ?? '',
    );
  }
}
