import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enums/grades_tab_enum.dart';

class GradesTabSelectionWidget extends StatefulWidget {
  const GradesTabSelectionWidget({super.key});

  @override
  State<GradesTabSelectionWidget> createState() => _GradesTabSelectionWidgetState();
}

class _GradesTabSelectionWidgetState extends State<GradesTabSelectionWidget> {
  GradeTabs selectedPage = GradeTabs.semester;

  @override
  Widget build(BuildContext context) {
    return _buildSegmentedButton();
  }

  Widget _buildSegmentedButton(){
    return SegmentedButton<GradeTabs>(
      style: ButtonStyle(
        visualDensity: VisualDensity(horizontal: 3, vertical: -1),
      ),
      showSelectedIcon: false,
      segments: <ButtonSegment<GradeTabs>>[
        ButtonSegment<GradeTabs>(
            value: GradeTabs.semester,
            label: Text(AppLocalizations.of(context)!.semesterGradesTab)),
        ButtonSegment<GradeTabs>(
            value: GradeTabs.exam,
            label: Text(AppLocalizations.of(context)!.examGradesTab)),
        ButtonSegment<GradeTabs>(
            value: GradeTabs.year,
            label: Text(AppLocalizations.of(context)!.yearGradesTab)),
      ],
      selected: <GradeTabs>{selectedPage},
      onSelectionChanged: (Set<GradeTabs> newSelection) {
        setState(() {
          selectedPage = newSelection.first;
          //provider.updateSelectedDay(GradesTabSections.values.indexOf(newSelection.first));
        });
      },
    );
  }

}
