import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/widgets/grades_table_widget.dart';

import '../../blocs/grade/grade_bloc.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  final TextEditingController _controller = TextEditingController();
  int _selectedPageIndex = 0;

  Future<void> fetchData(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<GradeBloc>().add(FetchGrade(idnp:_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GradeBloc(),
      child: BlocBuilder<GradeBloc, GradeState>(
        builder: (context, state) {
          return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enterIDNP),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => fetchData(context),
                      child: Text(AppLocalizations.of(context)!.fetchGrades),
                    ),
                    SizedBox(height: 20),
                    buildText(state),
                    Text("Page $_selectedPageIndex"),
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget buildText(GradeState state) {
    if (state is GradeLoading) {
      return CircularProgressIndicator();
    } else if (state is GradeLoaded) {
      return GradesTableWidget(
        semesterModel: state.response,
      );
    } else if (state is GradeError) {
      return Text('Error: ${state.error}');
    } else {
      return Text("error");
    }
  }
}
