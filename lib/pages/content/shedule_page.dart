import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ceiti/blocs/schedule/schedule_bloc.dart';

import '../../widgets/schedule/schedule_widget.dart';
import '../../widgets/schedule/week_day_selection_widget.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ScheduleBloc(),
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.only(bottom: 10.0, right: 10, left: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: ScheduleWidget()),
            WeekDaySelectionWidget(),
          ],
        ),
      ),
    );
  }
}
