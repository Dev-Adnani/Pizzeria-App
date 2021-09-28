import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class FooterNotfier with ChangeNotifier {
  Widget floatingActionButton({required BuildContext context}) {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(EvaIcons.shoppingBagOutline),
    );
  }
}
