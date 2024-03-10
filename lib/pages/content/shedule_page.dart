import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/blocs/schedule/schedule_bloc.dart';
import 'package:my_ceiti/models/group_model.dart';
import 'package:provider/provider.dart';

import '../../providers/selected_week_day_provider.dart';
import '../../widgets/group_selection_widget.dart';
import '../../widgets/schedule_widget.dart';
import '../../widgets/week_day_selection_widget.dart';

/*
{
        "_id": "65e9fae66fff9d77b67fb542",
        "id": "D612397E79E6DD3A",
        "name": "P-2043R",
        "diriginte": {
            "name": "Carp A."
        }
    },
 */
class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.schedulePage),
        ),
        body: ChangeNotifierProvider(
          create: (context) => SelectedWeekDayProvider(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GroupSelection(
                  onSelect: _onGroupSelect,
                ),
                Expanded(child: ScheduleWidget()),
                WeekDaySelectionWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onGroupSelect(GroupModel? model) {
    print("### CALLBACK GROP SELECTION");

    // var schedule = _scheduleService!.getSchedule();
  }
}
