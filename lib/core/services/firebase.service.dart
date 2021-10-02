import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/core/services/auth.service.dart';
import 'package:provider/provider.dart';
import 'package:nanoid/nanoid.dart';

class FirebaseService with ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future fetchData({required String collection}) async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection(collection).get();
    return querySnapshot.docs;
  }

  Future addDataToCart(
      {required BuildContext context, required dynamic data}) async {
    var randomID = nanoid(10);
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<AuthNotifier>(context, listen: false).getUserUid)
        .collection('myOrders')
        .doc(randomID)
        .set(data);
  }
}
