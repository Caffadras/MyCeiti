import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/models/day_schedule_model.dart';

import '../models/lesson_model.dart';
import '../models/schedule_entry_model.dart';
import 'label_tag_widget.dart';

class LessonsWidget extends StatelessWidget {
  final String? dayOfTheWeek;
  final DayScheduleModel? scheduleModel;

  const LessonsWidget({
    super.key,
    this.dayOfTheWeek,
    this.scheduleModel,
  });

  @override
  Widget build(BuildContext context) {
    if (dayOfTheWeek == null || scheduleModel == null) {
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
            ScheduleEntryModel lessonAt =
                scheduleModel!.dayScheduleEntries.elementAt(index);
            return _NEWbuildLessonEntry2(index, lessonAt, context);
          }),
    );
    // }
  }

/*  Widget _buildLessonsWidgetForDay(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15)),
        child: ListView.separated(
          itemCount: scheduleModel!.dayScheduleEntries.length,
          itemBuilder: (context, index) {
            ScheduleEntryModel lessonAt =
                scheduleModel!.dayScheduleEntries.elementAt(index);
            return _buildLessonEntry2(index, lessonAt);
          },
          separatorBuilder: (context, index) => Divider(),
        ),
      ),
    );
    // }
  }*/
  Widget _NEWbuildLessonEntry2(
      int index, ScheduleEntryModel lesson, BuildContext context) {
    return Card(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //todo hardcoded
      color: Colors.grey[100],
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          _buildModalBottomSheet(context);
        },
        child: IntrinsicHeight(
          child: Row(children: [

            Padding(
              padding: EdgeInsets.all(7),
              child: Container(
                decoration: BoxDecoration(
                    color:
                        isEmptyEntry(lesson) ? Colors.grey : Color(0xff6ae792),
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  children: [
                    Text(
                      '${index + 1}',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("8:00"), Text("11:00")],
                    )
                  ],
                ),
              ),
            ),
            buildLessonContent(lesson),
          ]),
        ),
      ),
    );
  }

  Future<dynamic> _buildModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Modal BottomSheet'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          overflow: TextOverflow.ellipsis,
          lesson.subjectName,
          style: TextStyle(
            fontSize: 18
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LabelTag(label: lesson.classroom,),
            Text(
                lesson.teacherName),
          ],
        ),
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
        height: 80,
        // child: LabelTag(label: "123",),
        child: _buildConstantScheduleText(lesson.both.first),
      ),
    );
  }

  Widget _buildConstantDoubleSchedule(ScheduleEntryModel lesson) {
    // return SizedBox(
    //   height: 20,
    // );
    return Expanded(
      child: Container(
        height: 80,
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
}
