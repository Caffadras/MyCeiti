import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/models/schedule/lesson_break_model.dart';
import 'package:my_ceiti/utils/lesson_breaks_utils.dart';

import '../models/schedule/day_schedule_model.dart';
import '../models/schedule/lesson_entry_model.dart';
import '../models/schedule/lesson_info.dart';
import 'label_tag_widget.dart';
import 'lesson_modal_bottom_sheet.dart';

class LessonsWidget extends StatelessWidget {
  final DayScheduleModel? scheduleModel;
  final List<LessonBreakModel>? breaksModel;

  const LessonsWidget({
    super.key,
    this.scheduleModel,
    this.breaksModel,
  });

  @override
  Widget build(BuildContext context) {
    if (scheduleModel == null) {
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
          itemCount: scheduleModel!.lessonEntries.length,
          itemBuilder: (context, index) {
            LessonEntryModel lessonAt =
                scheduleModel!.lessonEntries.elementAt(index);
            return _buildCard(index, lessonAt, context);
          }),
    );
  }

  Widget _buildCard(
      int index, LessonEntryModel lesson, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //todo hardcoded
      color: Colors.grey[100],
      child: _buildCardWithInkWell(lesson, context, index),
    );
  }

  Widget _buildCardWithInkWell(LessonEntryModel lesson, BuildContext context, int index) {
    void Function()? onTapFunction;
    if (!isEmptyLessonEntry(lesson)) {
      onTapFunction = () => _buildModalBottomSheet(context, lesson);
    }

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTapFunction,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
              child: _buildTimeslot(lesson, index),
            ),
            buildLessonContent(lesson),
          ],
        ),
      ),
    );
  }


  Widget _buildTimeslot(LessonEntryModel lesson, int index) {
    bool isLessonEmpty = isEmptyLessonEntry(lesson);
    return Container(
      width: 67,
      decoration: BoxDecoration(
        color: isLessonEmpty ? Colors.grey.shade300 : Color(0xff6ae792),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Opacity(
        opacity: isLessonEmpty ? 0.5 : 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '${index + 1}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 27,
                fontWeight: isLessonEmpty ? FontWeight.w300 : FontWeight.normal,
              ),
            ),
            SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getBreakStartTime(index),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                Text(
                  _getBreakEndTime(index),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


  String _getBreakStartTime(int lessonIdx) {
    if (breaksModel != null && lessonIdx < breaksModel!.length){
      return breaksModel![lessonIdx].start;
    } else {
      return LessonBreaksUtil.getDefaultStartTime(lessonIdx);
    }
  }

  String _getBreakEndTime(int lessonIdx) {
    if (breaksModel != null && lessonIdx < breaksModel!.length){
      return breaksModel![lessonIdx].end;
    } else {
      return LessonBreaksUtil.getDefaultEndTime(lessonIdx);
    }
  }


  Future<dynamic> _buildModalBottomSheet(BuildContext context, LessonEntryModel lesson) {
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

  bool isEmptyLessonEntry(LessonEntryModel lesson) {
    return lesson.both.isEmpty && lesson.impar.isEmpty && lesson.par.isEmpty;
  }

  Widget buildLessonContent(LessonEntryModel lesson) {
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

  Widget _buildConstantScheduleText(LessonInfoModel lesson) {
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

  Widget _buildConstantSchedule(LessonEntryModel lesson) {
    return Expanded(
      child: Container(
        height: 70,
        // child: LabelTag(label: "123",),
        child: _buildConstantScheduleText(lesson.both.first),
      ),
    );
  }

  Widget _buildConstantDoubleSchedule(LessonEntryModel lesson) {
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

  Widget _buildFloatingSchedule(LessonEntryModel lesson) {
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

  Widget _buildFloatingScheduleText(List<LessonInfoModel> lessons, bool isOdd) {
    if (lessons.isEmpty) {
      return const Text("-");
    }
    LessonInfoModel lesson = lessons[0];
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
