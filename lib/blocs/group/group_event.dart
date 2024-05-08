part of 'group_bloc.dart';

@immutable
sealed class GroupEvent {}

class LoadPersistedGroup extends GroupEvent{
  LoadPersistedGroup();
}

class GroupSelectedEvent extends GroupEvent{
  final GroupModel selectedGroup;

  GroupSelectedEvent({required this.selectedGroup});
}
