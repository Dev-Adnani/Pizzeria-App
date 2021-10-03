// App Routes Class For Adding All Routes - Dev Adnani
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/meta/views/cartView/cart.view.dart';
import 'package:pizzeria/meta/views/detailView/detail.view.dart';
import 'package:pizzeria/meta/views/homeView/home.view.dart';
import 'package:pizzeria/meta/views/loginView/login.view.dart';
import 'package:pizzeria/meta/views/mapsView/maps.view.dart';
import 'package:pizzeria/meta/views/splashView/splash.view.dart';

class AppRoutes {
  static const String splashRoute = "/splash";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String detailRoute = "/detail";
  static const String cartRoute = "/cart";
  static const String mapRoute = "/map";

  static final routes = {
    splashRoute: (context) => const SplashView(),
    homeRoute: (context) => const HomeView(),
    detailRoute: (context) => DetailScreen(
        queryDocumentSnapshot: ModalRoute.of(context)!.settings.arguments
            as QueryDocumentSnapshot),
    cartRoute: (context) => const CartView(),
    loginRoute: (context) => LoginView(),
    mapRoute: (context) => const Maps(),
  };
}
