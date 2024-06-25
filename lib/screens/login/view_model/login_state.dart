import 'package:bloc_mvvm_template/utils/enums/state_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_state.freezed.dart';
part 'login_state.g.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoadingState.idle) LoadingState loadingState,
    String? errorMessage,
    @Default('') String userId,
  }) = _LoginState;

  factory LoginState.fromJson(Map<String, dynamic> json) =>
      _$LoginStateFromJson(json);
}
