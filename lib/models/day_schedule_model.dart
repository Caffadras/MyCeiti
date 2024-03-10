import 'package:my_ceiti/models/schedule_entry.dart';

class DaySchedule {
  List<ScheduleEntry> dayScheduleEntries;

  DaySchedule({required this.dayScheduleEntries});

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    List<ScheduleEntry> entries = [];
    json.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        entries.add(ScheduleEntry.fromJson(value));
      }
    });
    return DaySchedule(dayScheduleEntries: entries);
  }

  @override
  String toString() {
    return 'DaySchedule{dayScheduleEntries: $dayScheduleEntries}';
  }
}
