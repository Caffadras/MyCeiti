import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/pages/content/grades_page.dart';
import 'package:my_ceiti/pages/content/shedule_page.dart';
import 'package:my_ceiti/pages/settings/settings_page.dart';
import 'package:my_ceiti/providers/selected_week_day_provider.dart';
import 'package:provider/provider.dart';

import 'about_app_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [const SchedulePage(), const GradesPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      bottomNavigationBar: NavigationBar(
        height: 75,
        backgroundColor: Theme.of(context).colorScheme.surface,
        onDestinationSelected: (idx) {
          _setSelectedPage(idx);
        },
        selectedIndex: _selectedPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.schedule),
            icon: Icon(Icons.schedule_outlined),
            label: 'Schedule',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.checklist),
            icon: Icon(Icons.checklist_outlined),
            label: 'Grades',
          ),
        ],
      ),
      onDrawerChanged: (isOpen) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
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
                        title: Center(
                            child: Image.asset(
                          'assets/images/ceiti.png',
                          height: 200,
                          width: 200,
                        )),
                      ),
                    ),
                  ),
                  ListTile(
                    trailing: Icon(Icons.access_time_rounded),
                    title: Text(AppLocalizations.of(context)!.schedulePage),
                    onTap: () {
                      _setSelectedPage(0);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    trailing: Icon(Icons.checklist),
                    title: Text(AppLocalizations.of(context)!.gradesPage),
                    onTap: () {
                      _setSelectedPage(1);
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
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
            ListTile(
              trailing: const Icon(Icons.info_outline),
              title: Text(AppLocalizations.of(context)!.aboutApp),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutTheAppPage()));
              },
            ),
          ],
        ),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => SelectedWeekDayProvider(),
        child: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: _selectedPageIndex == 0,
          transitionBuilder: _sharedAxisTransition,
          child: _pages[_selectedPageIndex],
        ),
      ),
    );
  }

  void _setSelectedPage(int idx) {
    setState(() {
      _selectedPageIndex = idx;
    });
  }

  Widget _sharedAxisTransition(Widget child, Animation<double> primaryAnimation,
      Animation<double> secondaryAnimation) {
    return SharedAxisTransition(
      animation: primaryAnimation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.horizontal,
      child: child,
    );
  }
}
