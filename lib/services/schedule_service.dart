import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_ceiti/utils/uri_constants.dart';

import '../models/day_schedule_model.dart';

class ScheduleService {
  final String _exampleResponse =
      "{ \"data\":{ \"monday\":{ \"1\":{ \"par\":[ ], \"impar\":[ ], \"both\":[ ] }, \"2\":{ \"par\":[ ], \"impar\":[ ], \"both\":[ { \"_id\":\"65e9fae66fff9d77b67fbad7\", \"subjectid\":{ \"name\":\"Prel.inf.text.num\" }, \"teacherids\":{ \"name\":\"Munteanu A.\" }, \"classroomids\":{ \"name\":\"103(19)\" }, \"groupids\":{ \"_id\":\"65e9fae66fff9d77b67fb5c1\", \"id\":\"E6911448FB58B945\", \"name\":\"Grupa 1\", \"classid\":\"48DEB81958E53880\", \"studentids\":\"\", \"entireclass\":\"0\", \"divisiontag\":\"1\", \"studentcount\":\"\" }, \"cards\":{ \"period\":\"2\", \"weeks\":\"11\", \"days\":\"10000\" } }, { \"_id\":\"65e9fae66fff9d77b67fbc44\", \"subjectid\":{ \"name\":\"Prel.inf.text.num\" }, \"teacherids\":{ \"name\":\"Salcutanu A.\" }, \"classroomids\":{ \"name\":\"104(34)\" }, \"groupids\":{ \"_id\":\"65e9fae66fff9d77b67fb5c2\", \"id\":\"121CA705D751797D\", \"name\":\"Grupa 2\", \"classid\":\"48DEB81958E53880\", \"studentids\":\"\", \"entireclass\":\"0\", \"divisiontag\":\"1\", \"studentcount\":\"\" }, \"cards\":{ \"period\":\"2\", \"weeks\":\"11\", \"days\":\"10000\" } } ] }, \"3\":{ \"par\":[ ], \"impar\":[ ], \"both\":[ { \"_id\":\"65e9fae66fff9d77b67fbae7\", \"subjectid\":{ \"name\":\"Chimia\" }, \"teacherids\":{ \"name\":\"Golic L.\" }, \"classroomids\":{ \"name\":\"306\" }, \"groupids\":{ \"_id\":\"65e9fae66fff9d77b67fb5c0\", \"id\":\"7F7CC8CB55BFA7E6\", \"name\":\"Clasã intreagã\", \"classid\":\"48DEB81958E53880\", \"studentids\":\"\", \"entireclass\":\"1\", \"divisiontag\":\"0\", \"studentcount\":\"\" }, \"cards\":{ \"period\":\"3\", \"weeks\":\"11\", \"days\":\"10000\" } } ] }, \"4\":{ \"par\":[ ], \"impar\":[ ], \"both\":[ ] }, \"5\":{ \"par\":[ ], \"impar\":[ ], \"both\":[ ] }, \"6\":{ \"par\":[ ], \"impar\":[ ], \"both\":[ ] } } } }";

  Future <Map<String, DayScheduleModel>> getSchedule(String groupId) async {
    final response = await http
        .get(Uri.parse(UriConstants.getScheduleUri(groupId)))
        .timeout(const Duration(seconds: 2));

    final data = jsonDecode(response.body)['data'];

    Map<String, DayScheduleModel> weekSchedule = {};

    data.forEach((day, scheduleJson) {
      weekSchedule[day] = DayScheduleModel.fromJson(scheduleJson);
    });


    print(weekSchedule.toString());


    return weekSchedule;
  }
}
