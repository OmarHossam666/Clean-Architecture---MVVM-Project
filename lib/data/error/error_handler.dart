// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:clean_architecture_mvvm/data/failure/failure.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.UNKNOWN.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.BAD_REQUEST.getFailure();
    case DioExceptionType.badResponse:
      if (error.response?.statusCode != null &&
          error.response?.statusMessage != null &&
          error.response != null) {
        return Failure(
          statusCode: error.response?.statusCode ?? ResponseCode.UNKNOWN,
          message: error.response?.statusMessage ?? ResponseMessage.UNKNOWN,
        );
      } else {
        return DataSource.UNKNOWN.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.NO_INTERNET_CONNECTION.getFailure();
    case DioExceptionType.unknown:
      return DataSource.UNKNOWN.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  UNKNOWN,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(
          statusCode: ResponseCode.SUCCESS,
          message: ResponseMessage.SUCCESS,
        );
      case DataSource.NO_CONTENT:
        return Failure(
          statusCode: ResponseCode.NO_CONTENT,
          message: ResponseMessage.NO_CONTENT,
        );
      case DataSource.BAD_REQUEST:
        return Failure(
          statusCode: ResponseCode.BAD_REQUEST,
          message: ResponseMessage.BAD_REQUEST,
        );
      case DataSource.FORBIDDEN:
        return Failure(
          statusCode: ResponseCode.FORBIDDEN,
          message: ResponseMessage.FORBIDDEN,
        );
      case DataSource.UNAUTHORISED:
        return Failure(
          statusCode: ResponseCode.UNAUTHORISED,
          message: ResponseMessage.UNAUTHORISED,
        );
      case DataSource.NOT_FOUND:
        return Failure(
          statusCode: ResponseCode.NOT_FOUND,
          message: ResponseMessage.NOT_FOUND,
        );
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
          statusCode: ResponseCode.INTERNAL_SERVER_ERROR,
          message: ResponseMessage.INTERNAL_SERVER_ERROR,
        );
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
          statusCode: ResponseCode.CONNECT_TIMEOUT,
          message: ResponseMessage.CONNECT_TIMEOUT,
        );
      case DataSource.CANCEL:
        return Failure(
          statusCode: ResponseCode.CANCEL,
          message: ResponseMessage.CANCEL,
        );
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
          statusCode: ResponseCode.RECIEVE_TIMEOUT,
          message: ResponseMessage.RECIEVE_TIMEOUT,
        );
      case DataSource.SEND_TIMEOUT:
        return Failure(
          statusCode: ResponseCode.SEND_TIMEOUT,
          message: ResponseMessage.SEND_TIMEOUT,
        );
      case DataSource.CACHE_ERROR:
        return Failure(
          statusCode: ResponseCode.CACHE_ERROR,
          message: ResponseMessage.CACHE_ERROR,
        );
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(
          statusCode: ResponseCode.NO_INTERNET_CONNECTION,
          message: ResponseMessage.NO_INTERNET_CONNECTION,
        );
      case DataSource.UNKNOWN:
        return Failure(
          statusCode: ResponseCode.UNKNOWN,
          message: ResponseMessage.UNKNOWN,
        );
    }
  }
}

class ResponseCode {
  // Remote Response Codes
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 403;
  static const int UNAUTHORISED = 401;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;

  // Local Response Code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int UNKNOWN = -7;
}

class ResponseMessage {
  // Remote Response Message
  static String get SUCCESS => StringsManager.success.tr();
  static String get NO_CONTENT => StringsManager.noContent.tr();
  static String get BAD_REQUEST => StringsManager.badRequest.tr();
  static String get FORBIDDEN => StringsManager.forbidden.tr();
  static String get UNAUTHORISED => StringsManager.unauthorised.tr();
  static String get NOT_FOUND => StringsManager.notFound.tr();
  static String get INTERNAL_SERVER_ERROR =>
      StringsManager.internalServerError.tr();

  // Local Response Message
  static String get CONNECT_TIMEOUT => StringsManager.connectTimeout.tr();
  static String get CANCEL => StringsManager.cancel.tr();
  static String get RECIEVE_TIMEOUT => StringsManager.recieveTimeout.tr();
  static String get SEND_TIMEOUT => StringsManager.sendTimeout.tr();
  static String get CACHE_ERROR => StringsManager.cacheError.tr();
  static String get NO_INTERNET_CONNECTION =>
      StringsManager.noInternetConnection.tr();
  static String get UNKNOWN => StringsManager.unknown.tr();
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
