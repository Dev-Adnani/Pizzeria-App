import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizzeria/core/services/firebase.service.dart';
import 'package:provider/provider.dart';

class DetailCalculations with ChangeNotifier {
  int cheeseValue = 0;
  int onionValue = 0;
  int cartData = 0;
  int ketchupValue = 0;
  String? size;

  bool smallTapped = false;
  bool mediumTapped = false;
  bool largeTapped = false;
  bool selected = false;

  int? get getCheeseValue => cheeseValue;
  int? get getOnionValue => onionValue;
  String? get getSize => size;
  int? get getCartData => cartData;
  int? get getKetchupValue => ketchupValue;
  bool? get getSelected => selected;

  addCheese() {
    if (cheeseValue >= 5) {
      Fluttertoast.showToast(
        msg: "We Care For Our Customer's , Hence No More Cheese Is Allowed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade500,
        textColor: Colors.white70,
        fontSize: 16.0,
      );
      notifyListeners();
    } else {
      cheeseValue++;
      notifyListeners();
    }
  }

  addOnion() {
    if (onionValue >= 5) {
      Fluttertoast.showToast(
        msg: "Do You Want To Eat Pizza Or Onions ?",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade500,
        textColor: Colors.white70,
        fontSize: 16.0,
      );
      notifyListeners();
    } else {
      onionValue++;
      notifyListeners();
    }
  }

  addKetchup() {
    if (ketchupValue >= 5) {
      Fluttertoast.showToast(
        msg: "Sir Its Ketchup Not Cold drink!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade500,
        textColor: Colors.white70,
        fontSize: 16.0,
      );
      notifyListeners();
    } else {
      ketchupValue++;
      notifyListeners();
    }
  }

  removeCheese() {
    if (cheeseValue <= 0) {
      Fluttertoast.showToast(
        msg: "No Cheese Will Be Added In Your Pizza",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade500,
        textColor: Colors.white70,
        fontSize: 16.0,
      );
      notifyListeners();
    } else {
      cheeseValue--;
      notifyListeners();
    }
  }

  removeOnion() {
    if (onionValue <= 0) {
      Fluttertoast.showToast(
        msg: "No Onion Will Be Added In Your Pizza",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade500,
        textColor: Colors.white70,
        fontSize: 16.0,
      );
      notifyListeners();
    } else {
      onionValue--;
      notifyListeners();
    }
  }

  removeKetchup() {
    if (ketchupValue <= 0) {
      Fluttertoast.showToast(
        msg: "No Ketchup Will Be Added In Your Pizza",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade500,
        textColor: Colors.white70,
        fontSize: 16.0,
      );
      notifyListeners();
    } else {
      ketchupValue--;
      notifyListeners();
    }
  }

  selectSmallSize() {
    smallTapped = true;
    mediumTapped = false;
    largeTapped = false;
    size = 'S';
    notifyListeners();
  }

  selectMediumSize() {
    mediumTapped = true;
    smallTapped = false;
    largeTapped = false;
    size = 'M';
    notifyListeners();
  }

  selectLargeSize() {
    largeTapped = true;
    smallTapped = false;
    mediumTapped = false;
    size = 'L';
    notifyListeners();
  }

  removeAllData() {
    cheeseValue = 0;
    onionValue = 0;
    ketchupValue = 0;
    smallTapped = false;
    mediumTapped = false;
    largeTapped = false;
    selected = false;
  }

  addToCart({required BuildContext context, required dynamic data}) async {
    if (smallTapped != false || mediumTapped != false || largeTapped != false) {
      cartData++;
      await Provider.of<FirebaseService>(context, listen: false)
          .addDataToCart(context: context, data: data);
      notifyListeners();
    } else {
      Fluttertoast.showToast(
        msg: "Please Select Pizza Size",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade500,
        textColor: Colors.white70,
        fontSize: 16.0,
      );
    }
  }
}
