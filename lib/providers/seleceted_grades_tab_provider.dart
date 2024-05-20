import 'package:flutter/material.dart';
import 'package:my_ceiti/enums/grades_tab_enum.dart';

class SelectedGradesTabProvider extends ChangeNotifier {
  GradeTabs _selectedTab = GradeTabs.semester;

  GradeTabs get selectedTab => _selectedTab;
  void updateSelectedTab(GradeTabs newTab) {
    _selectedTab = newTab;
    notifyListeners();
  }
}
