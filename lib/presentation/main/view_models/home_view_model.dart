import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:clean_architecture_mvvm/domain/usecases/home_usecase.dart';
import 'package:clean_architecture_mvvm/presentation/base/base_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInputs, HomeViewModelOutputs {
  HomeViewModel({required this.homeUsecase});

  final HomeUsecase homeUsecase;
  final _servicesStreamController = BehaviorSubject<List<Service>>();
  final _bannersStreamController = BehaviorSubject<List<Banner>>();
  final _storesStreamController = BehaviorSubject<List<Store>>();

  @override
  void start() {
    getHomeData();
  }

  Future<void> getHomeData() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
        message: StringsManager.loading,
      ),
    );

    await homeUsecase.execute(null).then((value) {
      value.fold(
        (failure) {
          inputState.add(
            ErrorState(
              message: failure.message,
              stateRendererType: StateRendererType.fullScreenErrorState,
            ),
          );
        },
        (homeModel) {
          inputState.add(ContentState());
          inputServices.add(homeModel.data.services);
          inputBanners.add(homeModel.data.banners);
          inputStores.add(homeModel.data.stores);
        },
      );
    });
  }

  @override
  void dispose() {
    _servicesStreamController.close();
    _bannersStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  @override
  Stream<List<Banner>> get outputBanners => _bannersStreamController.stream;

  @override
  Stream<List<Service>> get outputServices => _servicesStreamController.stream;

  @override
  Stream<List<Store>> get outputStores => _storesStreamController.stream;
}

abstract class HomeViewModelInputs {
  Sink get inputServices;
  Sink get inputBanners;
  Sink get inputStores;
}

abstract class HomeViewModelOutputs {
  Stream<List<Service>> get outputServices;
  Stream<List<Banner>> get outputBanners;
  Stream<List<Store>> get outputStores;
}
