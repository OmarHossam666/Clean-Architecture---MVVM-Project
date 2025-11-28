import 'package:clean_architecture_mvvm/data/failure/failure.dart';
import 'package:clean_architecture_mvvm/data/request/requests.dart';
import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, ForgotPassword>> forgotPassword(
    ForgotPasswordRequest forgotPasswordRequest,
  );
  Future<Either<Failure, Authentication>> register(
    RegisterRequest registerRequest,
  );
  Future<Either<Failure, HomeModel>> getHomeData();
}
