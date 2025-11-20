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
