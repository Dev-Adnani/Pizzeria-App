import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/app/routes/app.routes.dart';

class FooterNotfier with ChangeNotifier {
  Widget floatingActionButton({required BuildContext context}) {
    return FloatingActionButton(
      backgroundColor: Colors.orange.shade400,
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.cartRoute);
      },
      child: const Icon(EvaIcons.shoppingBagOutline),
    );
  }
}
