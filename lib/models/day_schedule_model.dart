import 'package:my_ceiti/models/schedule_entry_model.dart';

class DayScheduleModel {
  List<ScheduleEntryModel> dayScheduleEntries;

  DayScheduleModel({required this.dayScheduleEntries});

  factory DayScheduleModel.fromJson(Map<String, dynamic> json) {
    List<ScheduleEntryModel> entries = [];
    json.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        entries.add(ScheduleEntryModel.fromJson(value));
      }
    });
    return DayScheduleModel(dayScheduleEntries: entries);
  }

  @override
  String toString() {
    return 'DaySchedule{dayScheduleEntries: $dayScheduleEntries}';
  }
}
