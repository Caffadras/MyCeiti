import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/blocs/schedule/schedule_bloc.dart';
import 'package:my_ceiti/models/group_model.dart';
import 'package:my_ceiti/services/group_service.dart';

class GroupSelection extends StatefulWidget {
  final void Function(GroupModel?) onSelect;
  const GroupSelection({super.key, required this.onSelect});

  @override
  State<GroupSelection> createState() => _GroupSelectionState();
}

class _GroupSelectionState extends State<GroupSelection> {
  final GroupService _groupService = GroupService();


  @override
  Widget build(BuildContext context) {
    return DropdownSearch<GroupModel>(
      //todo or else from storage
      asyncItems: fetchGroups,


      itemAsString: (GroupModel g) => g.name,
      popupProps:  PopupProps.menu(
        errorBuilder: (context, searchEntry, error) {
          // This widget is shown when an error occurs in fetching dropdown items
          return ListTile(
            leading: Icon(Icons.error, color: Colors.red),
            title: Text(AppLocalizations.of(context)!.groupsNetworkTimeout),
            subtitle: Text(AppLocalizations.of(context)!.tryAgainLater),
          );
        },
/*        searchDelay: Duration.zero,
        showSearchBox: true,*/
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.groupName,
        ),
      ),
      onChanged: _onSelectionChanged,
    );
  }

  Future<List<GroupModel>> fetchGroups(String filter) async{
    try {
      return _groupService.fetchGroups();
    } on Error catch (_){
      return [];
    }

  }

  void _onSelectionChanged(GroupModel? groupModel){
    if (groupModel != null){
      print("onSelectionChanged: ${groupModel.name}");
      context.read<ScheduleBloc>().add(FetchSchedule(group: groupModel));
    }
    widget.onSelect(groupModel);
  }

  /*@override
  Widget build(BuildContext context) {
*//*    return FutureBuilder(
      future: _groupService.fetchGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        } else if (snapshot.hasError){
          //todo
        }
        final groups = snapshot.data!;*//*
        return DropdownSearch<GroupModel>(
          asyncItems: (String filter) => _groupService.fetchGroups(),
          itemAsString: (GroupModel g) => g.name,
          popupProps: PopupProps.menu(
            searchDelay: Duration.zero,
            // isFilterOnline: true,
            showSearchBox: true,
          ),
          // items: groups.map((e) => e.name).toList(),
          // dropdownButtonProps: InputDecoration(labelText: "Name"),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.groupName,
              // hintText: "country in menu mode",
            ),
          ),
          *//*dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(hintText: "123")),*//*
        );
      *//*},
    );*//*
  }*/
}
