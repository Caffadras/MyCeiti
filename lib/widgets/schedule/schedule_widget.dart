import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/blocs/group/group_bloc.dart';
import 'package:my_ceiti/blocs/schedule/schedule_bloc.dart';
import 'package:my_ceiti/models/schedule/lesson_break_model.dart';
import 'package:my_ceiti/providers/selected_week_day_provider.dart';
import 'package:provider/provider.dart';

import '../../models/schedule/day_schedule_model.dart';
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
    return BlocListener<GroupBloc, GroupState>(
      listener: (context, state){
        if (state is GroupSelectedState) {
          context.read<ScheduleBloc>().add(FetchSchedule(group: state.selectedGroup));
        }
      },
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
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
            return Text(AppLocalizations.of(context)!.errorOccurred);
          }
        },
      ),
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
    // if (_scheduleService.selectedSchedule != null) {
    //   return LessonsWidget(
    //     scheduleModel: _scheduleService.selectedSchedule!.weekScheduleMap[selectedDay],
    //   );
    // } else {
      return const LessonsWidget();
    // }
  }

  Widget _buildActualSchedule(ScheduleLoaded state, int selectedDay) {
    DayScheduleModel schedule = state.schedule.weekScheduleMap[selectedDay]!;
    List<LessonBreakModel> breaksModel = state.schedule.lessonBreakModels;
    return LessonsWidget(
      scheduleModel: schedule,
      breaksModel: breaksModel,
    );
  }
}

