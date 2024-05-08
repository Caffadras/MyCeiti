import 'lesson_model.dart';

class DayScheduleEntryModel {
  List<LessonModel> par;
  List<LessonModel> impar;
  List<LessonModel> both;

  DayScheduleEntryModel({required this.par, required this.impar, required this.both});

  factory DayScheduleEntryModel.fromJson(Map<String, dynamic> json) {
    return DayScheduleEntryModel(
      par: (json['par'] as List).map((i) => LessonModel.fromJson(i)).toList(),
      impar: (json['impar'] as List).map((i) => LessonModel.fromJson(i)).toList(),
      both: (json['both'] as List).map((i) => LessonModel.fromJson(i)).toList(),
    );
  }

  bool isOneGroupConstantSchedule(){
    return both.length == 1;
  }

  bool isTwoGroupConstantSchedule(){
    return both.length == 2;
  }

  bool isOneGroupFloatingSchedule(){
    return par.length == 1 && impar.length == 1;
  }

  bool isTwoGroupFloatingSchedule(){
    return par.length == 2 && impar.length == 2;
  }

  bool isOneWeekFloatingSchedule(){
    return par.length == 1 && impar.isEmpty
    || par.isEmpty && impar.length == 1;
  }

  @override
  String toString() {
    return 'DayScheduleEntry{par: $par, impar: $impar, both: $both}';
  }
}
