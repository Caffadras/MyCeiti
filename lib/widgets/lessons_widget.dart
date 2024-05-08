import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/schedule/day_schedule_model.dart';
import '../models/schedule/lesson_model.dart';
import '../models/schedule/schedule_entry_model.dart';
import 'label_tag_widget.dart';
import 'lesson_modal_bottom_sheet.dart';

class LessonsWidget extends StatelessWidget {
  // final String? dayOfTheWeek;
  final DayScheduleModel? scheduleModel;

  const LessonsWidget({
    super.key,
    // this.dayOfTheWeek,
    this.scheduleModel,
  });

  @override
  Widget build(BuildContext context) {
    if (/*dayOfTheWeek == null || */scheduleModel == null) {
      return _buildEmptyLessonsWidget(context);
    } else {
      return _buildLessonsWidgetForDay2(context);
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

  Widget _buildLessonsWidgetForDay2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: ListView.builder(
          itemCount: scheduleModel!.dayScheduleEntries.length,
          itemBuilder: (context, index) {
            DayScheduleEntryModel lessonAt =
                scheduleModel!.dayScheduleEntries.elementAt(index);
            return _buildCard(index, lessonAt, context);
          }),
    );
  }

  Widget _buildCard(
      int index, DayScheduleEntryModel lesson, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //todo hardcoded
      color: Colors.grey[100],
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          _buildModalBottomSheet(context, lesson);
        },
        child: IntrinsicHeight(
          child: Row(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
              child: _buildTimeslot(lesson, index),
            ),
            buildLessonContent(lesson),
          ]),
        ),
      ),
    );
  }

  Widget _buildTimeslot(DayScheduleEntryModel lesson, int index) {
    return Container(
              decoration: BoxDecoration(
                  color:
                      isEmptyEntry(lesson) ? Colors.grey : Color(0xff6ae792),
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Text(
                    '${index + 1}',
                    style: TextStyle(color: Colors.black, fontSize: 27),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "8:00",
                        style: TextStyle(fontSize: 13),
                      ),
                      Text("11:00",
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  )
                ],
              ),
            );
  }

  Future<dynamic> _buildModalBottomSheet(BuildContext context, DayScheduleEntryModel lesson) {
    return showModalBottomSheet(
      context: context,
      enableDrag: true,
      builder: (BuildContext context) {
        return LessonModalBottomSheet(lesson: lesson);
      },
    );
  }

/*  Container _buildLessonEntry2(int index, ScheduleEntryModel lesson) {
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
  }*/

  bool isEmptyEntry(DayScheduleEntryModel lesson) {
    return lesson.both.isEmpty && lesson.impar.isEmpty && lesson.par.isEmpty;
  }

  Widget buildLessonContent(DayScheduleEntryModel lesson) {
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          overflow: TextOverflow.ellipsis,
          lesson.subjectName,
          style: TextStyle(fontSize: 16),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LabelTag(
              label: _trimClassroomNumber(lesson.classroom),
            ),
            Text(lesson.teacherName),
          ],
        ),
      ],
    );
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

  Widget _buildConstantSchedule(DayScheduleEntryModel lesson) {
    return Expanded(
      child: Container(
        height: 70,
        // child: LabelTag(label: "123",),
        child: _buildConstantScheduleText(lesson.both.first),
      ),
    );
  }

  Widget _buildConstantDoubleSchedule(DayScheduleEntryModel lesson) {
    // return SizedBox(
    //   height: 20,
    // );
    return Expanded(
      child: Container(
        height: 70,
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

  Widget _buildFloatingSchedule(DayScheduleEntryModel lesson) {
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
    if (lessons.isEmpty) {
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

  String _trimClassroomNumber(String classroom){
    return classroom.substring(0, min(3, classroom.length));
  }
}
