import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/blocs/group/group_bloc.dart';
import 'package:my_ceiti/main.dart';
import 'package:my_ceiti/models/group_model.dart';
import 'package:my_ceiti/services/group_service.dart';

class ScheduleAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const ScheduleAppBarWidget({super.key});

  @override
  State<ScheduleAppBarWidget> createState() => _ScheduleAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ScheduleAppBarWidgetState extends State<ScheduleAppBarWidget> {
  final GroupService _groupService = getIt<GroupService>();
  String? selectedGroup;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        GroupBloc groupBloc = context.read<GroupBloc>();
        return AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(_getAppBarTitle(state, context)),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
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
            ),
          ],
        );
      },
    );
  }

  String _getAppBarTitle(GroupState state, BuildContext context) {
    if (state is GroupSelectedState) {
      return "${state.selectedGroup.name} ${AppLocalizations.of(context)!.appBarSchedule}";
    } else {
      return AppLocalizations.of(context)!.appBarScheduleNoGroup;
    }
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
    return await _groupService.fetchGroups();
  }
}
