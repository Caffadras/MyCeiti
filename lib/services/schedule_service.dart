import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_ceiti/models/schedule/week_schedule_model.dart';
import 'package:my_ceiti/utils/uri_constants.dart';


class ScheduleService {
  final Map<String, WeekScheduleModel> _cachedResponses = {};
  WeekScheduleModel? _cachedSelectedSchedule;

  WeekScheduleModel? get cachedSelectedSchedule => _cachedSelectedSchedule;

  Future <WeekScheduleModel> getSchedule(String groupId) async {
    if (_cachedResponses.containsKey(groupId)){
      _cachedSelectedSchedule = _cachedResponses[groupId]!;
      return _cachedResponses[groupId]!;
    }
    final response = await http
        .get(Uri.parse(UriConstants.getScheduleUri(groupId)))
        .timeout(const Duration(seconds: 2));

    final data = jsonDecode(response.body);

    WeekScheduleModel weekSchedule = WeekScheduleModel.fromJson(data);

    _cachedSelectedSchedule = weekSchedule;
    _cachedResponses[groupId] = weekSchedule;

    return weekSchedule;
  }
}
