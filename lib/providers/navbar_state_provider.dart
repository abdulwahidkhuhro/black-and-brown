import 'package:flutter/material.dart';

class NavbarStateProvider with ChangeNotifier {
  int _index = 1;

  void changeState(int index) {
    _index = index;
    notifyListeners();
  }

  int get getIndex {
    return _index;
  }
}
