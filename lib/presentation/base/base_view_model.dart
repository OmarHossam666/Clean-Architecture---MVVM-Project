import 'dart:async';

import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';

abstract class BaseViewModel
    implements BaseViewModelInput, BaseViewModelOutput {
  final StreamController<FlowState> streamController =
      StreamController<FlowState>.broadcast();


  @override
  Sink<FlowState> get inputState => streamController.sink;

  @override
  Stream<FlowState> get outputState => streamController.stream;

  @override
  void dispose() {
    streamController.close();
  }
}

abstract class BaseViewModelInput {
  void start(); //? used to initialize the view model

  Sink<FlowState> get inputState;

  void dispose(); //? used to dispose the view model
}

abstract class BaseViewModelOutput {
  Stream<FlowState> get outputState;
}
