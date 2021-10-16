import 'dart:math';
import 'dart:ui';

import 'package:cache_manager/cache_manager.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzeria/app/constants/app.colors.dart';
import 'package:pizzeria/app/constants/app.discountCode.dart';
import 'package:pizzeria/app/constants/app.keys.dart';
import 'package:pizzeria/app/routes/app.routes.dart';
import 'package:pizzeria/core/notifiers/themeNotifier/theme.notifier.dart';
import 'package:pizzeria/core/services/maps.service.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/scratcher.dart';

class HeaderNotifier with ChangeNotifier {
  Widget appBar({required BuildContext context}) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    double _opacity = 0.0;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.locationArrow,
                  size: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 250,
                      maxHeight: 150,
                    ),
                    child: Text(
                      Provider.of<GenerateMaps>(context, listen: true)
                          .getFinalAddress,
                      style: TextStyle(
                        color: themeFlag ? Colors.white : AppColors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
            IconButton(
              onPressed: () {
                showMenu(
                    color: themeFlag ? AppColors.black : Colors.white,
                    context: context,
                    position: const RelativeRect.fromLTRB(300.0, 70.0, 0, 0),
                    items: [
                      PopupMenuItem(
                        child: Consumer<ThemeNotifier>(
                            builder: (context, notifier, child) {
                          return TextButton.icon(
                            onPressed: () {
                              notifier.toggleTheme();
                              Navigator.of(context).pop();
                            },
                            label: Text(
                              'Change Theme',
                              style: TextStyle(
                                color:
                                    themeFlag ? Colors.white : AppColors.black,
                              ),
                            ),
                            icon: Icon(
                              Icons.lightbulb_outline,
                              color: themeFlag ? Colors.white : AppColors.black,
                            ),
                          );
                        }),
                      ),
                      PopupMenuItem(
                        child: Consumer<ThemeNotifier>(
                            builder: (context, notifier, child) {
                          return TextButton.icon(
                            onPressed: () {
                              final _random = Random();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    title: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'You\'ve won a Coupon Code',
                                        style: TextStyle(
                                          color: themeFlag
                                              ? Colors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                    ),
                                    content: StatefulBuilder(builder:
                                        (context, StateSetter setState) {
                                      return Scratcher(
                                        color: Colors.blueGrey,
                                        accuracy: ScratchAccuracy.low,
                                        brushSize: 50,
                                        threshold: 25,
                                        onThreshold: () {
                                          setState(() {
                                            _opacity = 1;
                                          });
                                        },
                                        child: AnimatedOpacity(
                                          opacity: _opacity,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          child: Container(
                                            height: 300,
                                            width: 300,
                                            alignment: Alignment.center,
                                            child: Text(
                                              AppDiscount.couponListDisplay[
                                                  _random.nextInt(AppDiscount
                                                      .couponListDisplay
                                                      .length)],
                                              style: TextStyle(
                                                color: themeFlag
                                                    ? Colors.white
                                                    : AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              );
                            },
                            label: Text(
                              'Get A Coupon Code',
                              style: TextStyle(
                                color:
                                    themeFlag ? Colors.white : AppColors.black,
                              ),
                            ),
                            icon: Icon(
                              Icons.lightbulb_outline,
                              color: themeFlag ? Colors.white : AppColors.black,
                            ),
                          );
                        }),
                      ),
                      PopupMenuItem(
                        child: TextButton.icon(
                          onPressed: () {
                            showAlertDialog(context: context);
                          },
                          label: Text(
                            'Logout?',
                            style: TextStyle(
                              color: themeFlag ? Colors.white : AppColors.black,
                            ),
                          ),
                          icon: Icon(
                            EvaIcons.logOutOutline,
                            color: themeFlag ? Colors.white : AppColors.black,
                          ),
                        ),
                      )
                    ]);
              },
              icon: Icon(
                EvaIcons.moreVertical,
                color: themeFlag ? Colors.white : AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog({
    required BuildContext context,
  }) {
    Widget cancelButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.blueAccent,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.red,
        ),
      ),
      onPressed: () {
        DeleteCache.deleteKey(AppKeys.userEmail).whenComplete(() {
          DeleteCache.deleteKey(AppKeys.userPassword);
          Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute);
        });
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Are You Sure You Want To Logout ?"),
      content: const Text("You Will Regret About It!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget headerText({required BuildContext context}) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Container(
      constraints: const BoxConstraints(maxWidth: 250.0),
      child: RichText(
        text: TextSpan(
            text: 'What would you like',
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: themeFlag ? Colors.white : AppColors.black,
                fontSize: 30.0),
            children: [
              TextSpan(
                text: ' to eat?',
                style: TextStyle(
                  color: themeFlag ? Colors.white : AppColors.black,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
      ),
    );
  }

  Widget headerMenu({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  color: Colors.orange.shade100),
              height: 40.0,
              width: 100.0,
              child: Center(
                child: Text(
                  'All Food',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  color: Colors.orange.shade100),
              height: 40.0,
              width: 100.0,
              child: Center(
                child: Text(
                  'Pasta',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  color: Colors.orange.shade100),
              height: 40.0,
              width: 100.0,
              child: Center(
                child: Text(
                  'Pizza',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
