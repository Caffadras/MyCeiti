import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    on<ScheduleEvent>((event, emit) {
      on<FetchSchedule>(_onFetchSchedule);
    });
  }

  Future<void> _onFetchSchedule(FetchSchedule event, Emitter<ScheduleState> emit) async{
    emit(ScheduleLoading());

    try{
      final response = await http.get(Uri.parse('https://api.agify.io?name=${event.studentId}'));

      //if response.statusCode == 200

      emit(ScheduleLoaded(response: response.body));
    } catch (e){
      emit(ScheduleError(error: e.toString()));
    }

    // emit(ScheduleLoading());
  }
}
