import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_ceiti/models/day_schedule_model.dart';
import 'package:my_ceiti/models/group_model.dart';

import '../../services/schedule_service.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleService _scheduleService = ScheduleService();

  ScheduleBloc() : super(ScheduleInitial()) {
    // on<ScheduleEvent>((event, emit) {});
    on<FetchSchedule>(_onFetchSchedule);

  }

  Future<void> _onFetchSchedule(FetchSchedule event, Emitter<ScheduleState> emit) async{
    print("_onFetchSchedule");
    emit(ScheduleLoading());
    try{
      Map<String, DaySchedule> schedule = await _scheduleService.getSchedule(event.group.id);
      // final response = await http.get(Uri.parse('https://api.agify.io?name=${event.group.name}'));

      //if response.statusCode == 200

      emit(ScheduleLoaded(schedule: schedule));
    } catch (e){
      emit(ScheduleError(error: e.toString()));
    }

    // emit(ScheduleLoading());
  }
}
