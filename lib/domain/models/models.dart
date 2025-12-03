class OnboardingData {
  OnboardingData({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}

class OnboardingModel {
  OnboardingModel({
    required this.currentIndex,
    required this.totalPages,
    required this.isLastPage,
    required this.onboardingDataList,
  });

  final List<OnboardingData> onboardingDataList;
  final int currentIndex;
  final int totalPages;
  final bool isLastPage;
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.age,
    required this.gender,
  });

  final int id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final int age;
  final String gender;
}

class Authentication {
  Authentication({required this.user, required this.token});

  final User? user;
  final String token;
}

class ForgotPassword {
  ForgotPassword({required this.support});

  final String? support;
}

class Service {
  Service({required this.id, required this.title, required this.image});

  final int id;
  final String title;
  final String image;
}

class Banner {
  Banner({
    required this.id,
    required this.link,
    required this.title,
    required this.image,
  });

  final int id;
  final String link;
  final String title;
  final String image;
}

class Store {
  Store({required this.id, required this.title, required this.image});

  final int id;
  final String title;
  final String image;
}

class HomeData {
  HomeData({
    required this.services,
    required this.banners,
    required this.stores,
  });

  final List<Service> services;
  final List<Banner> banners;
  final List<Store> stores;
}

class HomeModel {
  HomeModel({required this.data});

  final HomeData data;
}

class StoreDetails {
  StoreDetails({
    required this.id,
    required this.title,
    required this.image,
    required this.details,
    required this.services,
    required this.about,
  });

  final int id;
  final String title;
  final String image;
  final String details;
  final String services;
  final String about;
}
