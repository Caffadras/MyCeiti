import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_ceiti/models/grades/subject_grades.dart';

import '../../services/grades_service.dart';

part 'grade_event.dart';
part 'grade_state.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  final GradesService gradesService = GradesService();

  GradeBloc() : super(GradeInitial()) {

    on<FetchGrade>(_onFetchGrade);
  }

  Future<void> _onFetchGrade(FetchGrade event, Emitter<GradeState> emit) async{
    emit(GradeLoading());

    await gradesService.performLogin(event.idnp);
    //var list = await gradesService.parseResponse();

    //emit(GradeLoaded(response: list));

/*      try{
        final response = await http.get(Uri.parse('https://api.agify.io?name=${event.studentId}'));

        //if response.statusCode == 200

        emit(GradeLoaded(response: response.body));
      } catch (e){
        emit(GradeError(error: e.toString()));
      }*/

      // emit(GradeLoading());
  }

}
