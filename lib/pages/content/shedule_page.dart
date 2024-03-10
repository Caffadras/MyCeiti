import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/blocs/schedule/schedule_bloc.dart';
import 'package:my_ceiti/models/group_model.dart';

import '../../blocs/grade/grade_bloc.dart';
import '../../widgets/group_selection_widget.dart';


class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final TextEditingController _controller = TextEditingController();
  String _response = 'Response will be shown here';

/*  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://api.agify.io?name=${_controller.text}'));
    if (response.statusCode == 200) {
      setState(() {
        _response = json.decode(response.body)['age'].toString();
      });
    } else {
      setState(() {
        _response = 'Failed to load data';
      });
    }
  }*/

  Future<void> fetchData(BuildContext context) async {
    context
        .read<ScheduleBloc>()
        .add(FetchSchedule(studentId: _controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleBloc(),
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.schedulePage),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GroupSelection(onSelect: _onGroupSelect,),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter your name'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => fetchData(context),
                    child: Text('Fetch Age'),
                  ),
                  SizedBox(height: 20),
                  buildText(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildText(ScheduleState state) {
    if (state is ScheduleLoading) {
      return CircularProgressIndicator();
    } else if (state is ScheduleLoaded) {
      return Text('Schedule: ${state.response}');
    } else if (state is ScheduleError) {
      return Text('Error: ${state.error}');
    } else {
      return Text("error schedule");
    }
  }


  void _onGroupSelect(GroupModel? model){
    print("### CALLBACK GROP SELECTION");
  }
}
