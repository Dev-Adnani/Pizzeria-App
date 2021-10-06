import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzeria/app/constants/app.colors.dart';
import 'package:pizzeria/app/routes/app.routes.dart';
import 'package:pizzeria/core/models/addCart.model.dart';
import 'package:pizzeria/core/notifiers/detailNotifers/detail.calculations.notifier.dart';
import 'package:pizzeria/core/notifiers/themeNotifier/theme.notifier.dart';
import 'package:provider/provider.dart';
import 'package:nanoid/nanoid.dart';

class DetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  const DetailScreen({Key? key, required this.queryDocumentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: floatingButton(context: context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: themeFlag ? AppColors.black : Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context: context),
              pizzaImage(),
              middleData(context: context),
              footerData(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar({required BuildContext context}) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () async {
            await Provider.of<DetailCalculations>(context, listen: false)
                .removeAllData();
            Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
          },
          icon: Icon(Icons.arrow_back_ios,
              color: themeFlag ? Colors.white : AppColors.black),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 280.0),
          child: IconButton(
            onPressed: () async {
              await Provider.of<DetailCalculations>(context, listen: false)
                  .removeAllData();
            },
            icon: const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }

  Widget pizzaImage() {
    return Center(
      child: SizedBox(
        height: 280.0,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(queryDocumentSnapshot['image']),
        ),
      ),
    );
  }

  Widget middleData({required BuildContext context}) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow.shade700,
                size: 20,
              ),
              Text(
                queryDocumentSnapshot['rating'],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: themeFlag ? Colors.white : AppColors.black,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                  ),
                  child: Text(
                    queryDocumentSnapshot['name'],
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: themeFlag ? Colors.white : AppColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.rupeeSign,
                size: 20,
                color: Colors.cyan,
              ),
              Text(
                queryDocumentSnapshot['price'].toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget footerData({required BuildContext context}) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 300.0,
        child: Stack(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: themeFlag ? AppColors.black : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 5,
                        spreadRadius: 3),
                  ]),
              width: 400.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<DetailCalculations>(context,
                                    listen: false)
                                .selectSmallSize();
                          },
                          child: Container(
                            height: 45,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Provider.of<DetailCalculations>(context,
                                          listen: true)
                                      .smallTapped
                                  ? Colors.lightBlueAccent
                                  : Colors.white,
                              border: Border.all(color: Colors.orange.shade500),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'S',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<DetailCalculations>(context,
                                    listen: false)
                                .selectMediumSize();
                          },
                          child: Container(
                            height: 45,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Provider.of<DetailCalculations>(context,
                                          listen: true)
                                      .mediumTapped
                                  ? Colors.lightBlueAccent
                                  : Colors.white,
                              border: Border.all(color: Colors.orange.shade500),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: Text(
                                  'M',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<DetailCalculations>(context,
                                    listen: false)
                                .selectLargeSize();
                          },
                          child: Container(
                            height: 45,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Provider.of<DetailCalculations>(context,
                                          listen: true)
                                      .largeTapped
                                  ? Colors.lightBlueAccent
                                  : Colors.white,
                              border: Border.all(color: Colors.orange.shade500),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'L',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 15.0),
                    child: Text(
                      'Add more stuff',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w200,
                        color: themeFlag ? Colors.white : AppColors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cheese',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            color: themeFlag ? Colors.white : AppColors.black,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Provider.of<DetailCalculations>(context,
                                        listen: false)
                                    .removeCheese();
                              },
                              icon: const Icon(EvaIcons.minus),
                            ),
                            Text(
                              '${Provider.of<DetailCalculations>(context, listen: true).getCheeseValue}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color:
                                    themeFlag ? Colors.white : AppColors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Provider.of<DetailCalculations>(context,
                                        listen: false)
                                    .addCheese();
                              },
                              icon: const Icon(EvaIcons.plus),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Onion',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            color: themeFlag ? Colors.white : AppColors.black,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Provider.of<DetailCalculations>(context,
                                        listen: false)
                                    .removeOnion();
                              },
                              icon: const Icon(EvaIcons.minus),
                            ),
                            Text(
                              '${Provider.of<DetailCalculations>(context, listen: true).getOnionValue}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color:
                                    themeFlag ? Colors.white : AppColors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Provider.of<DetailCalculations>(context,
                                        listen: false)
                                    .addOnion();
                              },
                              icon: const Icon(EvaIcons.plus),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ketchup',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            color: themeFlag ? Colors.white : AppColors.black,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Provider.of<DetailCalculations>(context,
                                        listen: false)
                                    .removeKetchup();
                              },
                              icon: const Icon(EvaIcons.minus),
                            ),
                            Text(
                              '${Provider.of<DetailCalculations>(context, listen: true).getKetchupValue}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color:
                                    themeFlag ? Colors.white : AppColors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Provider.of<DetailCalculations>(context,
                                        listen: false)
                                    .addKetchup();
                              },
                              icon: const Icon(EvaIcons.plus),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget floatingButton({required BuildContext context}) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            if (Provider.of<DetailCalculations>(context, listen: false)
                        .smallTapped !=
                    false ||
                Provider.of<DetailCalculations>(context, listen: false)
                        .mediumTapped !=
                    false ||
                Provider.of<DetailCalculations>(context, listen: false)
                        .largeTapped !=
                    false) {
              var cartPizzaID = nanoid(5);
              final AddCartModel addCartModel = AddCartModel(
                  cartPizzaID: cartPizzaID,
                  image: queryDocumentSnapshot['image'],
                  name: queryDocumentSnapshot['name'],
                  size: Provider.of<DetailCalculations>(context, listen: false)
                      .getSize!,
                  price: queryDocumentSnapshot['price'],
                  cheeseValue:
                      Provider.of<DetailCalculations>(context, listen: false)
                          .cheeseValue,
                  ketchupValue:
                      Provider.of<DetailCalculations>(context, listen: false)
                          .ketchupValue,
                  onionValue:
                      Provider.of<DetailCalculations>(context, listen: false)
                          .onionValue);
              //Data
              Provider.of<DetailCalculations>(context, listen: false).addToCart(
                context: context,
                data: addCartModel.toMap(),
                cartPizzaID: cartPizzaID,
              );
              Fluttertoast.showToast(
                msg: "Added Successfully To Cart",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade500,
                textColor: Colors.white70,
                fontSize: 16.0,
              );
            } else {
              Fluttertoast.showToast(
                  msg: "Please Select Pizza Size",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey.shade500,
                  textColor: Colors.white70,
                  fontSize: 16.0);
            }
          },
          child: Container(
            width: 250.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.orange.shade400,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Center(
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: themeFlag ? AppColors.black : Colors.white,
                ),
              ),
            ),
          ),
        ),
        FloatingActionButton(
          backgroundColor: Colors.orange.shade400,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.cartRoute);
          },
          child: Icon(
            EvaIcons.shoppingBagOutline,
            color: themeFlag ? AppColors.black : Colors.white,
          ),
        ),
      ],
    );
  }
}
