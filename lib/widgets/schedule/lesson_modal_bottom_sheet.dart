import 'package:flutter/material.dart';

import '../../models/schedule/lesson_entry_model.dart';

class LessonModalBottomSheet extends StatelessWidget {
  final LessonEntryModel lesson;

  const LessonModalBottomSheet({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return _buildModalBottomSheet(context);
  }

  Widget _buildModalBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              // Text(lesson.both[0].subjectName, style: TextStyle(fontSize: 40),),
            ],
          ),
          Text(lesson.isOneGroupConstantSchedule().toString(),),
          Text(lesson.isTwoGroupConstantSchedule().toString(),),
          Text(lesson.isOneGroupFloatingSchedule().toString(),),
          Text(lesson.isTwoGroupFloatingSchedule().toString(),),
          Text(lesson.isOneWeekFloatingSchedule().toString(),),


        ],
      ),
    );
  }

  //  Widget _buildModalBottomSheet(BuildContext context) {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Text(lesson.both[0].teacherName),
  //         ElevatedButton(
  //           child: const Text('Close BottomSheet'),
  //           onPressed: () => Navigator.pop(context),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
