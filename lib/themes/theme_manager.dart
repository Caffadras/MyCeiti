import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_ceiti/themes/dark_theme.dart';
import 'package:my_ceiti/themes/light_theme.dart';

class ThemeManager with ChangeNotifier, WidgetsBindingObserver {
  ThemeData? _themeData;
  String _themePreference = 'system';

  ThemeManager() {
    WidgetsBinding.instance.addObserver(this);
    _loadThemeFromPreferences();
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void c() {
    if (_themePreference == 'system') {
      _updateThemeBasedOnSystem();
    }
  }

  Future<void> _updateThemeBasedOnSystem() async {
    Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
    setTheme(brightness == Brightness.dark ? darkTheme : lightTheme, notify: false);
  }

  ThemeData getTheme() => _themeData!;
  ThemeData getOrLoadTheme() {
   if (_themeData == null){
     _loadThemeFromPreferences();
   }
   return _themeData!;
  }

  String get themePreference => _themePreference;

  Future<void> setThemePreference(String preference) async {
    _themePreference = preference;
    await _persistThemePreference(preference);
    if (preference == 'system') {
      _updateThemeBasedOnSystem();
    } else {
      await _loadThemeFromPreferences();
    }
    notifyListeners();
  }

  Future<void> _persistThemePreference(String preference) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('themeMode', preference);
  }

  Future<void> _loadThemeFromPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String themeMode = prefs.getString('themeMode') ?? 'system';
      _themePreference = themeMode;
      if (themeMode == 'dark') {
        _themeData = darkTheme;
      } else if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _updateThemeBasedOnSystem();
      }
    } catch (error) {
      print('Error loading theme: $error');
    }
  }


  void setTheme(ThemeData themeData, {bool notify = true}) {
    _themeData = themeData;
    if (notify) notifyListeners();
  }
}
