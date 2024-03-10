import 'package:flutter/material.dart';
import 'package:my_ceiti/pages/content/grades_page.dart';
import 'package:my_ceiti/pages/content/shedule_page.dart';
import 'package:my_ceiti/pages/settings/settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        drawer: Drawer(
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
                      title: Text(AppLocalizations.of(context)!.schedulePage),
                      onTap: () {
                        setState(() {
                          _selectedWidgetIndex = 0;
                        });
                        Navigator.pop(context); // Close the drawer
                        // Handle the tap
                      },
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.gradesPage),
                      onTap: () {
                        setState(() {
                          _selectedWidgetIndex = 1;
                        });
                        Navigator.pop(context); // Close the drawer
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

        body: IndexedStack(
          index: _selectedWidgetIndex,
          children: _pages,
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
