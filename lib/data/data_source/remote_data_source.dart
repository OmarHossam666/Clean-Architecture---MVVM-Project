import 'package:clean_architecture_mvvm/data/network/api_service.dart';
import 'package:clean_architecture_mvvm/data/request/requests.dart';
import 'package:clean_architecture_mvvm/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(
    ForgotPasswordRequest forgotPasswordRequest,
  );
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImplementation implements RemoteDataSource {
  RemoteDataSourceImplementation(this.apiService);

  final ApiService apiService;

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await apiService.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(
    ForgotPasswordRequest forgotPasswordRequest,
  ) async {
    return await apiService.forgotPassword(forgotPasswordRequest.email);
  }

  @override
  Future<AuthenticationResponse> register(
    RegisterRequest registerRequest,
  ) async {
    return await apiService.register(
      registerRequest.name,
      registerRequest.countryCode,
      registerRequest.phoneNumber,
      registerRequest.email,
      registerRequest.password,
    );
  }
}
