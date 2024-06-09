import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:my_ceiti/models/grades/absences_model.dart';
import 'package:my_ceiti/models/grades/exam_grades_model.dart';
import 'package:my_ceiti/models/grades/personal_info_model.dart';
import 'package:my_ceiti/models/grades/semester_model.dart';
import 'package:my_ceiti/services/date_time_service.dart';
import 'package:my_ceiti/services/parser/exam_grades_parser.dart';

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

  Future<SemesterModel> parseResponse(
      String response, bool firstSemester) async {
    String selectedSemester = firstSemester
        ? ParserConstants.firstSemesterGradesId
        : ParserConstants.secondSemesterGradesId;

    Document document = parse(response);

    Element personalInfoDiv = document.getElementById(ParserConstants.personalInfoId)!;

    Element semesterDiv = document.getElementById(selectedSemester)!;
    Element gradesTable = semesterDiv.getElementsByTagName("table")[0];
    List<Element> gradesRows = gradesTable.getElementsByTagName("tr");

    // gradesTable.
    print(gradesRows);

    PersonalInfoModel personalInfoModel = _parsePersonalInfo(personalInfoDiv);

    List<ExamGradesModel> examGradesList =
        examGradesParser.parse(document, personalInfoModel.year);

    List<SubjectGradesModel> subjectGradesList = _parseSubjectGrades(gradesRows);
    AbsencesModel absencesModel = _parseAbsences(gradesRows);

    var semesterModel = SemesterModel(personalInfoModel, subjectGradesList, absencesModel, examGradesList);
    print("#");
    print("#");
    print("#");
    print(semesterModel);
    return semesterModel;
  }

  String _extractSubjectName(String fullString) {
    // Trim leading and trailing white spaces
    fullString = fullString.trim();

    // Check if the string starts with '(' and has a closing ')'
    if (fullString.startsWith('(')) {
      int endIndex = fullString.indexOf(')');
      if (endIndex != -1) {
        // Remove the type in parentheses and any leading spaces after it
        return fullString.substring(endIndex + 1).trim();
      }
    }

    // If no valid pattern is found, return the full string
    return fullString;
  }


  PersonalInfoModel _parsePersonalInfo(Element personalInfoDiv) {
    List<Element> personalInfoTableRows =
        personalInfoDiv.getElementsByTagName("tr");

    String? lastName = personalInfoTableRows
        .safeGet(0)
        ?.getElementsByTagName("td")
        .safeGet(0)
        ?.innerHtml;

    String? firstName = personalInfoTableRows
        .safeGet(1)
        ?.getElementsByTagName("td")
        .safeGet(0)
        ?.innerHtml;

    String? year = personalInfoTableRows
        .safeGet(3)
        ?.getElementsByTagName("td")
        .safeGet(0)
        ?.innerHtml;


    return PersonalInfoModel(firstName, lastName, year);
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

  int? _yearToInt(String? year){
    if (year == null) return null;
    switch (year){
      case "I":
        return 1;
      case "II":
        return 2;
      case "III":
        return 3;
      case "IV":
        return 4;
    }
    return null;
  }
}
