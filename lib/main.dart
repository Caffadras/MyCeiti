import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/pages/home_page.dart';
import 'package:my_ceiti/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:theme_manager/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeManager(
      defaultBrightnessPreference: BrightnessPreference.system,
      data: (Brightness brightness) =>
          ThemeData(
            primarySwatch: Colors.blue,
            brightness: brightness,
          ),
/*      themeChangeListener: (ThemeState state) {
        debugPrint('ThemeState: ${state.brightnessPreference}');
      },*/
      themedBuilder: (BuildContext context, ThemeState theme) {
        return ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          builder: (context, child) {
            final localeProvider = Provider.of<LocaleProvider>(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (context) =>
              AppLocalizations.of(context)!.appTitle,
              locale: localeProvider.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: theme.themeData,
              home: HomePage(),
            );
          },
        );
      },
    );
  }
}
/*


return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state,
          home: HomePage(),
        );


 */