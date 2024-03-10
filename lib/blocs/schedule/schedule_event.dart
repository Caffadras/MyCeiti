part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent {}

class FetchSchedule extends ScheduleEvent{
  final String studentId;

  FetchSchedule({required this.studentId});
}