class LessonBreaksUtil {
  static const List<Map<String, String>> defaultPeriods = [
    {'start': '8:00', 'end': '9:30'},
    {'start': '9:40', 'end': '11:10'},
    {'start': '11:40', 'end': '13:10'},
    {'start': '13:20', 'end': '14:50'},
    {'start': '15:00', 'end': '16:30'}
  ];

  static String getDefaultStartTime(int lessonIdx) {
    if (lessonIdx >= 0 && lessonIdx < defaultPeriods.length) {
      return defaultPeriods[lessonIdx]['start'] ?? "00:00";
    }
    return "00:00";
  }

  static String getDefaultEndTime(int lessonIdx) {
    if (lessonIdx >= 0 && lessonIdx < defaultPeriods.length) {
      return defaultPeriods[lessonIdx]['end'] ?? "00:00";
    }
    return "00:00";
  }
}
