import 'package:clean_architecture_mvvm/application/app_preferences.dart';
import 'package:clean_architecture_mvvm/data/data_source/local_data_source.dart';
import 'package:clean_architecture_mvvm/data/data_source/remote_data_source.dart';
import 'package:clean_architecture_mvvm/data/network/api_service.dart';
import 'package:clean_architecture_mvvm/data/network/dio_factory.dart';
import 'package:clean_architecture_mvvm/data/network_information/network_information.dart';
import 'package:clean_architecture_mvvm/data/repository/repository_implementation.dart';
import 'package:clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:clean_architecture_mvvm/domain/usecases/forgot_password_usecase.dart';
import 'package:clean_architecture_mvvm/domain/usecases/home_usecase.dart';
import 'package:clean_architecture_mvvm/domain/usecases/login_usecase.dart';
import 'package:clean_architecture_mvvm/domain/usecases/register_usecase.dart';
import 'package:clean_architecture_mvvm/domain/usecases/store_details_usecase.dart';
import 'package:clean_architecture_mvvm/presentation/details/view_model/store_details_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/login/view_model/login_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/main/view_models/home_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/register/view_model/register_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initDependencyInjection() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(sharedPreferences: instance()),
  );

  instance.registerLazySingleton<NetworkInformation>(
    () => NetworkInformationImplementation(
      internetConnectionChecker: InternetConnectionChecker.instance,
    ),
  );

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  final Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton(() => ApiService(dio));

  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementation(instance()),
  );

  instance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImplementation(),
  );

  instance.registerLazySingleton<Repository>(
    () => RepositoryImplementation(
      remoteDataSource: instance(),
      networkInformation: instance(),
      localDataSource: instance(),
    ),
  );
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUsecase>()) {
    instance.registerFactory(() => LoginUsecase(instance()));
    instance.registerFactory(() => LoginViewModel(loginUsecase: instance()));
  }
}

void initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUsecase>()) {
    instance.registerFactory<ForgotPasswordUsecase>(
      () => ForgotPasswordUsecase(instance()),
    );
    instance.registerFactory<ForgotPasswordViewModel>(
      () => ForgotPasswordViewModel(forgotPasswordUsecase: instance()),
    );
  }
}

void initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUsecase>()) {
    instance.registerFactory<RegisterUsecase>(
      () => RegisterUsecase(instance()),
    );
    instance.registerFactory<RegisterViewModel>(
      () => RegisterViewModel(registerUsecase: instance()),
    );
  }
}

void initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUsecase>()) {
    instance.registerFactory(() => HomeUsecase(instance()));
    instance.registerFactory(() => HomeViewModel(homeUsecase: instance()));
  }
}

void initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUsecase>()) {
    instance.registerFactory(() => StoreDetailsUsecase(instance()));
    instance.registerFactory(
      () => StoreDetailsViewModel(storeDetailsUsecase: instance()),
    );
  }
}
