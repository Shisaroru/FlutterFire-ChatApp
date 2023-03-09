import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int _route = 0;

  int get route => _route;

  void changeRoute(int route) {
    _route = route;
    notifyListeners();
  }
}
