import 'package:my_ceiti/models/schedule/schedule_entry_model.dart';

class DayScheduleModel {
  List<DayScheduleEntryModel> dayScheduleEntries;

  DayScheduleModel({required this.dayScheduleEntries});

  factory DayScheduleModel.fromJson(Map<String, dynamic> json) {
    List<DayScheduleEntryModel> entries = [];
    json.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        entries.add(DayScheduleEntryModel.fromJson(value));
      }
    });
    return DayScheduleModel(dayScheduleEntries: entries);
  }

  @override
  String toString() {
    return 'DaySchedule{dayScheduleEntries: $dayScheduleEntries}';
  }
}
