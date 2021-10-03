import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pizzeria/app/routes/app.routes.dart';
import 'package:pizzeria/core/models/addCart.model.dart';
import 'package:pizzeria/core/services/auth.service.dart';
import 'package:pizzeria/core/services/firebase.service.dart';
import 'package:pizzeria/core/services/maps.service.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

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
                cartData(context: context),
                shippingDetails(context: context),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
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

  Widget cartData({required BuildContext context}) {
    return SizedBox(
      height: 400.0,
      child: StreamBuilder<QuerySnapshot<AddCartModel>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(Provider.of<AuthNotifier>(context, listen: false).getUserUid)
            .collection('myOrders')
            .withConverter<AddCartModel>(
              fromFirestore: (snapshot, _) =>
                  AddCartModel.fromMap(snapshot.data()!),
              toFirestore: (model, _) => model.toMap(),
            )
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data!.docs.isEmpty ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animation/eating.json',
                  height: 250,
                  width: 250,
                ),
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    'Our Other Customers Have Already Ordered & Still You Are Thinking',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 3.1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SizedBox(
                                height: 80,
                                width: 80,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    snapshot.data!.docs[index].data().image,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index].data().name,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Price : ₹ ${snapshot.data!.docs[index].data().price.toString()}',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        'Cheese   : ${snapshot.data!.docs[index].data().cheeseValue.toString()}',
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Onion     : ${snapshot.data!.docs[index].data().onionValue.toString()}',
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Ketchup  : ${snapshot.data!.docs[index].data().ketchupValue.toString()}',
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            CircleAvatar(
                              child: Text(
                                snapshot.data!.docs[index].data().size,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    showAlertDialog(
                                      context: context,
                                      pizzaName: snapshot.data!.docs[index]
                                          .data()
                                          .name,
                                      cartPizzaID: snapshot.data!.docs[index]
                                          .data()
                                          .cartPizzaID,
                                    );
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.trashAlt,
                                    size: 24,
                                    color: Colors.red,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }

  showAlertDialog({
    required BuildContext context,
    required String pizzaName,
    required String cartPizzaID,
  }) {
    Widget cancelButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
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
        Provider.of<FirebaseService>(context, listen: false)
            .deleteDataFromCart(context: context, cartPizzaID: cartPizzaID)
            .whenComplete(() => Navigator.of(context).pop());
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Delete $pizzaName From Your Cart ?"),
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

  Widget shippingDetails({required BuildContext context}) {
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
        height: 200,
        width: MediaQuery.of(context).size.width,
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
                            constraints: const BoxConstraints(maxWidth: 200),
                            child: Expanded(
                              child: Text(
                                Provider.of<GenerateMaps>(context, listen: true)
                                    .getMainAddress,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.mapRoute);
                      },
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
