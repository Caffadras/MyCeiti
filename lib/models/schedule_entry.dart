import 'lesson.dart';

class ScheduleEntry {
  List<Lesson> par;
  List<Lesson> impar;
  List<Lesson> both;

  ScheduleEntry({required this.par, required this.impar, required this.both});

  factory ScheduleEntry.fromJson(Map<String, dynamic> json) {
    return ScheduleEntry(
      par: (json['par'] as List).map((i) => Lesson.fromJson(i)).toList(),
      impar: (json['impar'] as List).map((i) => Lesson.fromJson(i)).toList(),
      both: (json['both'] as List).map((i) => Lesson.fromJson(i)).toList(),
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
