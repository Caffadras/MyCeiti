import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/dark_theme.dart';
import '../themes/light_theme.dart';

ThemeData getThemeDataFromString(String themePreference) {
  switch(themePreference){
    case "light" :
      return lightTheme;
    case "dark" :
      return darkTheme;
    default:
      return PlatformDispatcher.instance.platformBrightness == Brightness.dark ? darkTheme : lightTheme;
  }
}

String getThemeStringName(ThemeData themeData){
  if (themeData == lightTheme){
    return "light";
  } else if (themeData == darkTheme){
    return "dark";
  } else {
    return "system";
  }
}

Future<String> currentTheme() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('themeMode') ?? 'system';
}