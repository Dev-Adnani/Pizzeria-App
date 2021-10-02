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
      {required BuildContext context, required dynamic data}) async {
    return firebaseFirestore
        .collection('myOrders')
        .doc(Provider.of<AuthNotifier>(context, listen: false).getUserUid)
        .set(data);
  }
}
