class LoginRequest {
  LoginRequest({required this.email, required this.password});

  final String email;
  final String password;
}

class ForgotPasswordRequest {
  ForgotPasswordRequest({required this.email});

  final String email;
}

class RegisterRequest {
  RegisterRequest({
    required this.name,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  final String name;
  final String countryCode;
  final String phoneNumber;
  final String email;
  final String password;
}
