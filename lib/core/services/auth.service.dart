import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier with ChangeNotifier {
  String? userUid;
  String? errorMessage;
  String? get getErrorMessage => errorMessage;
  String? get getUserUid => userUid;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> logIntoAccount({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      userUid = user!.uid;
      print(userUid);

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message.toString();
      return false;
    } catch (e) {
      print(e);
      errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> signUpAccount({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      userUid = user!.uid;
      print(userUid);

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message.toString();
      return false;
    } catch (e) {
      print(e);
      errorMessage = e.toString();
      return false;
    }
  }
}
