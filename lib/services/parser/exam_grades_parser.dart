import 'package:html/dom.dart';
import 'package:my_ceiti/services/parser_service.dart';

import '../../enums/exam_type_enum.dart';
import '../../main.dart';
import '../../models/grades/exam_grades_model.dart';
import '../../utils/html_parser_constants.dart';
import '../date_time_service.dart';

class ExamGradesParser{
  final DateTimeService dateTimeService = getIt<DateTimeService>();

  List<ExamGradesModel> parse(Document document, String? stringYear){
    List<ExamGradesModel> annualGradesList = [];
    //todo temp
    // int year = _yearToInt(stringYear) ?? 1;
    int year = 3;
    int htmlIdPostfix = dateTimeService.isFirstSemester() ? year * 2 - 2 : year * 2 - 1;
    String annualGradesId = ParserConstants.annualGradesId + htmlIdPostfix.toString();
    Element? annualGradesDiv = document.getElementById(annualGradesId);
    if (annualGradesDiv != null){
      List<Element> annualGradesRows = annualGradesDiv.getElementsByTagName("tr");
      for (Element row in annualGradesRows){
        List<Element> cols = row.getElementsByTagName("td");

        if (cols.length == 2){
          String? fullSubjectName = cols[0].getElementsByTagName('p').safeGet(0)?.innerHtml;
          String? subjectName = _extractSubjectName(fullSubjectName);
          String? examGradeString = cols[1].getElementsByTagName('p').safeGet(0)?.innerHtml;
          double? examGrade = examGradeString == null ? null : double.tryParse(examGradeString);
          ExamType examType = _parseExamType(fullSubjectName!);
          ExamGradesModel examGradesModel = ExamGradesModel(subjectName, examGrade, examType);
          print(examGradesModel);
          annualGradesList.add(examGradesModel);
        }
      }
    } else {
      print("Annual grades div is null");
    }
    return annualGradesList;
  }
  //

  ExamType _parseExamType(String subjectName) {
    subjectName = subjectName.trim();

    if (subjectName.startsWith('(Examen)')) {
      return ExamType.exam;
    } else if (subjectName.startsWith('(Teza)')) {
      return ExamType.teza;
    } else if (subjectName.startsWith('(Practica)')) {
      return ExamType.practica;
    }

    print("--- subjectName: $subjectName does not have exam type");
    return ExamType.undefined;
  }


  String? _extractSubjectName(String? fullString) {
    fullString = fullString?.trim();

    if (fullString == null || fullString.isEmpty) {
      return null;
    }

    if (fullString.startsWith('(')) {
      int endIndex = fullString.indexOf(')');
      if (endIndex != -1) {
        return fullString.substring(endIndex + 1).trim();
      }
    }

    return fullString;
  }


}