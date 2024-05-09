import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutTheAppPage extends StatelessWidget {
  const AboutTheAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutApp),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('My CEITI V1.0')),
          Center(child: ElevatedButton(
            onPressed: _clearPrefs,
            child:
            Text('Clear Prefs'),
          ),),
        ],
      ),
    );
  }

  Future<void> _clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("cleared prefs");
  }
}
