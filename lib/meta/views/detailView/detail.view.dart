import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzeria/app/routes/app.routes.dart';
import 'package:pizzeria/core/models/addCart.model.dart';
import 'package:pizzeria/core/notifiers/detailNotifers/detail.calculations.notifier.dart';
import 'package:provider/provider.dart';
import 'package:nanoid/nanoid.dart';

class DetailScreen extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  const DetailScreen({Key? key, required this.queryDocumentSnapshot})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: floatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context: context),
              pizzaImage(),
              middleData(),
              footerData(),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () async {
            await Provider.of<DetailCalculations>(context, listen: false)
                .removeAllData();
            Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
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
          child: Image.network(widget.queryDocumentSnapshot['image']),
        ),
      ),
    );
  }

  Widget middleData() {
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
                widget.queryDocumentSnapshot['rating'],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
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
                    widget.queryDocumentSnapshot['name'],
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
                widget.queryDocumentSnapshot['price'].toString(),
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

  Widget footerData() {
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
                  color: Colors.white,
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
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                    child: Text(
                      'Add more stuff',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cheese',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
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
                                color: Colors.grey.shade500,
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
                        const Text(
                          'Onion',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
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
                                color: Colors.grey.shade500,
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
                        const Text(
                          'Ketchup',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
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
                                color: Colors.grey.shade500,
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

  Widget floatingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            var cartPizzaID = nanoid(5);
            final AddCartModel addCartModel = AddCartModel(
                cartPizzaID: cartPizzaID,
                image: widget.queryDocumentSnapshot['image'],
                name: widget.queryDocumentSnapshot['name'],
                size: Provider.of<DetailCalculations>(context, listen: false)
                    .getSize!,
                price: widget.queryDocumentSnapshot['price'],
                cheeseValue:
                    Provider.of<DetailCalculations>(context, listen: false)
                        .cheeseValue,
                ketchupValue:
                    Provider.of<DetailCalculations>(context, listen: false)
                        .ketchupValue,
                onionValue:
                    Provider.of<DetailCalculations>(context, listen: false)
                        .onionValue);
            Provider.of<DetailCalculations>(context, listen: false).addToCart(
              context: context,
              data: addCartModel.toMap(),
              cartPizzaID: cartPizzaID,
            );
          },
          child: Container(
            width: 250.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.orange.shade400,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: const Center(
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Stack(
          children: [
            FloatingActionButton(
              backgroundColor: Colors.orange.shade400,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.cartRoute);
              },
              child: const Icon(Icons.shopping_bag),
            ),
            Positioned(
              left: 32,
              child: CircleAvatar(
                backgroundColor: Colors.cyan,
                radius: 10,
                child: Text(
                  '${Provider.of<DetailCalculations>(context, listen: false).getCartData}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
