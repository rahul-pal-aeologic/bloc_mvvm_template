// enum LoadingState { loading, loaded, error }

import 'package:bloc_mvvm_template/utils/enums/state_enum.dart';

class BaseState<T> {
  final LoadingState loadingState;
  final T? data;
  final String? errorMessage;
  BaseState({
    this.loadingState = LoadingState.loading,
    this.data,
    this.errorMessage,
  });
}
