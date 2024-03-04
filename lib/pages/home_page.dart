import 'package:flutter/material.dart';
import 'package:my_ceiti/pages/settings/settings_page.dart';
import 'package:my_ceiti/themes/dark_theme.dart';
import 'package:my_ceiti/themes/light_theme.dart';
import 'package:my_ceiti/themes/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
        drawer:
        Drawer(
          child: Column(
            children: [
              Expanded(
                // This Expanded widget allows the ListView to take up all available space, except for the bottom items.
                child: ListView(
                  // Important: Do not use ListView.builder if your list contains a finite number of children.
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      child: DrawerHeader(
                        padding: EdgeInsets.zero,
                        child: ListTile(
                          title: Center(child: Image.asset('assets/images/ceiti.png', height: 200, width: 200,)),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.schedule),
                      onTap: () {
                        // Handle the tap
                      },
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.grades),
                      onTap: () {
                        // Handle the tap
                      },
                    ),
                    // Add more items here that you want above the settings
                  ],
                ),
              ),
              // This ListTile is aligned at the bottom of the drawer.
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(AppLocalizations.of(context)!.settings),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
            ],
          ),
        ),

        body: Center(
        // Your main screen content here
      ),
    );

    /*return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            Provider.of<ThemeManager>(context,listen: false).setTheme(lightTheme);
          }, child: const Text('Light Theme')),
          ElevatedButton(onPressed: (){
            Provider.of<ThemeManager>(context,listen: false).setTheme(darkTheme);
          }, child: const Text('Dark Theme')),
        ],
      ),
    );*/
  }
}
