import 'package:flutter/material.dart';
import 'package:pizzeria/core/notifiers/header.notifier.dart';
import 'package:pizzeria/core/notifiers/middle.notifier.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderNotifier().appBar(context: context),
                HeaderNotifier().headerText(),
                HeaderNotifier().headerMenu(context: context),
                Divider(),
                MiddleNotifier().textFav(),
                MiddleNotifier().dataFav(context: context, collection: 'fav'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
