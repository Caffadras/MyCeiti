import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/widgets/grades/grades_tab_selection_widget.dart';
import 'package:my_ceiti/widgets/grades/tabs/exam_grades_widget.dart';
import 'package:my_ceiti/widgets/grades/tabs/semester_grades_widget.dart';
import 'package:my_ceiti/widgets/grades/tabs/year_grades_widget.dart';
import 'package:provider/provider.dart';

import '../../blocs/grade/grade_bloc.dart';
import '../../enums/grades_tab_enum.dart';
import '../../providers/seleceted_grades_tab_provider.dart';
import '../../utils/animations_util.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  final TextEditingController _controller = TextEditingController();
  GradeTabs? _selectedTab;
  GradeTabs? _previousTab;

  Future<void> fetchData(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<GradeBloc>().add(FetchGrade(idnp:_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    _previousTab = _selectedTab ?? GradeTabs.semester;
    _selectedTab = Provider.of<SelectedGradesTabProvider>(context).selectedTab;

    return BlocBuilder<GradeBloc, GradeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, right: 10, left: 10),
            child: Column(
              children: [
                Expanded(child: _buildMainSection(state)),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GradesTabSelectionWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainSection(GradeState state) {
    if (state is GradeLoading) {
      return CircularProgressIndicator();
    } else if (state is GradeLoaded) {
      return PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: _previousTab!.index > _selectedTab!.index,
          transitionBuilder: AnimationsUtil.sharedAxisTransition,
          child: _buildGradesSection(state));
    } else if (state is GradeError) {
      return Text('Error: ${state.error}');
    } else if (state is GradeInitial) {
      return Center(
          child: Text(AppLocalizations.of(context)!.enterIDNPVerbose));
    } else {
      return Text("error");
    }
  }

  Widget _buildGradesSection(GradeLoaded state) {
    switch (_selectedTab) {
      case GradeTabs.exam:
        return ExamGradesWidget(
          semesterModel: state.response,
        );
      case GradeTabs.year:
        return YearGradesWidget(
          semesterModel: state.response,
        );
      default:
        return SemesterGradesWidget(
          semesterModel: state.response,
        );
    }
  }


}
