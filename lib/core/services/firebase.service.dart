import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/core/models/addCart.model.dart';
import 'package:pizzeria/core/services/auth.service.dart';
import 'package:provider/provider.dart';

class FirebaseService with ChangeNotifier {
  int total = 0;
  bool couponCode = false;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future fetchData({required String collection}) async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection(collection).get();
    return querySnapshot.docs;
  }

  Future addDataToCart(
      {required BuildContext context,
      required dynamic data,
      required String cartPizzaID}) async {
    return await firebaseFirestore
        .collection('users')
        .doc(Provider.of<AuthNotifier>(context, listen: false).getUserUid)
        .collection('myOrders')
        .doc(cartPizzaID)
        .set(data);
  }

  Future deleteDataFromCart(
      {required BuildContext context, required String cartPizzaID}) async {
    return await firebaseFirestore
        .collection('users')
        .doc(Provider.of<AuthNotifier>(context, listen: false).getUserUid)
        .collection('myOrders')
        .doc(cartPizzaID)
        .delete();
  }

  void totalPrice({required BuildContext context}) {
    firebaseFirestore
        .collection('users')
        .doc(Provider.of<AuthNotifier>(context, listen: false).getUserUid)
        .collection('myOrders')
        .withConverter<AddCartModel>(
          fromFirestore: (snapshot, _) =>
              AddCartModel.fromMap(snapshot.data()!),
          toFirestore: (model, _) => model.toMap(),
        )
        .snapshots()
        .listen((snapshot) {
      int tempTotal =
          snapshot.docs.fold(0, (tot, doc) => tot + doc.data().price);
      total = tempTotal + 50;
      couponCode ? total - 30 : total;

      notifyListeners();
    });
  }

  void updateDiscount() {
    couponCode = true;
    total = total - 30;
    notifyListeners();
  }

  Future placeOrder({
    required BuildContext context,
    required dynamic data,
  }) async {
    return await firebaseFirestore.collection('admin').add(data);
  }
}
