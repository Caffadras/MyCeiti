import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/pages/content/grades_page.dart';
import 'package:my_ceiti/pages/content/shedule_page.dart';
import 'package:my_ceiti/pages/settings/settings_page.dart';

import 'about_app_page.dart';


class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedWidgetIndex = 0;

  final List<Widget>_pages = [
    SchedulePage(),
    GradesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
        onDrawerChanged: (isOpen){FocusManager.instance.primaryFocus?.unfocus();},
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
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
                      trailing: Icon(Icons.access_time_rounded),
                      title: Text(AppLocalizations.of(context)!.schedulePage),
                      onTap: () {
                        setState(() {
                          _selectedWidgetIndex = 0;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      trailing: Icon(Icons.checklist),
                      title: Text(AppLocalizations.of(context)!.gradesPage),
                      onTap: () {
                        setState(() {
                          _selectedWidgetIndex = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                trailing: Icon(Icons.settings),
                title: Text(AppLocalizations.of(context)!.settings),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
              ListTile(
                trailing: const Icon(Icons.info_outline),
                title: Text(AppLocalizations.of(context)!.aboutApp),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutTheAppPage()));
                },
              ),
            ],
          ),
        ),

        body: IndexedStack(
          index: _selectedWidgetIndex,
          children: _pages,
      ),
    );

  }
}
