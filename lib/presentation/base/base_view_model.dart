import 'dart:async';

import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel
    implements BaseViewModelInput, BaseViewModelOutput {
  final BehaviorSubject<FlowState> streamController =
      BehaviorSubject<FlowState>();

  @override
  Sink<FlowState> get inputState => streamController.sink;

  @override
  Stream<FlowState> get outputState => streamController.stream;

  /// Safely emits a [FlowState] to the stream if the controller is not closed.
  ///
  /// This method should be used instead of directly calling `inputState.add()`
  /// to prevent errors when the controller is already disposed.
  void safeEmitState(FlowState state) {
    if (!streamController.isClosed) {
      inputState.add(state);
    }
  }

  void resetToContentState() {
    safeEmitState(ContentState());
  }

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
