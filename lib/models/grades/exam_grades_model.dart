import '../../enums/exam_type_enum.dart';

class ExamGradesModel{
  final String? fullSubjectName;
  final String? subjectName;
  final double? grade;
  final ExamTypeEnum? examType;
  ExamGradesModel(this.fullSubjectName, this.subjectName, this.grade, this.examType);

  @override
  String toString() {
    return 'ExamGradesModel{subjectName: $subjectName, grade: $grade, examType: $examType}';
  }
}