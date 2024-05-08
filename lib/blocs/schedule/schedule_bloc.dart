import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_ceiti/main.dart';
import 'package:my_ceiti/models/group_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/schedule/week_schedule_model.dart';
import '../../services/schedule_service.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleService _scheduleService = getIt<ScheduleService>();
  static const String _persistedScheduleKey = "persistedSchedule";

  ScheduleBloc() : super(ScheduleInitial()) {
    on<LoadPersistedSchedule>(_loadPersistedSchedule);
    on<FetchSchedule>(_onFetchSchedule);

    add(LoadPersistedSchedule());
  }

  Future<void> _loadPersistedSchedule(LoadPersistedSchedule event, Emitter<ScheduleState> emit) async {
    if (_scheduleService.cachedSelectedSchedule != null ){
      emit(ScheduleLoaded(schedule: _scheduleService.cachedSelectedSchedule!));
    } else {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? persistedSchedule = sharedPreferences.getString(_persistedScheduleKey);
      if (persistedSchedule != null){
        Map<String, dynamic> scheduleJson = jsonDecode(persistedSchedule);
        WeekScheduleModel schedule = WeekScheduleModel.fromJson(scheduleJson);
        emit(ScheduleLoaded(schedule: schedule));
      }
    }
  }

  void _persistSchedule(WeekScheduleModel schedule) {
    SharedPreferences.getInstance()
        .then((pref) => pref.setString(
          _persistedScheduleKey, jsonEncode(schedule.toJson())));
  }

  Future<void> _onFetchSchedule(FetchSchedule event, Emitter<ScheduleState> emit) async{
    emit(ScheduleLoading());
    try{
      WeekScheduleModel schedule = await _scheduleService.getSchedule(event.group.id);
      // final response = await http.get(Uri.parse('https://api.agify.io?name=${event.group.name}'));

      //if response.statusCode == 200

      emit(ScheduleLoaded(schedule: schedule));
      _persistSchedule(schedule);
    } on TimeoutException catch (_){
      emit(ScheduleTimeout());
    } catch(_){
      emit(ScheduleError());
    }

    // emit(ScheduleLoading());
  }
}
