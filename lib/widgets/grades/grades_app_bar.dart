import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_ceiti/blocs/grade/grade_bloc.dart';

class GradesAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const GradesAppBarWidget({super.key});

  @override
  State<GradesAppBarWidget> createState() => _GradesAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _GradesAppBarWidgetState extends State<GradesAppBarWidget> {
  final SearchController _controller = SearchController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GradeBloc, GradeState>(
      builder: (context, state) {
        return AppBar(
          centerTitle: true,
          // backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(_buildAppBarText(context, state)),
          actions: [
            _buildSearchAnchor(context),

            /*IconButton(
          icon: Icon(Icons.abc),
          onPressed: (){
            showSearch(context: context, delegate: TestSearch());
          },
        ),*/
          ],
        );
      },
    );
  }

  String _buildAppBarText(BuildContext context, GradeState state) {
    if (state is GradeLoaded) {
      String? lastName = state.response.personalInfoModel.lastName;
      if (lastName != null) {
        return '${AppLocalizations.of(context)!.appBarGrades}: $lastName';
      }
    }
    return AppLocalizations.of(context)!.appBarGrades;
  }

  Widget _buildSearchAnchor(BuildContext context) {
    GradeBloc gradeBloc = context.read<GradeBloc>();
    return SearchAnchor(
        viewConstraints:
            BoxConstraints(minWidth: 550.0, minHeight: 0, maxHeight: 200),
        isFullScreen: false,
        searchController: _controller,
        viewHintText: AppLocalizations.of(context)!.enterIDNP,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.numberWithOptions(),
        builder: (BuildContext context, SearchController controller) {
          return IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              controller.openView();
            },
          );
        },
        viewOnSubmitted: (text) {
          _controller.closeView(_validateInput(text));
          gradeBloc.add(FetchGrade(idnp: text));
        },
        viewOnChanged: (text) {
          _controller.text = _validateInput(text);
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.empty();
        });
  }

  String _validateInput(String text) {
    String digitsOnly = text.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length > 13) {
      digitsOnly = digitsOnly.substring(0, 13);
    }
    return digitsOnly;
  }
}
