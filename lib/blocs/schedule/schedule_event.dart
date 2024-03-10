part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent {}

class FetchSchedule extends ScheduleEvent{
  final GroupModel group;

  FetchSchedule({required this.group});
}