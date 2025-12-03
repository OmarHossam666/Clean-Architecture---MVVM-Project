import 'package:clean_architecture_mvvm/data/data_source/local_data_source.dart';
import 'package:clean_architecture_mvvm/data/data_source/remote_data_source.dart';
import 'package:clean_architecture_mvvm/data/error/error_handler.dart';
import 'package:clean_architecture_mvvm/data/failure/failure.dart';
import 'package:clean_architecture_mvvm/data/mapper/mappers.dart';
import 'package:clean_architecture_mvvm/data/network_information/network_information.dart';
import 'package:clean_architecture_mvvm/data/request/requests.dart';
import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImplementation implements Repository {
  RepositoryImplementation({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInformation,
  });

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInformation networkInformation;

  @override
  Future<Either<Failure, Authentication>> login(
    LoginRequest loginRequest,
  ) async {
    if (await networkInformation.isConnected) {
      try {
        final response = await remoteDataSource.login(loginRequest);

        if (response.token != null && response.user != null) {
          return Right(response.toDomain());
        }

        final statusCode = response.status ?? ResponseCode.UNKNOWN;
        if (statusCode == ApiInternalStatus.success ||
            statusCode == ResponseCode.SUCCESS ||
            statusCode == ResponseCode.NO_CONTENT) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              message: response.message ?? ResponseMessage.UNKNOWN,
              statusCode: statusCode,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgotPassword>> forgotPassword(
    ForgotPasswordRequest forgotPasswordRequest,
  ) async {
    if (await networkInformation.isConnected) {
      try {
        final response = await remoteDataSource.forgotPassword(
          forgotPasswordRequest,
        );

        final statusCode = response.status ?? ResponseCode.UNKNOWN;
        if (statusCode == ApiInternalStatus.success ||
            statusCode == ResponseCode.SUCCESS ||
            statusCode == ResponseCode.NO_CONTENT ||
            statusCode == ResponseCode.UNKNOWN) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              message: response.message ?? ResponseMessage.UNKNOWN,
              statusCode: statusCode,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
    RegisterRequest registerRequest,
  ) async {
    if (await networkInformation.isConnected) {
      try {
        final response = await remoteDataSource.register(registerRequest);

        final statusCode = response.status ?? ResponseCode.UNKNOWN;

        if (statusCode == ApiInternalStatus.success ||
            statusCode == ResponseCode.SUCCESS ||
            statusCode == ResponseCode.NO_CONTENT) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              message: response.message ?? ResponseMessage.UNKNOWN,
              statusCode: statusCode,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeModel>> getHomeData() async {
    try {
      final response = await localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await networkInformation.isConnected) {
        try {
          final response = await remoteDataSource.getHomeData();

          final statusCode = response.status ?? ResponseCode.UNKNOWN;
          if (statusCode == ApiInternalStatus.success ||
              statusCode == ResponseCode.SUCCESS ||
              statusCode == ResponseCode.NO_CONTENT) {
            localDataSource.cacheHomeData(response);

            return Right(response.toDomain());
          } else {
            return Left(
              Failure(
                message: response.message ?? ResponseMessage.UNKNOWN,
                statusCode: statusCode,
              ),
            );
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}
