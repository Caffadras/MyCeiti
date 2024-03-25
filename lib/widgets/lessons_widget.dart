import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/models/day_schedule_model.dart';

import '../models/lesson_model.dart';
import '../models/schedule_entry_model.dart';

class LessonsWidget extends StatelessWidget {
  final String? dayOfTheWeek;
  final DayScheduleModel? daySchedule;

  const LessonsWidget({
    super.key,
    this.dayOfTheWeek,
    this.daySchedule,
  });

  @override
  Widget build(BuildContext context) {
    if (dayOfTheWeek == null || daySchedule == null) {
      return _buildEmptyLessonsWidget(context);
    } else {
      return _buildLessonsWidgetForDay(context);
    }
  }

  Widget _buildEmptyLessonsWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          AppLocalizations.of(context)!.selectGroupToSeeSchedule,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildLessonsWidgetForDay(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15)),
        child: ListView.separated(
          itemCount: daySchedule!.dayScheduleEntries.length,
          itemBuilder: (context, index) {
            ScheduleEntryModel lessonAt =
                daySchedule!.dayScheduleEntries.elementAt(index);
            return _buildLessonEntry2(index, lessonAt);
          },
          separatorBuilder: (context, index) => Divider(),
        ),
      ),
    );
    // }
  }

  Container _buildLessonEntry2(int index, ScheduleEntryModel lesson) {
    return Container(
        padding: const EdgeInsets.all(1.0),
        child: IntrinsicHeight(
          child: Row(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7),
              // decoration: BoxDecoration(color: Colors.yellow),
              child: CircleAvatar(
                backgroundColor:
                    isEmptyEntry(lesson) ? Colors.grey : Color(0xff6ae792),
                child: Text(
                  '$index',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            buildLessonContent(lesson),
          ]),
        ));
  }

  bool isEmptyEntry(ScheduleEntryModel lesson) {
    return lesson.both.isEmpty && lesson.impar.isEmpty && lesson.par.isEmpty;
  }

  Widget buildLessonContent(ScheduleEntryModel lesson) {
    if (lesson.both.isNotEmpty) {
      if (lesson.both.length == 1) {
        return _buildConstantSchedule(lesson);
      } else {
        return _buildConstantDoubleSchedule(lesson);
      }
    } else if (lesson.par.isNotEmpty || lesson.impar.isNotEmpty) {
      return _buildFloatingSchedule(lesson);
    } else {
      return _buildEmptySchedule();
    }
  }

  Widget _buildConstantScheduleText(LessonModel lesson) {
    return Column(
      children: [
        Text(lesson.subjectName),
        Text(lesson.classroom),
        Text(lesson.teacherName),
      ],
    );
  }

  String _buildConstantScheduleTextOld(ScheduleEntryModel entry) {
    LessonModel lesson = entry.both[0];
    String result =
        "${lesson.subjectName} | ${lesson.classroom} | ${lesson.teacherName}";
    if (entry.both.length == 2) {
      lesson = entry.both[1];
      result =
          "$result\n${lesson.subjectName} | ${lesson.classroom} | ${lesson.teacherName}";
    }
    return result;
  }

  Widget _buildEmptySchedule() {
    return Expanded(
      child: Container(
          height: 65,
          alignment: Alignment.centerLeft,
          // decoration: BoxDecoration(color: Colors.yellow),
          child: Text(
            "-",
            textAlign: TextAlign.center,
          )),
    );
  }

  Widget _buildConstantSchedule(ScheduleEntryModel lesson) {
    return Expanded(
      child: Container(
          height: 65,
          alignment: Alignment.center,
          // decoration: BoxDecoration(color: Colors.yellow),
          child: Text(
            _buildConstantScheduleTextOld(lesson),
          )),
    );
  }

  Widget _buildConstantDoubleSchedule(ScheduleEntryModel lesson) {
    return Expanded(
      child: Container(
        height: 65,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildConstantScheduleText(lesson.both[0]),
            VerticalDivider(),
            _buildConstantScheduleText(lesson.both[1]),
          ],
        ),
      ),
    );
  }


  Widget _buildFloatingSchedule(ScheduleEntryModel lesson) {
    return Expanded(
      child: Container(
        height: 65,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFloatingScheduleText(lesson.par, true),
            const VerticalDivider(),
            _buildFloatingScheduleText(lesson.par, false),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingScheduleText(List<LessonModel> lessons, bool isOdd) {
    if (lessons.isEmpty){
      return const Text("-");
    }
    LessonModel lesson = lessons[0];
    return Column(
      children: [
        Row(
          children: [
            Text(lesson.subjectName),
            Text(
              isOdd ? " impar" : " par",
              style: TextStyle(color: isOdd ? Colors.red : Colors.blue),
            ),
          ],
        ),
        Text(lesson.classroom),
        Text(lesson.teacherName),
      ],
    );
  }
}
