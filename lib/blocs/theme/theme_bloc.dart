import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';
import 'package:my_ceiti/themes/dark_theme.dart';
import 'package:my_ceiti/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/theme_utils.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(ThemeData()) {
    on<InitialThemeSetEvent>((event, emit) async{
      ThemeData initialTheme = await _loadTheme();
      emit(initialTheme);
    });

    on<LoadTheme>(_loadThemeAndEmit);
    on<UpdateTheme>(_updateTheme);
  }

  Future<ThemeData> _loadTheme() async {
    print('loadTheme');
    SharedPreferences pref = await SharedPreferences.getInstance();
    String themePreference = pref.getString('themeMode') ?? 'system';
    return getThemeDataFromString(themePreference);
  }

  Future<void> _loadThemeAndEmit(LoadTheme event, Emitter<ThemeData> emit) async {
    ThemeData loadedTheme = await _loadTheme();
    emit(loadedTheme);
  }

  Future<void> _updateTheme(UpdateTheme event, Emitter  <ThemeData> emit) async {
    print('theme updated');
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('themeMode', event.themePreference);
    ThemeData themeData = await getThemeDataFromString(event.themePreference);
    emit(themeData);
  }


}
