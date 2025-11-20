import 'package:clean_architecture_mvvm/data/failure/failure.dart';
import 'package:clean_architecture_mvvm/data/request/requests.dart';
import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:clean_architecture_mvvm/domain/usecases/base_usecase.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUsecase
    implements BaseUsecase<ForgotPasswordUsecaseInput, ForgotPassword> {
  ForgotPasswordUsecase(this._repository);

  final Repository _repository;

  @override
  Future<Either<Failure, ForgotPassword>> execute(
    ForgotPasswordUsecaseInput input,
  ) async {
    return await _repository.forgotPassword(
      ForgotPasswordRequest(email: input.email),
    );
  }
}

class ForgotPasswordUsecaseInput {
  ForgotPasswordUsecaseInput({required this.email});
  final String email;
}
