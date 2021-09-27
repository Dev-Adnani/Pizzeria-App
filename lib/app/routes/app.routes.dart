// App Routes Class For Adding All Routes - Dev Adnani
import 'package:pizzeria/meta/views/homeView/home.view.dart';
import 'package:pizzeria/meta/views/splashView/splash.view.dart';

class AppRoutes {
  static const String splashRoute = "/splash";
  static const String homeRoute = "/home";

  static final routes = {
    splashRoute: (context) => SplashView(),
    homeRoute: (context) => HomeView(),
  };
}
