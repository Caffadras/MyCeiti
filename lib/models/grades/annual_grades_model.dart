

class AnnualGradesModel {
  final String? subject;
  final String? firstSemesterGrade;
  final String? secondSemesterGrade;
  final String? examGrade;
  final String? annualGrade;
  final String? examType;

  AnnualGradesModel({
    this.subject,
    this.firstSemesterGrade,
    this.secondSemesterGrade,
    this.examGrade,
    this.annualGrade,
    this.examType,
  });

  @override
  String toString() {
    return 'AnnualGradesModel{subject: $subject, firstSemesterGrade: $firstSemesterGrade, secondSemesterGrade: $secondSemesterGrade, examGrade: $examGrade, annualGrade: $annualGrade, examType: $examType}';
  }
}