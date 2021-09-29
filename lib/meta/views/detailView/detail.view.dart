import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzeria/app/routes/app.routes.dart';

class DetailScreen extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  DetailScreen({Key? key, required this.queryDocumentSnapshot})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int cheeseValue = 0;
  int ketchupValue = 0;
  int onionValue = 0;
  int totalItems = 0;

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
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 280.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
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
          decoration: BoxDecoration(
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
                  constraints: BoxConstraints(
                    maxWidth: 300,
                  ),
                  child: Text(
                    widget.queryDocumentSnapshot['name'],
                    style: TextStyle(
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
              Icon(
                FontAwesomeIcons.rupeeSign,
                size: 20,
                color: Colors.cyan,
              ),
              Text(
                widget.queryDocumentSnapshot['price'].toString(),
                style: TextStyle(
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
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.orange.shade500),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'S',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.orange.shade500),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'M',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.orange.shade500),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'L',
                                style: TextStyle(
                                  fontSize: 20.0,
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
                        Text(
                          'Cheese',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w200,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(EvaIcons.plus),
                            ),
                            Text(
                              '$cheeseValue',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(EvaIcons.minus),
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
                            fontWeight: FontWeight.w200,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(EvaIcons.plus),
                            ),
                            Text(
                              '$onionValue',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(EvaIcons.minus),
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
                            fontWeight: FontWeight.w200,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(EvaIcons.plus),
                            ),
                            Text(
                              '$ketchupValue',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(EvaIcons.minus),
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
          onTap: () {},
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
              onPressed: () {},
              child: Icon(Icons.shopping_bag),
            ),
            Positioned(
              left: 32,
              child: CircleAvatar(
                backgroundColor: Colors.cyan,
                radius: 10,
                child: Text(
                  '$totalItems',
                  style: TextStyle(
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
