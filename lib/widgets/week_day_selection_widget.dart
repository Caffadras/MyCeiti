import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/selected_week_day_provider.dart';

class WeekDaySelectionWidget extends StatefulWidget {
  const WeekDaySelectionWidget({super.key});

  @override
  State<WeekDaySelectionWidget> createState() => _WeekDaySelectionWidgetState();
}

class _WeekDaySelectionWidgetState extends State<WeekDaySelectionWidget> {
  int _selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    _selectedDayIndex = Provider.of<SelectedWeekDayProvider>(context).selectedDay;
    List<String> localizedDays = [
      AppLocalizations.of(context)!.mondayShort,
      AppLocalizations.of(context)!.tuesdayShort,
      AppLocalizations.of(context)!.wednesdayShort,
      AppLocalizations.of(context)!.thursdayShort,
      AppLocalizations.of(context)!.fridayShort,
    ];

    Color foregroundColor = Theme.of(context).colorScheme.onPrimary; // Text color
    Color selectedBackgroundColor = Theme.of(context).colorScheme.primary; // Button background color
    Color backgroundColor = Theme.of(context).colorScheme.secondary; // Selected button background color


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedDayIndex == index ? selectedBackgroundColor : backgroundColor,
            // foregroundColor: foregroundColor, // This sets the text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            Provider.of<SelectedWeekDayProvider>(context, listen: false).updateSelectedDay(index);
          },
          child: Text(
            localizedDays[index],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }),
    );
  }
}
