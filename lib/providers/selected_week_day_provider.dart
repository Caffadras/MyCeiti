import 'package:flutter/material.dart';

class SelectedWeekDayProvider extends ChangeNotifier {
  int _selectedDay = 0;

  int get selectedDay => _selectedDay;
  void updateSelectedDay(int newDay) {
    _selectedDay = newDay;
    notifyListeners();
  }
}
