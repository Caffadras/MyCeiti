import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ceiti/blocs/schedule/schedule_bloc.dart';
import 'package:my_ceiti/models/lesson.dart';
import 'package:my_ceiti/models/schedule_entry.dart';
import 'package:my_ceiti/providers/selected_week_day_provider.dart';
import 'package:provider/provider.dart';

import '../models/day_schedule_model.dart';

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
        var result = "";
        if (state is ScheduleInitial) {
          result = "ScheduleInitial   ";
        } else if (state is ScheduleLoading) {
          return const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ScheduleLoaded) {
          if (selectedDay < state.schedule.keys.length) {
            String dayKey = state.schedule.keys.elementAt(selectedDay);
            DaySchedule schedule = state.schedule[dayKey]!;

            return ListView.builder(
              itemCount: schedule.dayScheduleEntries.length,
              itemBuilder: (context, index) {
                ScheduleEntry lessonAt =
                    schedule.dayScheduleEntries.elementAt(index);
                return ListTile(
                  title: Text("Lesson $index"),
                  subtitle: Text(buildLessonEntry(lessonAt)),
                );
              },
            );
          }
        } else if (state is ScheduleError) {
          result = "ScheduleError   ";
        }
        return Text(result + selectedDay.toString());
      },
    );
  }

  String buildLessonEntry(ScheduleEntry entry) {
    if (entry.both.isNotEmpty) {
      Lesson lesson = entry.both[0];
      String result =
          "${lesson.subjectName} | ${lesson.classroom} | ${lesson.teacherName}";
      if (entry.both.length == 2) {
        lesson = entry.both[1];
        result =
            "$result\n${lesson.subjectName} | ${lesson.classroom} | ${lesson.teacherName}";
      }
      return result;
    }

    return "";
  }
}
