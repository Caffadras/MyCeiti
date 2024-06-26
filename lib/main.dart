import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_ceiti/pages/home_page.dart';
import 'package:my_ceiti/providers/locale_provider.dart';
import 'package:my_ceiti/services/date_time_service.dart';
import 'package:my_ceiti/services/group_service.dart';
import 'package:my_ceiti/services/parser_service.dart';
import 'package:my_ceiti/services/schedule_service.dart';
import 'package:provider/provider.dart';
import 'package:theme_manager/theme_manager.dart';

final getIt = GetIt.instance;

void setup(){
  getIt.registerSingleton<ScheduleService>(ScheduleService());
  getIt.registerSingleton<GroupService>(GroupService());
  getIt.registerSingleton<DateTimeService>(DateTimeService());
  getIt.registerSingleton<ParserService>(ParserService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _getTheme(Brightness brightness){
    if (brightness == Brightness.light){
      return ThemeData.light(useMaterial3: true).copyWith(
        textTheme: GoogleFonts.robotoTextTheme()
      );
    } else {
      return ThemeData.dark();
    }
  }
  @override
  Widget build(BuildContext context) {
    return ThemeManager(
      defaultBrightnessPreference: BrightnessPreference.system,
      data: _getTheme,
/*      themeChangeListener: (ThemeState state) {
        debugPrint('ThemeState: ${state.brightnessPreference}');
      },*/
      themedBuilder: (BuildContext context, ThemeState theme) {
        return ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          builder: (context, child) {
            // Set system navigation bar color
            // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            //   systemNavigationBarColor: theme.themeData.colorScheme.surface, // Navigation bar color
            //   systemNavigationBarIconBrightness: Brightness.light, // Navigation bar icon brightness
            // ));

            final localeProvider = Provider.of<LocaleProvider>(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (context) =>
              AppLocalizations.of(context)!.appTitle,
              locale: localeProvider.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: theme.themeData,
              home: const HomePage(),
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