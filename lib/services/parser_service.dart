import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:my_ceiti/models/grades/absences_model.dart';
import 'package:my_ceiti/models/grades/semester_model.dart';

import '../models/grades/subject_grades.dart';
import '../utils/html_parser_constants.dart';

class ParserService {

  Future<SemesterModel> parseResponse(String response, bool firstSemester) async {
    String selectedSemester = firstSemester
        ? ParserConstants.firstSemesterGradesId : ParserConstants.secondSemesterGradesId;

    Document document = parse(response);
    Element semesterDiv = document.getElementById(selectedSemester)!;
    Element gradesTable = semesterDiv.getElementsByTagName("table")[0];
    List<Element> gradesRows = gradesTable.getElementsByTagName("tr");

    // gradesTable.
    print(gradesRows);

    List<SubjectGrades> subjectGradesList = _parseSubjectGrades(gradesRows);
    AbsencesModel absencesModel = _parseAbsences(gradesRows);

    return SemesterModel(subjectGradesList, absencesModel);
  }

  AbsencesModel _parseAbsences(List<Element> rows) {
    int startingIdx = rows.length - 4;
    print(rows[startingIdx].innerHtml);
    int total = int.parse(rows[startingIdx].getElementsByTagName("th")[1].innerHtml);
    int sick = int.parse(rows[startingIdx+1].getElementsByTagName("td")[1].children[0].innerHtml);
    int motivated = int.parse(rows[startingIdx+2].getElementsByTagName("td")[1].children[0].innerHtml);
    int unmotivated = int.parse(rows[startingIdx+3].getElementsByTagName("td")[1].children[0].innerHtml);

    AbsencesModel absencesModel = AbsencesModel(total, sick, motivated, unmotivated);
    print(absencesModel);
    return absencesModel;
  }

  List<SubjectGrades> _parseSubjectGrades(List<Element> gradesRows) {
    List<SubjectGrades> subjectGradesList = [];
    for (int i =1; i<gradesRows.length - 4; ++i){
      Element row = gradesRows[i];
      print(row.outerHtml);
      List<Element> columns = row.getElementsByTagName("td");
      String subjectName = columns[0].children[0].innerHtml;
      String subjectGradesAndAbsences = columns[1].children[0].innerHtml;
      List<int> subjectGrades = _extractGrades(subjectGradesAndAbsences);
      List<String> subjectAbsences = _extractAbsences(subjectGradesAndAbsences);
      subjectGradesList.add(SubjectGrades(subjectName, subjectGradesAndAbsences, subjectGrades, subjectAbsences));
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