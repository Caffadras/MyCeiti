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

    List<SubjectGrades> subjectGradesList = parseSubjectGrades(gradesRows);
    AbsencesModel absencesModel = parseAbsences(gradesRows);

    return SemesterModel(subjectGradesList, absencesModel);
  }

  AbsencesModel parseAbsences(List<Element> rows) {
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

  List<SubjectGrades> parseSubjectGrades(List<Element> gradesRows) {
    List<SubjectGrades> subjectGradesList = [];
    for (int i =1; i<gradesRows.length - 4; ++i){
      Element row = gradesRows[i];
      print(row.outerHtml);
      List<Element> columns = row.getElementsByTagName("td");
      String subjectName = columns[0].children[0].innerHtml;
      String subjectGrades = columns[1].children[0].innerHtml;

      subjectGradesList.add(SubjectGrades(subjectName, subjectGrades));
    }
    print(subjectGradesList);
    return subjectGradesList;
  }

}