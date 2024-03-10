import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'grade_event.dart';
part 'grade_state.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  GradeBloc() : super(GradeInitial()) {
    on<GradeEvent>((event, emit) {
      on<FetchGrade>(_onFetchGrade);
    });
  }

  Future<void> _onFetchGrade(FetchGrade event, Emitter<GradeState> emit) async{
      emit(GradeLoading());

      try{
        final response = await http.get(Uri.parse('https://api.agify.io?name=${event.studentId}'));

        //if response.statusCode == 200

        emit(GradeLoaded(response: response.body));
      } catch (e){
        emit(GradeError(error: e.toString()));
      }

      // emit(GradeLoading());
  }

}
