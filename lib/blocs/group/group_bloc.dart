import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../models/group_model.dart';
import '../../services/group_service.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  static const String _persistedGroupKey = "persistedGroup";
  final GroupService _groupService = getIt<GroupService>();

  GroupBloc() : super(GroupInitial()) {
    on<LoadPersistedGroup>(_onLoadPersistedGroup);
    on<GroupSelectedEvent>(_onGroupSelectedEvent);

    add(LoadPersistedGroup());
  }

  void _onLoadPersistedGroup( LoadPersistedGroup event, Emitter<GroupState> emit) {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.getString(_persistedGroupKey))
        .then((persistedGroup) => _parseGroupAndEmit(persistedGroup, emit));
  }

  void _parseGroupAndEmit(String? persistedGroup, Emitter<GroupState> emit) {
    if (persistedGroup != null) {
      Map<String, dynamic> groupJson = jsonDecode(persistedGroup);
      GroupModel selectedGroup = GroupModel.fromJson(groupJson);
      emit(GroupSelectedState(selectedGroup: selectedGroup));
    }
  }

  void _onGroupSelectedEvent(
      GroupSelectedEvent event, Emitter<GroupState> emit) {
    emit(GroupSelectedState(selectedGroup: event.selectedGroup));
    _persistGroup(event.selectedGroup);
  }

  void _persistGroup(GroupModel groupModel) {
    SharedPreferences.getInstance().then((pref) =>
        pref.setString(_persistedGroupKey, jsonEncode(groupModel.toJson())));
  }
}
