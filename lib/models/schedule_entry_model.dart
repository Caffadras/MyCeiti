import 'lesson_model.dart';

class ScheduleEntryModel {
  List<LessonModel> par;
  List<LessonModel> impar;
  List<LessonModel> both;

  ScheduleEntryModel({required this.par, required this.impar, required this.both});

  factory ScheduleEntryModel.fromJson(Map<String, dynamic> json) {
    return ScheduleEntryModel(
      par: (json['par'] as List).map((i) => LessonModel.fromJson(i)).toList(),
      impar: (json['impar'] as List).map((i) => LessonModel.fromJson(i)).toList(),
      both: (json['both'] as List).map((i) => LessonModel.fromJson(i)).toList(),
    );
  }

  @override
  String toString() {
    return 'ScheduleEntry{par: $par, impar: $impar, both: $both}';
  }
}

/*
* class ScheduleEntry {
  Lesson lesson;

  ScheduleEntry({required this.lesson});

  factory ScheduleEntry.fromJson(Map<String, dynamic> json) {
    return ScheduleEntry(
      lesson: Lesson.fromJson(json),
    );
  }

  @override
  String toString() {
    return 'ScheduleEntry{lesson: $lesson}';
  }
}
**/
