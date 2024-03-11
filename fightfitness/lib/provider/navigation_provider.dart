import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _index = 0;

  int get currentPage => _index;

  changePage(int index) {
    _index = index;
    notifyListeners();
  }

  mainPage() {
    _index = 0;
    notifyListeners();
  }
}
