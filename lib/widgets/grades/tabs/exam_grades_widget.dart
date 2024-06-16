import 'package:flutter/material.dart';
import 'package:my_ceiti/models/grades/exam_grades_model.dart';

import '../../../models/grades/semester_model.dart';

class ExamGradesWidget extends StatefulWidget {
  final SemesterModel semesterModel;

  const ExamGradesWidget({super.key, required this.semesterModel});

  @override
  State<ExamGradesWidget> createState() => _ExamGradesWidgetState();
}

class _ExamGradesWidgetState extends State<ExamGradesWidget> {
  static const double _listTileHeight = 70;
  static const double _gradeSectionWidth = 65;

  @override
  Widget build(BuildContext context) {
    List<ExamGradesModel> grades = widget.semesterModel.examGrades;
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

  Widget _buildCard(ExamGradesModel examGrades, BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: _buildCardWithInkWell(examGrades, context),
    );
  }

  Widget _buildCardWithInkWell(
      ExamGradesModel examGrades, BuildContext context) {
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
                      //todo
                      examGrades.fullSubjectName ?? "",

                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              _buildGradeSection(examGrades.grade, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradeSection(
      double? grade, BuildContext context) {
    return Container(
      height: double.infinity,
      width: _gradeSectionWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(left: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            grade?.toStringAsPrecision(3) ?? "- - -",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
