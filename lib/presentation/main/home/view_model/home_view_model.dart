import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:clean_architecture_mvvm/domain/usecases/home_usecase.dart';
import 'package:clean_architecture_mvvm/presentation/base/base_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInputs, HomeViewModelOutputs {
  HomeViewModel({required this.homeUsecase});

  final HomeUsecase homeUsecase;
  final _homeStreamController = BehaviorSubject<HomeModel>();

  @override
  void start() {
    getHomeData();
  }

  Future<void> getHomeData() async {
    if (!streamController.isClosed) {
      inputState.add(
        LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState,
          message: StringsManager.loading.tr(),
        ),
      );
    }

    await homeUsecase.execute(null).then((value) {
      value.fold(
        (failure) {
          if (!streamController.isClosed) {
            inputState.add(
              ErrorState(
                message: failure.message,
                stateRendererType: StateRendererType.fullScreenErrorState,
              ),
            );
          }
        },
        (homeModel) {
          if (!_homeStreamController.isClosed) {
            inputHome.add(homeModel);
          }
          if (!streamController.isClosed) {
            inputState.add(ContentState());
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _homeStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHome => _homeStreamController.sink;

  @override
  Stream<HomeModel> get outputHome => _homeStreamController.stream;
}

abstract class HomeViewModelInputs {
  Sink get inputHome;
}

abstract class HomeViewModelOutputs {
  Stream<HomeModel> get outputHome;
}
