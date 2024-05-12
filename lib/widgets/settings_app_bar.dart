import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const SettingsAppBarWidget({super.key});

  @override
  State<SettingsAppBarWidget> createState() => _SettingsAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SettingsAppBarWidgetState extends State<SettingsAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(AppLocalizations.of(context)!.appBarSettings),

    );
  }
}
