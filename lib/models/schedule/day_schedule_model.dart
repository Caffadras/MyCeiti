import 'package:my_ceiti/models/schedule/lesson_entry_model.dart';

class DayScheduleModel {
  List<LessonEntryModel> lessonEntries;

  DayScheduleModel({required this.lessonEntries});

  factory DayScheduleModel.fromJson(Map<String, dynamic> json) {
    List<LessonEntryModel> entries = [];
    json.forEach((key, value) {
      //todo check if there should not be more than 5 lessons
      if (value is Map<String, dynamic> && int.parse(key) < 6) {
        entries.add(LessonEntryModel.fromJson(value));
      }
    });
    return DayScheduleModel(lessonEntries: entries);
  }

  @override
  String toString() {
    return 'DaySchedule{dayScheduleEntries: $lessonEntries}';
  }
}
