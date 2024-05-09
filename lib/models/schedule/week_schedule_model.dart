import 'package:my_ceiti/models/schedule/day_schedule_model.dart';

import '../../utils/week_days_utils.dart';
import 'lesson_break_model.dart';

class WeekScheduleModel {
  //todo should contain group model?
  final Map<String, dynamic> _originalJson;
  final Map<int, DayScheduleModel> weekScheduleMap;
  final List<LessonBreakModel> lessonBreakModels;

  WeekScheduleModel(this._originalJson, {required this.weekScheduleMap, required this.lessonBreakModels});

  factory WeekScheduleModel.fromJson(Map<String, dynamic> json) {
    final lessonData = json['data'];
    final breaksData = json['periods'];

    Map<int, DayScheduleModel> weekSchedule = {};

    lessonData.forEach((day, scheduleJson) {
      int weekDay = WeekdayUtil.dayToNumber(day);
      weekSchedule[weekDay] = DayScheduleModel.fromJson(scheduleJson);
    });

    List<LessonBreakModel> breaksModel = [];

    breaksData.forEach((period){
      LessonBreakModel lessonBreakModel = LessonBreakModel.fromJson(period);
      breaksModel.add(lessonBreakModel);
    });

    return WeekScheduleModel(json, lessonBreakModels: breaksModel, weekScheduleMap: weekSchedule);
  }

  Map<String, dynamic> toJson(){
    return _originalJson;
  }

  @override
  String toString() {
    return 'DaySchedule{dayScheduleEntries: $weekScheduleMap}';
  }
}
