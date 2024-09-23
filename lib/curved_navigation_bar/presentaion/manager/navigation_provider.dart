import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  void setCurrentPageIndex(int index) {
    print("Current Page Index set to: $index"); // Debug print
    _currentPageIndex = index;
    notifyListeners();
  }
}
