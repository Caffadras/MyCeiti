class WeekdayUtil {
  static final Map<String, int> _weekdays = {
    'monday': 0,
    'tuesday': 1,
    'wednesday': 2,
    'thursday': 3,
    'friday': 4,
    'saturday': 5,
    'sunday': 6,
  };

  static int dayToNumber(String weekday) {
    String key = weekday.toLowerCase();
    if (_weekdays.containsKey(key)){
      return _weekdays[key]!;
    } else {
      print("Invalid weekday name: $weekday");
      return 0;
    }
  }
}