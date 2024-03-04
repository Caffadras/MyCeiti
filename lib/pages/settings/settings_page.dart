import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/pages/settings/appearance_settings_page.dart';
import 'package:my_ceiti/pages/settings/language_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.appearance),
            trailing: Icon(Icons.sunny),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AppearanceSettingsPage()));
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.language),
            trailing: Icon(Icons.language),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageSettingsPage()));
            },
          ),
        ],
      ),
    );
  }
}
