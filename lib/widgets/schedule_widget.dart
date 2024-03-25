import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/blocs/schedule/schedule_bloc.dart';
import 'package:my_ceiti/providers/selected_week_day_provider.dart';
import 'package:provider/provider.dart';

import '../models/day_schedule_model.dart';
import 'lessons_widget.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    int selectedDay = Provider.of<SelectedWeekDayProvider>(context).selectedDay;
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (BuildContext context, state) {
        if (state is ScheduleInitial) {
          return _buildInitialScheduleWidget();
        } else if (state is ScheduleLoading) {
          return _buildLoadingIndicator();
        } else if (state is ScheduleLoaded) {
          return _buildActualSchedule(state, selectedDay);
        } else if (state is ScheduleTimeout) {
          return Text(AppLocalizations.of(context)!.scheduleNetworkTimeout);
        } else if (state is ScheduleError) {
          return Text(AppLocalizations.of(context)!.scheduleNetworkError);
        } else {
          return Text(selectedDay.toString());
        }
      },
    );
  }

  Center _buildLoadingIndicator() {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildInitialScheduleWidget() {
    /* return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Container(
            decoration: BoxDecoration(color: Colors.cyan),
            child: CircularProgressIndicator()),
      ),
    );*/
/*    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: Colors.amber),
        child: Text("Please, select group"),
      ),
    );*/

    return LessonsWidget();
  }

  Widget _buildActualSchedule(ScheduleLoaded state, int selectedDay) {
    // if (selectedDay < state.schedule.keys.length) {
    String dayKey = state.schedule.keys.elementAt(selectedDay);
    DayScheduleModel schedule = state.schedule[dayKey]!;
    return LessonsWidget(
      dayOfTheWeek: dayKey,
      daySchedule: schedule,
    );

  }


}
