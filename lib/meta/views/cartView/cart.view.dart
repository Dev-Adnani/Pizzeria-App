import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pizzeria/app/constants/app.colors.dart';
import 'package:pizzeria/app/constants/app.discountCode.dart';
import 'package:pizzeria/app/constants/app.keys.dart';
import 'package:pizzeria/app/routes/app.routes.dart';
import 'package:pizzeria/core/models/addCart.model.dart';
import 'package:pizzeria/core/notifiers/themeNotifier/theme.notifier.dart';
import 'package:pizzeria/core/services/auth.service.dart';
import 'package:pizzeria/core/services/firebase.service.dart';
import 'package:pizzeria/core/services/maps.service.dart';
import 'package:pizzeria/core/services/payment.service.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  Razorpay razorpay = Razorpay();
  bool check = false;

  TextEditingController couponText = TextEditingController();

  @override
  void initState() {
    razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        Provider.of<PaymentService>(context, listen: false)
            .handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        Provider.of<PaymentService>(context, listen: false).handlePaymentError);
    razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET,
        Provider.of<PaymentService>(context, listen: false)
            .handleExternalWallet);
    Provider.of<FirebaseService>(context, listen: false)
        .totalPrice(context: context);
    super.initState();
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  Future checkMeOut() async {
    var options = {
      'key': AppKeys.razorKey,
      'amount': Provider.of<FirebaseService>(context, listen: false).total,
      'name': Provider.of<AuthNotifier>(context, listen: false).getUserEmail,
      'description': 'Payment',
      'prefill': {
        'contact': '8888888888',
        'email': Provider.of<AuthNotifier>(context, listen: false).getUserEmail,
      },
      'external': {
        'wallet': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(context: context),
                headerText(context: context),
                cartData(context: context),
                shippingDetails(context: context),
                const SizedBox(
                  height: 30,
                ),
                floatingButton(context: context),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
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

  Widget headerText({required BuildContext context}) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Column(
      children: [
        Text(
          'Your',
          style: TextStyle(
              color: themeFlag ? Colors.white : AppColors.black,
              fontSize: 18.0),
        ),
        const Text(
          'Cart',
          style: TextStyle(
              color: Colors.red, fontSize: 40.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget cartData({required BuildContext context}) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
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
          if (snapshot.data!.docs.isEmpty) {
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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animation/pizza.json',
                    height: 250,
                    width: 250,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      ' Loading........',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
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
                          color: themeFlag ? AppColors.black : Colors.white,
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
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: themeFlag
                                          ? Colors.white
                                          : AppColors.black,
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
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          color: themeFlag
                                              ? Colors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                      Text(
                                        'Cheese   : ${snapshot.data!.docs[index].data().cheeseValue.toString()}',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: themeFlag
                                              ? Colors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                      Text(
                                        'Onion     : ${snapshot.data!.docs[index].data().onionValue.toString()}',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: themeFlag
                                              ? Colors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                      Text(
                                        'Ketchup  : ${snapshot.data!.docs[index].data().ketchupValue.toString()}',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: themeFlag
                                              ? Colors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor:
                                  themeFlag ? Colors.white : AppColors.tealDark,
                              child: Text(
                                snapshot.data!.docs[index].data().size,
                                style: TextStyle(
                                  color: themeFlag
                                      ? AppColors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    Provider.of<FirebaseService>(context,
                                            listen: false)
                                        .deleteDataFromCart(
                                            context: context,
                                            cartPizzaID: snapshot
                                                .data!.docs[index]
                                                .data()
                                                .cartPizzaID);
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

  Widget shippingDetails({required BuildContext context}) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
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
          color: themeFlag ? AppColors.black : Colors.white,
        ),
        height: 300,
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
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<PaymentService>(context, listen: false)
                            .selectLocation(context);
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
                        const Icon(Icons.card_giftcard),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 200),
                            child: TextFormField(
                              controller: couponText,
                              decoration: const InputDecoration(
                                hintText: 'Enter Coupon Code',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      child: const Text('Apply'),
                      onPressed: () {
                        if (couponText.text.isNotEmpty) {
                          if (AppDiscount.couponCode
                              .contains(couponText.text)) {
                            if (check == false) {
                              Provider.of<FirebaseService>(context,
                                      listen: false)
                                  .updateDiscount();
                              Fluttertoast.showToast(
                                  msg: "Ohh Yeah Coupon Applied",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey.shade500,
                                  textColor: Colors.white70,
                                  fontSize: 16.0);
                              check = true;
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: "Oops Wrong Coupon Code",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade500,
                              textColor: Colors.white70,
                              fontSize: 16.0,
                            );
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Ehh Atleast Enter A Coupon!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade500,
                              textColor: Colors.white70,
                              fontSize: 16.0);
                        }
                      },
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
                            child: Text(
                              'Delivery Time : ${Provider.of<PaymentService>(context, listen: true).deliveryTiming == TimeOfDay.now() ? "" : Provider.of<PaymentService>(context, listen: true).deliveryTiming.format(context)}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<PaymentService>(context, listen: false)
                            .selectTime(context: context);
                      },
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
                    Text(
                      '50',
                      style: TextStyle(
                        color: themeFlag ? Colors.white : AppColors.black,
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
                    Text(
                      Provider.of<FirebaseService>(context, listen: true)
                          .total
                          .toString(),
                      style: TextStyle(
                        color: themeFlag ? Colors.white : AppColors.black,
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

  Widget floatingButton({required BuildContext context}) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            checkMeOut();
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
                'Place Order',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: themeFlag ? Colors.white : AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
