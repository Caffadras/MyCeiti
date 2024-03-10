import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale("en");
  Locale get locale => _locale;
  static const _localePreferenceKey = "locale_language_code";

  LocaleProvider() {
    loadLocale();
  }

  Future<void> loadLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? persistedLocale = sharedPreferences.getString(_localePreferenceKey);
    if (persistedLocale != null){
      _locale = Locale(persistedLocale);
      // notifyListeners();
    }
  }

  void setLocale(Locale newLocale) async {
    if (AppLocalizations.supportedLocales.contains(newLocale)) {
      _locale = newLocale;
      notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localePreferenceKey, newLocale.languageCode);
    }
  }
}
