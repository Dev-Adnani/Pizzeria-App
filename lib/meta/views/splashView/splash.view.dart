import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pizzeria/app/routes/app.routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 4),
      () => Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.0,
              width: 400.0,
              child: Lottie.asset('assets/animation/pizza.json'),
            ),
            RichText(
              text: TextSpan(
                text: 'Food ',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'That Makes ',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  TextSpan(
                    text: 'You Cum',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Powered ',
                style: TextStyle(fontSize: 10.0, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'By Pizzeria',
                    style: TextStyle(fontSize: 10.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
