import 'package:html/dom.dart';
import 'package:my_ceiti/services/parser_service.dart';

import '../../enums/exam_type_enum.dart';
import '../../main.dart';
import '../../models/grades/exam_grades_model.dart';
import '../../utils/html_parser_constants.dart';
import '../date_time_service.dart';

class ExamGradesParser{
  final DateTimeService dateTimeService = getIt<DateTimeService>();

  List<ExamGradesModel> parse(Document document, int? year){
    List<ExamGradesModel> examGradesList = [];
    year ??= 1;
    int htmlIdPostfix = dateTimeService.isFirstSemester() ? year * 2 - 2 : year * 2 - 1;
    String examGradesId = ParserConstants.examGradesDivId + htmlIdPostfix.toString();
    Element? examGradesDiv = document.getElementById(examGradesId);
    if (examGradesDiv != null){
      List<Element> examGradesRows = examGradesDiv.getElementsByTagName("tr");
      for (Element row in examGradesRows){
        List<Element> cols = row.getElementsByTagName("td");

        if (cols.length == 2){
          String? fullSubjectName = cols[0].getElementsByTagName('p').safeGet(0)?.innerHtml;
          String? subjectName = _extractSubjectName(fullSubjectName);
          String? examGradeString = cols[1].getElementsByTagName('p').safeGet(0)?.innerHtml;
          double? examGrade = examGradeString == null ? null : double.tryParse(examGradeString);
          ExamTypeEnum examType = _parseExamType(fullSubjectName!);
          ExamGradesModel examGradesModel = ExamGradesModel(fullSubjectName, subjectName, examGrade, examType);
          print(examGradesModel);
          examGradesList.add(examGradesModel);
        }
      }
    } else {
      print("Exam grades div is null");
    }
    return examGradesList;
  }
  //

  ExamTypeEnum _parseExamType(String subjectName) {
    subjectName = subjectName.trim();

    if (subjectName.startsWith('(Examen)')) {
      return ExamTypeEnum.exam;
    } else if (subjectName.startsWith('(Teza)')) {
      return ExamTypeEnum.teza;
    } else if (subjectName.startsWith('(Practica)')) {
      return ExamTypeEnum.practica;
    }

    print("--- subjectName: $subjectName does not have exam type");
    return ExamTypeEnum.undefined;
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