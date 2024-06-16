import 'package:html/dom.dart';
import 'package:my_ceiti/services/parser_service.dart';

import '../../models/grades/personal_info_model.dart';

class PersonalInfoParser {

  PersonalInfoModel parse(Element personalInfoDiv) {
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

    int? yearInt = _yearToInt(year);

    return PersonalInfoModel(firstName, lastName, year, yearInt);
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
