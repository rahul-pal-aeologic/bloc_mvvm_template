import 'package:auto_route/auto_route.dart';
import 'package:bloc_mvvm_template/screens/login/view/login_screen.dart';
import 'package:bloc_mvvm_template/screens/splash/view/splash_screen.dart';

part 'app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SplashRoute.page, initial: true),
  ];
}