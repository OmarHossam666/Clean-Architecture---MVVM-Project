import 'package:clean_architecture_mvvm/application/app_constants.dart';
import 'package:clean_architecture_mvvm/application/app_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultLanguage = 'language';

class DioFactory {
  final AppPreferences appPreferences;

  DioFactory(this.appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: AppConstants.authorization,
      defaultLanguage: appPreferences.getLanguage(),
    };

    dio.options = BaseOptions(
      headers: headers,
      baseUrl: AppConstants.baseUrl,
      receiveTimeout: AppConstants.timeOut,
      sendTimeout: AppConstants.timeOut,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  }
}
