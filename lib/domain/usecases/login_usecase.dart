import 'package:clean_architecture_mvvm/data/failure/failure.dart';
import 'package:clean_architecture_mvvm/data/request/requests.dart';
import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:clean_architecture_mvvm/domain/usecases/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase implements BaseUsecase<LoginUsecaseInput, Authentication> {
  LoginUsecase(this._repository);

  final Repository _repository;

  @override
  Future<Either<Failure, Authentication>> execute(
    LoginUsecaseInput input,
  ) async {
    return await _repository.login(
      LoginRequest(email: input.name, password: input.password),
    );
  }
}

class LoginUsecaseInput {
  final String name;
  final String password;

  LoginUsecaseInput({required this.name, required this.password});
}
