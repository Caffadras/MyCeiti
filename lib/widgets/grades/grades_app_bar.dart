import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GradesAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const GradesAppBarWidget({super.key});

  @override
  State<GradesAppBarWidget> createState() => _GradesAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _GradesAppBarWidgetState extends State<GradesAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(AppLocalizations.of(context)!.appBarGrades),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
