import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ceiti/blocs/schedule/schedule_bloc.dart';

import '../../widgets/schedule/schedule_widget.dart';
import '../../widgets/schedule/week_day_selection_widget.dart';

/*
{
        "_id": "65e9fae66fff9d77b67fb542",
        "id": "D612397E79E6DD3A",
        "name": "P-2043R",
        "diriginte": {
            "name": "Carp A."
        }
    },
 */
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
        padding: EdgeInsets.only(bottom: 20.0, right: 10, left: 10),
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
