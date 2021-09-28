// App Routes Class For Adding All Routes - Dev Adnani
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/meta/views/detailView/detail.view.dart';
import 'package:pizzeria/meta/views/homeView/home.view.dart';
import 'package:pizzeria/meta/views/splashView/splash.view.dart';

class AppRoutes {
  static const String splashRoute = "/splash";
  static const String homeRoute = "/home";
  static const String detailRoute = "/detail";

  static final routes = {
    splashRoute: (context) => SplashView(),
    homeRoute: (context) => HomeView(),
    detailRoute: (context) => DetailScreen(
        queryDocumentSnapshot: ModalRoute.of(context)!.settings.arguments
            as QueryDocumentSnapshot),
  };
}
