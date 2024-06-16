import 'package:flutter/material.dart';
import 'package:my_ceiti/models/grades/annual_grades_model.dart';

import '../../../models/grades/semester_model.dart';

class YearGradesWidget extends StatefulWidget {
  final SemesterModel semesterModel;

  const YearGradesWidget({super.key, required this.semesterModel});

  @override
  State<YearGradesWidget> createState() => _YearGradesWidgetState();
}

class _YearGradesWidgetState extends State<YearGradesWidget> {
  static const double _listTileHeight = 90;
  static const double _gradeSectionWidth = 65;

  @override
  Widget build(BuildContext context) {
    List<AnnualGradesModel> grades = widget.semesterModel.annualGrades;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: grades.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 3),
                child: _buildCard(grades[index], context),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(AnnualGradesModel annualGrades, BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: _buildCardWithInkWell(annualGrades, context),
    );
  }

  Widget _buildCardWithInkWell(
      AnnualGradesModel annualGrades, BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
          height: _listTileHeight,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      annualGrades.subject ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Wrap(
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 4.0, // gap between lines
                      children: _buildChips(annualGrades),
                    ),
                  ],
                ),
              ),
              _buildGradeSection(annualGrades.annualGrade, context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChips(AnnualGradesModel annualGrades) {
    List<Widget> chips = [];

    if (annualGrades.firstSemesterGrade != null) {
      chips.add(Chip(
        padding: EdgeInsets.all(0.0),
        label: Text('Sem I: ${annualGrades.firstSemesterGrade}',
            style: TextStyle(fontSize: 12)),
      ));
    }

    if (annualGrades.secondSemesterGrade != null) {
      chips.add(Chip(
        padding: EdgeInsets.all(0.0),
        label: Text('Sem II: ${annualGrades.secondSemesterGrade}',
            style: TextStyle(fontSize: 12)),
      ));
    }

    // if (annualGrades.annualGrade != null) {
    //   chips.add(Chip(
    //     padding: EdgeInsets.all(0.0),
    //     label: Text('Annual: ${annualGrades.annualGrade}', style: TextStyle(fontSize: 12)),
    //   ));
    // }

    if (annualGrades.examGrade != null) {
      chips.add(Chip(
        padding: EdgeInsets.all(0.0),
        label: Text('Exam: ${annualGrades.examGrade}',
            style: TextStyle(fontSize: 12)),
      ));
    }

    return chips;
  }

  Widget _buildGradeSection(String? grade, BuildContext context) {
    return Container(
      height: double.infinity,
      width: _gradeSectionWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(left: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            grade?.substring(0, 4) ?? "- - -",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text("Annual")
        ],
      ),
    );
  }
}
