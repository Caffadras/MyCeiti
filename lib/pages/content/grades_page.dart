import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../blocs/grade/grade_bloc.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  final TextEditingController _controller = TextEditingController();
  String _response = 'Response will be shown here';



  Future<void> fetchData(BuildContext context) async {
    context.read<GradeBloc>().add(FetchGrade(studentId: _controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GradeBloc(),
      child: BlocBuilder<GradeBloc, GradeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.gradesPage),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter your name2'),
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

  Widget buildText(GradeState state) {
    if (state is GradeLoading) {
      return CircularProgressIndicator();
    } else if (state is GradeLoaded) {
      return Text('Grade: ${state.response}');
    } else if (state is GradeError) {
      return Text('Error: ${state.error}');
    } else {

      return Text("error");
    }
  }
}
