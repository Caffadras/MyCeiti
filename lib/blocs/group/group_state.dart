part of 'group_bloc.dart';

@immutable
sealed class GroupState {}

final class GroupInitial extends GroupState {}

class GroupLoading extends GroupState{}

class GroupLoaded extends GroupState{
  final List<GroupModel> groups;

  GroupLoaded({required this.groups});
}

class GroupSelectedState extends GroupState{
  final GroupModel selectedGroup;

  GroupSelectedState({required this.selectedGroup});
}

