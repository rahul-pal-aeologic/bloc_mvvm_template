import 'package:auto_route/auto_route.dart';
import 'package:bloc_mvvm_template/screens/login/view_model/login_state.dart';
import 'package:bloc_mvvm_template/screens/login/view_model/login_view_model.dart';
import 'package:bloc_mvvm_template/utils/enums/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
          if (state.errorMessage != '' && state.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage ?? 'Something went wrong'),
              ));
            });
          }

          return Column(
            children: [
              const Text('Login Screen'),
              TextField(
                controller: context.read<LoginCubit>().emailController,
              ),
              TextField(
                controller: context.read<LoginCubit>().passwordController,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<LoginCubit>().login();
                  },
                  child: (state.loadingState == LoadingState.loading )
                      ? const CircularProgressIndicator()
                      : const Text('Login')),
              if (state.loadingState == LoadingState.loaded)
                Text("Login Successfully with userId ${state.userId}"),
            ],
          );
        }),
      ),
    );
  }
}
