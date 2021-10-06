import 'package:flutter/material.dart';
import 'package:pizzeria/app/constants/app.colors.dart';
import 'package:pizzeria/core/notifiers/homeNotifiers/footer.notifier.dart';
import 'package:pizzeria/core/notifiers/homeNotifiers/header.notifier.dart';
import 'package:pizzeria/core/notifiers/homeNotifiers/middle.notifier.dart';
import 'package:pizzeria/core/notifiers/themeNotifier/theme.notifier.dart';
import 'package:pizzeria/core/services/maps.service.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Provider.of<GenerateMaps>(context, listen: false).getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderNotifier().appBar(context: context),
              HeaderNotifier().headerText(context: context),
              HeaderNotifier().headerMenu(context: context),
              const Divider(),
              MiddleNotifier().favText(context: context),
              MiddleNotifier().favData(context: context, collection: 'fav'),
              MiddleNotifier().businessText(context: context),
              MiddleNotifier()
                  .businessData(context: context, collection: 'fav'),
            ],
          ),
        ),
      ),
      floatingActionButton:
          FooterNotfier().floatingActionButton(context: context),
    );
  }
}
