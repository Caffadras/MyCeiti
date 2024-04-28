import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/blocs/schedule/schedule_bloc.dart';
import 'package:my_ceiti/models/group_model.dart';
import 'package:my_ceiti/services/group_service.dart';

class GroupSelectionWidget extends StatefulWidget {
  final void Function(GroupModel?) onSelect;

  const GroupSelectionWidget({super.key, required this.onSelect});

  @override
  State<GroupSelectionWidget> createState() => _GroupSelectionWidgetState();
}

class _GroupSelectionWidgetState extends State<GroupSelectionWidget> {
  final GroupService _groupService = GroupService();
  String? selectedGroup;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(builder: (context, state) {
      ScheduleBloc scheduleBloc = context.read<ScheduleBloc>();
      return Card(
        margin: EdgeInsets.symmetric(horizontal: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        //todo hardcoded
        color: Colors.grey[100],
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () async {
            final selectedItemModel = await showDialog<GroupModel>(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: _buildDialogContent(context, scheduleBloc),
                );
              },
            );
            if (selectedItemModel != null) {
              setState(() {
                selectedGroup = selectedItemModel.name;
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Group: ${selectedGroup ?? ""}",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  )),
            ],
          ),
        ),
      );
      /*Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () async {
              final selectedItemModel = await showDialog<GroupModel>(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: _buildDialogContent(context, scheduleBloc),
                  );
                },
              );
              if (selectedItemModel != null) {
                setState(() {
                  selectedGroup = selectedItemModel.name;
                });
              }
            },
            child: Text(AppLocalizations.of(context)!.selectGroup),
          ),
          Text(selectedGroup ?? "")
        ],
      );*/
    });
  }

  Widget _buildDialogContent(BuildContext context, ScheduleBloc scheduleBloc) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder(
            future: fetchGroups(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text(AppLocalizations.of(context)!.groupsNetworkTimeout);
              } else {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Scrollbar(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(snapshot.data![index].name),
                              onTap: () {
                                scheduleBloc.add(FetchSchedule(
                                    group: snapshot.data![index]));
                                Navigator.pop(context, snapshot.data![index]);
                              },
                            );
                          }),
                    ),
                  ),
                );
              }
            }),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel))
      ],
    );
  }

  Future<List<GroupModel>> fetchGroups() async {
    // try {
    //   await Future.delayed(Duration(seconds: 2));

    return await _groupService.fetchGroups();
    // } catch (_) {
    //   return [];
    // }
  }

  void _onSelectionChanged(GroupModel? groupModel) {
    if (groupModel != null) {
      print("onSelectionChanged: ${groupModel.name}");
      context.read<ScheduleBloc>().add(FetchSchedule(group: groupModel));
    }
    widget.onSelect(groupModel);
  }

/*@override
  Widget build(BuildContext context) {
*/ /*    return FutureBuilder(
      future: _groupService.fetchGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        } else if (snapshot.hasError){
          //todo
        }
        final groups = snapshot.data!;*/ /*
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
          */ /*dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(hintText: "123")),*/ /*
        );
      */ /*},
    );*/ /*
  }*/
}
