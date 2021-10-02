import 'package:flutter/material.dart';

class ObscureTextState with ChangeNotifier {
  bool _isTrue = true;
  bool get isTrue => _isTrue;

  get switchObsIcon {
    return _isTrue ? Icon(Icons.visibility_off) : Icon(Icons.visibility);
  }

  void toggleObs() {
    _isTrue = !_isTrue;
    notifyListeners();
  }
}
