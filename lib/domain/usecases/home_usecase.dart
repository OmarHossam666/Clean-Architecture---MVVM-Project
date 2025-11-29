import 'package:clean_architecture_mvvm/data/failure/failure.dart';
import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:clean_architecture_mvvm/domain/usecases/base_usecase.dart';
import 'package:dartz/dartz.dart';

class HomeUsecase extends BaseUsecase<void, HomeModel> {
  HomeUsecase(this._repository);

  final Repository _repository;

  @override
  Future<Either<Failure, HomeModel>> execute(void input) {
    return _repository.getHomeData();
  }
}
