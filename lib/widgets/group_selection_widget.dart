import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/blocs/group/group_bloc.dart';
import 'package:my_ceiti/main.dart';
import 'package:my_ceiti/models/group_model.dart';
import 'package:my_ceiti/services/group_service.dart';

class GroupSelectionWidget extends StatefulWidget {
  const GroupSelectionWidget({super.key});

  @override
  State<GroupSelectionWidget> createState() => _GroupSelectionWidgetState();
}

class _GroupSelectionWidgetState extends State<GroupSelectionWidget> {
  final GroupService _groupService = getIt<GroupService>();
  String? selectedGroup;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        GroupBloc groupBloc = context.read<GroupBloc>();
        if (state is GroupSelectedState) {
          selectedGroup = state.selectedGroup.name;
        }
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          //todo hardcoded
          color: Colors.grey[100],
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () async {
              final selectedItemModel = await showDialog<GroupModel>(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: _buildDialogContent(context, groupBloc),
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
                      style: TextStyle(fontSize: 18),
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
      },
    );
  }

  Widget _buildDialogContent(BuildContext context, GroupBloc groupBloc) {
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
                                groupBloc.add(GroupSelectedEvent(
                                    selectedGroup: snapshot.data![index]));
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
}
