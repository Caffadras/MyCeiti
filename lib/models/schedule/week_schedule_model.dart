import 'package:my_ceiti/models/schedule/day_schedule_model.dart';

import '../../utils/week_days_utils.dart';

class WeekScheduleModel {
  //todo should contain group model?
  final Map<String, dynamic> _originalJson;
  final Map<int, DayScheduleModel> weekScheduleMap;

  WeekScheduleModel(this._originalJson, {required this.weekScheduleMap});

  factory WeekScheduleModel.fromJson(Map<String, dynamic> json) {
    Map<int, DayScheduleModel> weekSchedule = {};

    json.forEach((day, scheduleJson) {
      int weekDay = WeekdayUtil.dayToNumber(day);
      weekSchedule[weekDay] = DayScheduleModel.fromJson(scheduleJson);
    });

    return WeekScheduleModel(json, weekScheduleMap: weekSchedule);
  }

  Map<String, dynamic> toJson(){
    return _originalJson;
  }

  @override
  String toString() {
    return 'DaySchedule{dayScheduleEntries: $weekScheduleMap}';
  }
}
