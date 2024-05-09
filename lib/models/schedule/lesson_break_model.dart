class LessonBreakModel {
  String id;
  String start;
  String end;

  LessonBreakModel({
    required this.id,
    required this.start,
    required this.end,
  });

  factory LessonBreakModel.fromJson(Map<String, dynamic> json) {
    return LessonBreakModel(
      id: json['_id'],
      start: json['starttime'],
      end: json['endtime'],
    );
  }

}