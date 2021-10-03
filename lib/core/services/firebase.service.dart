import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/core/services/auth.service.dart';
import 'package:provider/provider.dart';

class FirebaseService with ChangeNotifier {
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
    return firebaseFirestore
        .collection('users')
        .doc(Provider.of<AuthNotifier>(context, listen: false).getUserUid)
        .collection('myOrders')
        .doc(cartPizzaID)
        .set(data);
  }

  Future deleteDataFromCart(
      {required BuildContext context, required String cartPizzaID}) async {
    return firebaseFirestore
        .collection('users')
        .doc(Provider.of<AuthNotifier>(context, listen: false).getUserUid)
        .collection('myOrders')
        .doc(cartPizzaID)
        .delete();
  }

  Future placeOrder({
    required BuildContext context,
    required dynamic data,
  }) async {
    return firebaseFirestore.collection('admin').add(data);
  }
}
