import 'package:clean_architecture_mvvm/domain/models/models.dart';
import 'package:clean_architecture_mvvm/domain/usecases/store_details_usecase.dart';
import 'package:clean_architecture_mvvm/presentation/base/base_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    implements StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  StoreDetailsViewModel({required this.storeDetailsUsecase});

  final StoreDetailsUsecase storeDetailsUsecase;
  final BehaviorSubject<StoreDetails> _storeDetailsStreamController =
      BehaviorSubject<StoreDetails>();

  @override
  void start() {
    getStoreDetails();
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  Future<void> getStoreDetails() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
        message: StringsManager.loading,
      ),
    );

    await storeDetailsUsecase.execute(null).then((value) {
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
        (storeDetails) {
          if (!_storeDetailsStreamController.isClosed) {
            storeDetailsInput.add(storeDetails);
          }
          if (!streamController.isClosed) {
            inputState.add(ContentState());
          }
        },
      );
    });
  }

  @override
  Sink<StoreDetails> get storeDetailsInput =>
      _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetails> get storeDetailsOutput =>
      _storeDetailsStreamController.stream;
}

abstract class StoreDetailsViewModelInputs {
  Sink<StoreDetails> get storeDetailsInput;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetails> get storeDetailsOutput;
}
