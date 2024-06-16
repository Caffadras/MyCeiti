import 'package:my_ceiti/models/grades/absences_model.dart';
import 'package:my_ceiti/models/grades/personal_info_model.dart';
import 'package:my_ceiti/models/grades/subject_grades_model.dart';

import 'annual_grades_model.dart';
import 'exam_grades_model.dart';

class SemesterModel {

  final PersonalInfoModel personalInfoModel;
  final List<SubjectGradesModel> subjectGrades;
  final List<ExamGradesModel> examGrades;
  final List<AnnualGradesModel> annualGrades;
  final AbsencesModel absencesModel;

  SemesterModel(this.personalInfoModel, this.subjectGrades, this.absencesModel, this.examGrades, this.annualGrades);

  @override
  String toString() {
    //personalInfoModel: $personalInfoModel, subjectGrades: $subjectGrades, absencesModel: $absencesModel,
    return 'SemesterModel{examGrades: $examGrades}';
  }
}
