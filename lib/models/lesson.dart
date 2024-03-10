class Lesson {
  String id;
  String subjectName;
  String teacherName;
  String classroom;
  String groupName;
  String period;
  String weeks;
  String days;

  Lesson({
    required this.id,
    required this.subjectName,
    required this.teacherName,
    required this.classroom,
    required this.groupName,
    required this.period,
    required this.weeks,
    required this.days,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['_id'],
      subjectName: json['subjectid']['name'],
      teacherName: json['teacherids']['name'],
      classroom: json['classroomids']['name'],
      groupName: json['groupids']['name'],
      period: json['cards']['period'],
      weeks: json['cards']['weeks'],
      days: json['cards']['days'],
    );
  }

  @override
  String toString() {
    return 'Lesson{id: $id, subjectName: $subjectName, teacherName: $teacherName, classroom: $classroom, groupName: $groupName, period: $period, weeks: $weeks, days: $days}';
  }
}