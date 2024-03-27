import 'package:my_ceiti/models/grades/absences_model.dart';
import 'package:my_ceiti/models/grades/subject_grades.dart';

class SemesterModel {
  final List<SubjectGrades> subjectGrades;
  final AbsencesModel absencesModel;

  SemesterModel(this.subjectGrades, this.absencesModel);

  @override
  String toString() {
    return 'SemesterModel{subjectGrades: $subjectGrades, absencesModel: $absencesModel}';
  }
}
