import 'package:clean_architecture_mvvm/application/app_constants.dart';
import 'package:clean_architecture_mvvm/data/response/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(AppConstants.loginEndpoint)
  Future<AuthenticationResponse> login(
    @Field('email') String email,
    @Field('password') String password,
  );

  @POST(AppConstants.forgotPasswordEndpoint)
  Future<ForgotPasswordResponse> forgotPassword(@Field('email') String email);

  @POST(AppConstants.registerEndpoint)
  Future<AuthenticationResponse> register(
    @Field('name') String name,
    @Field('country_code') String countryCode,
    @Field('phone_number') String phoneNumber,
    @Field('email') String email,
    @Field('password') String password,
  );

  @GET(AppConstants.homeEndpoint)
  Future<HomeResponse> getHomeData();

  @GET(AppConstants.storeDetailsEndpoint)
  Future<StoreDetailsResponse> getStoreDetails();
}
