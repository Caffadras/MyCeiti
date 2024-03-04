import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:theme_manager/enums.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../blocs/theme/theme_bloc.dart';
import '../../utils/theme_utils.dart';

class AppearanceSettingsPage extends StatelessWidget {
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appearance),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          children: [
            ListTile(title: Text(AppLocalizations.of(context)!.themeMode)),
            RadioListTile<String>(
              title: Text(AppLocalizations.of(context)!.lightTheme),
              value: 'light',
              groupValue:
                  ThemeManager.of(context).state.brightnessPreference.name,
              onChanged: (value) {
                ThemeManager.of(context)
                    .setBrightness(BrightnessPreference.light);
                //context.read<ThemeBloc>().add(UpdateTheme(themePreference: value!));
              },
            ),
            RadioListTile<String>(
              title: Text(AppLocalizations.of(context)!.darkTheme),
              value: 'dark',
              groupValue:
                  ThemeManager.of(context).state.brightnessPreference.name,
              onChanged: (value) {
                ThemeManager.of(context)
                    .setBrightness(BrightnessPreference.dark);
              },
            ),
            RadioListTile<String>(
              title: Text(AppLocalizations.of(context)!.systemTheme),
              value: 'system',
              groupValue:
                  ThemeManager.of(context).state.brightnessPreference.name,
              onChanged: (value) {
                ThemeManager.of(context)
                    .setBrightness(BrightnessPreference.system);
              },
            ),
          ],
        ));
  }
}
