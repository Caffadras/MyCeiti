import 'package:html/dom.dart';
import 'package:my_ceiti/models/grades/annual_grades_model.dart';
import 'package:my_ceiti/services/parser_service.dart';
import 'package:my_ceiti/utils/html_parser_constants.dart';

extension NullIfEmpty on String? {
  String? get nullIfEmpty => this?.trim().isEmpty == true ? null : this;
}

class AnnualGradesParser{
  List<AnnualGradesModel> parse(Document document, int? year){
    List<AnnualGradesModel> annualGradesList = [];

    int yearPostfix = 2;
    String annualGradesId = '${ParserConstants.annualGradesDivId}$yearPostfix';

    Element? annualGradesDiv = document.getElementById(annualGradesId);

    if (annualGradesDiv != null){
      List<Element> rows = annualGradesDiv.getElementsByTagName("tr");
      for (Element row in rows){
        List<Element> cols = row.getElementsByTagName("td");

        if (cols.length == 6){
          String? subjectName = cols[0].getElementsByTagName('p').safeGet(0)?.innerHtml.nullIfEmpty;
          String? firstSemGrade = cols[1].getElementsByTagName('p').safeGet(0)?.innerHtml.nullIfEmpty;
          String? secondSemGrade = cols[2].getElementsByTagName('p').safeGet(0)?.innerHtml.nullIfEmpty;
          String? annualGrade = cols[3].getElementsByTagName('p').safeGet(0)?.innerHtml.nullIfEmpty;
          String? examGrade = cols[4].getElementsByTagName('p').safeGet(0)?.innerHtml.nullIfEmpty;
          String? examType = cols[5].getElementsByTagName('p').safeGet(0)?.innerHtml.nullIfEmpty;

          AnnualGradesModel annualGradesModel = AnnualGradesModel(
            subject: subjectName,
            firstSemesterGrade: firstSemGrade,
            secondSemesterGrade: secondSemGrade,
            annualGrade: annualGrade,
            examGrade: examGrade,
            examType: examType);

          print(annualGradesModel);
          annualGradesList.add(annualGradesModel);
        }
      }

    }

    return annualGradesList;
  }
}