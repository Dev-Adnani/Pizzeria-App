import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pizzeria/app/routes/app.routes.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(context: context),
                headerText(),
                cartData(),
                shippingDetails(address: 'Mock Data', context: context),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: floatingButton(),
    );
  }

  Widget appBar({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 280.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }

  Widget headerText() {
    return Column(
      children: const [
        Text(
          'Your',
          style: TextStyle(color: Colors.grey, fontSize: 18.0),
        ),
        Text(
          'Cart',
          style: TextStyle(
              color: Colors.red, fontSize: 40.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget cartData() {
    return SizedBox(
      height: 300.0,
    );
  }

  Widget shippingDetails(
      {required String address, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 5,
              spreadRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.white,
        ),
        height: 300,
        width: 400.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(FontAwesomeIcons.locationArrow),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Text(
                              'Mock Address Here',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(FontAwesomeIcons.clock),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Text(
                              'Delivery Time',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 35, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(FontAwesomeIcons.rupeeSign),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Text(
                              '300',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '300',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 35, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(EvaIcons.person),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Text(
                              'Delivery Guy Charges',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '300',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 35, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(FontAwesomeIcons.rupeeSign),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Text(
                              'Total ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '300',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget floatingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 250.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.orange.shade400,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: const Center(
              child: Text(
                'Place Order',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
