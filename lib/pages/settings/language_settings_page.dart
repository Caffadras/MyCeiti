import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/locale_provider.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  final Map<String, String> _languagesMap = const {
    "en": "English",
    "ru": "Руссий",
    "ro": "Română"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.language),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: buildBody(context),
    );
  }



  /*Widget buildBody(BuildContext context) {
    // Fetching the current locale from LocaleProvider
    final locale = Provider.of<LocaleProvider>(context).locale;

    // Generating the list of DropdownMenuItems
    List<DropdownMenuItem<Locale>> dropdownItems = AppLocalizations.supportedLocales
        .map((Locale nextLocale) => DropdownMenuItem<Locale>(
      value: nextLocale,
      onTap: () {
        // Accessing the LocaleProvider and setting the new locale
        Provider.of<LocaleProvider>(context, listen: false).setLocale(nextLocale);
      },
      child: Text(nextLocale.toString()),
    ))
        .toList();

    // Using the generated list of DropdownMenuItems in the DropdownButton
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<Locale>(
            value: locale,
            icon: Container(width: 12),
            items: dropdownItems, // Use the list of dropdown items here
            onChanged: (Locale? newValue) {
              if (newValue != null) {
                Provider.of<LocaleProvider>(context, listen: false).setLocale(newValue);
              }
            },
          ),
        ),
      ],
    );
  }
*/

  Widget buildBody(BuildContext context) {
    Locale currLocale = Provider.of<LocaleProvider>(context).locale;
    return Column(
      children: AppLocalizations.supportedLocales
          .map(
            (nextLocale) => RadioListTile<String>(
                value: nextLocale.languageCode,
                title: Text(_languagesMap[nextLocale.languageCode]!),
                groupValue: currLocale.languageCode,
                onChanged: (String? value) {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(Locale(value!));
                }),
          )
          .toList(),
    );
  }

/*
  void _handleRadioValueChange(String? value) {
      _currentLanguageCode = value;
      // Update the app's locale
      Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale(value!));
    });
  }
*/
}
