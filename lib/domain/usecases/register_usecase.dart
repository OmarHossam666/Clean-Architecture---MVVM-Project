import 'package:clean_architecture_mvvm/data/failure/failure.dart';
import 'package:clean_architecture_mvvm/data/request/requests.dart';
import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:clean_architecture_mvvm/domain/usecases/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUsecase
    extends BaseUsecase<RegisterUsecaseInput, Authentication> {
  final Repository _repository;

  RegisterUsecase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterUsecaseInput input) async {
    return await _repository.register(
      RegisterRequest(
        name: input.name,
        countryCode: input.countryCode,
        phoneNumber: input.phoneNumber,
        email: input.email,
        password: input.password,
      ),
    );
  }
}

class RegisterUsecaseInput {
  RegisterUsecaseInput({
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
