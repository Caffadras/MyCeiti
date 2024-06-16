import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:my_ceiti/models/grades/absences_model.dart';
import 'package:my_ceiti/models/grades/annual_grades_model.dart';
import 'package:my_ceiti/models/grades/exam_grades_model.dart';
import 'package:my_ceiti/models/grades/personal_info_model.dart';
import 'package:my_ceiti/models/grades/semester_model.dart';
import 'package:my_ceiti/services/date_time_service.dart';
import 'package:my_ceiti/services/parser/annual_grades_parser.dart';
import 'package:my_ceiti/services/parser/exam_grades_parser.dart';
import 'package:my_ceiti/services/parser/personal_info_parser.dart';

import '../main.dart';
import '../models/grades/subject_grades_model.dart';
import '../utils/html_parser_constants.dart';

extension SafeList<E> on List<E> {
  E? safeGet(int index) {
    return (index >= 0 && index < length) ? this[index] : null;
  }
}

class ParserService {
  final DateTimeService dateTimeService = getIt<DateTimeService>();

  final ExamGradesParser examGradesParser = ExamGradesParser();
  final PersonalInfoParser personalInfoParser = PersonalInfoParser();
  final AnnualGradesParser annualGradesParser = AnnualGradesParser();

  Future<SemesterModel> parseResponse(
      String response, bool firstSemester) async {
    String selectedSemester = firstSemester
        ? ParserConstants.firstSemesterGradesDivId
        : ParserConstants.secondSemesterGradesDivId;

    Document document = parse(response);

    Element personalInfoDiv = document.getElementById(ParserConstants.personalInfoDivId)!;

    Element semesterDiv = document.getElementById(selectedSemester)!;
    Element gradesTable = semesterDiv.getElementsByTagName("table")[0];
    List<Element> gradesRows = gradesTable.getElementsByTagName("tr");

    PersonalInfoModel personalInfoModel = personalInfoParser.parse(personalInfoDiv);

    List<ExamGradesModel> examGradesList =
        examGradesParser.parse(document, personalInfoModel.numYear);

    List<AnnualGradesModel> annualGradesList = annualGradesParser.parse(document, personalInfoModel.numYear);

    List<SubjectGradesModel> subjectGradesList = _parseSubjectGrades(gradesRows);
    AbsencesModel absencesModel = _parseAbsences(gradesRows);

    var semesterModel = SemesterModel(personalInfoModel, subjectGradesList, absencesModel, examGradesList, annualGradesList);

    print("#");
    print("#");
    print("#");
    print(semesterModel);
    return semesterModel;
  }


  AbsencesModel _parseAbsences(List<Element> rows) {
    int startingIdx = rows.length - 4;
    print(rows[startingIdx].innerHtml);
    int total =
        int.parse(rows[startingIdx].getElementsByTagName("th")[1].innerHtml);
    int sick = int.parse(rows[startingIdx + 1]
        .getElementsByTagName("td")[1]
        .children[0]
        .innerHtml);
    int motivated = int.parse(rows[startingIdx + 2]
        .getElementsByTagName("td")[1]
        .children[0]
        .innerHtml);
    int unmotivated = int.parse(rows[startingIdx + 3]
        .getElementsByTagName("td")[1]
        .children[0]
        .innerHtml);

    AbsencesModel absencesModel =
        AbsencesModel(total, sick, motivated, unmotivated);
    print(absencesModel);
    return absencesModel;
  }

  List<SubjectGradesModel> _parseSubjectGrades(List<Element> gradesRows) {
    List<SubjectGradesModel> subjectGradesList = [];
    for (int i = 1; i < gradesRows.length - 4; ++i) {
      Element row = gradesRows[i];
      // print(row.outerHtml);
      List<Element> columns = row.getElementsByTagName("td");
      String subjectName = columns[0].children[0].innerHtml;
      String subjectGradesAndAbsences = columns[1].children[0].innerHtml;
      List<int> subjectGrades = _extractGrades(subjectGradesAndAbsences);
      List<String> subjectAbsences = _extractAbsences(subjectGradesAndAbsences);
      subjectGradesList.add(SubjectGradesModel(subjectName, subjectGradesAndAbsences,
          subjectGrades, subjectAbsences));
    }
    print(subjectGradesList);
    return subjectGradesList;
  }

  List<int> _extractGrades(String gradesAndAbsences) {
    return gradesAndAbsences
        .split(',')
        .map((e) => int.tryParse(e.trim()))
        .where((grade) => grade != null)
        .cast<int>()
        .toList();
  }

  List<String> _extractAbsences(String gradesAndAbsences) {
    return gradesAndAbsences
        .split(',')
        .map((e) => e.trim())
        .where((value) => int.tryParse(value) == null && value.isNotEmpty)
        .toList();
  }

}
