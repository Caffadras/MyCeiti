import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/selected_week_day_provider.dart';

enum WeekDays { monday, tuesday, wednesday, thursday, friday }

class WeekDaySelectionWidget extends StatefulWidget {
  const WeekDaySelectionWidget({super.key});

  @override
  State<WeekDaySelectionWidget> createState() => _WeekDaySelectionWidgetState();
}

class _WeekDaySelectionWidgetState extends State<WeekDaySelectionWidget> {
  WeekDays selectedDay = WeekDays.monday;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SelectedWeekDayProvider>(context);
    selectedDay = WeekDays.values[provider.selectedDay];

    return SegmentedButton<WeekDays>(
      style: ButtonStyle(
        visualDensity: VisualDensity(horizontal: 3),
      ),
      showSelectedIcon: false,
      segments: <ButtonSegment<WeekDays>>[
        ButtonSegment<WeekDays>(
            value: WeekDays.monday,
            label: Text(AppLocalizations.of(context)!.mondayShort)),
        ButtonSegment<WeekDays>(
            value: WeekDays.tuesday,
            label: Text(AppLocalizations.of(context)!.tuesdayShort)),
        ButtonSegment<WeekDays>(
            value: WeekDays.wednesday,
            label: Text(AppLocalizations.of(context)!.wednesdayShort)),
        ButtonSegment<WeekDays>(
            value: WeekDays.thursday,
            label: Text(AppLocalizations.of(context)!.thursdayShort)),
        ButtonSegment<WeekDays>(
            value: WeekDays.friday,
            label: Text(AppLocalizations.of(context)!.fridayShort)),
      ],
      selected: <WeekDays>{selectedDay},
      onSelectionChanged: (Set<WeekDays> newSelection) {
        setState(() {
          selectedDay = newSelection.first;
          provider.updateSelectedDay(WeekDays.values.indexOf(newSelection.first));
        });
      },
    );
  }
}
