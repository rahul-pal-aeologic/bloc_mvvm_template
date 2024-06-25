import 'package:auto_route/auto_route.dart';
import 'package:bloc_mvvm_template/config/routes/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {

        Future.delayed(Duration(seconds: 3), () {
          context.router.replace(const LoginRoute());
        });
        
        return Scaffold(
          body: Container(
            child: Center(
              child: Icon(Icons.home),
            ),
          )
        );
      }
    );
  }
}