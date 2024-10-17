import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;
  void setExpnaded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }
}
