import 'dart:convert';

import 'package:bloc_mvvm_template/network/app_repository.dart';
import 'package:bloc_mvvm_template/screens/login/view_model/login_state.dart';
import 'package:bloc_mvvm_template/utils/enums/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  AppRepository appRepository = AppRepository();
  LoginCubit() : super(const LoginState());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    try {
      bool isValidCreds = _validateEmailAndPassword();

      if (isValidCreds) {
        await Future.delayed(const Duration(seconds: 3), () async {
          final result = await appRepository.login();
          final decodedResult = jsonDecode(result.toString());
          emit(state.copyWith(
              loadingState: LoadingState.loaded, userId: decodedResult['id']));
        });
        return;
      } else {
        emit(state.copyWith(
            loadingState: LoadingState.error,
            errorMessage: "Invalid email or password"));
        return;
      }
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(
          loadingState: LoadingState.error, errorMessage: e.toString()));
    }
  }

  bool _validateEmailAndPassword() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) return false;
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) return false;
    if (emailController.text.trim() == "admin" &&
        passwordController.text.trim() == "admin") return true;

    return false;
  }
}
