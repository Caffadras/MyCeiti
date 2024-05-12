import 'package:flutter/material.dart';
import 'package:my_ceiti/models/grades/semester_model.dart';

import '../../models/grades/subject_grades.dart';

class GradesTableWidget extends StatefulWidget {
  final SemesterModel semesterModel;

  const GradesTableWidget({super.key, required this.semesterModel});

  @override
  State<GradesTableWidget> createState() => _GradesTableWidgetState();
}

class _GradesTableWidgetState extends State<GradesTableWidget> {
  static const double _listTileHeight = 80;

  @override
  Widget build(BuildContext context) {
    List<SubjectGrades> grades = widget.semesterModel.subjectGrades;
    return Expanded(
      child: ListView.builder(
        itemCount: grades.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 3),
            child: _buildCard(index, grades[index], context),
          );
        },
      ),
    );
  }

  Widget _buildCard(
      int index, SubjectGrades subjectGrades, BuildContext context) {
    return Card(
      // clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: _buildCardWithInkWell(subjectGrades, context, index),
    );
  }

  //todo remove index param
  Widget _buildCardWithInkWell(
      SubjectGrades subjectGrades, BuildContext context, int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.all(5),
          height: _listTileHeight,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subjectGrades.name,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      subjectGrades.grades.join(", "),
                    )
                  ],
                ),
              ),
              _buildAvgGradeSection(subjectGrades, index, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvgGradeSection(
      SubjectGrades subjectGrades, int index, BuildContext context) {
    return Container(
      height: double.infinity,

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
            _average(subjectGrades.grades).toStringAsPrecision(3),
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  double _average(List<int> numbers){
  if (numbers.isEmpty) {
    return 0;
  }
  return numbers.reduce((a, b) => a + b) / numbers.length;
  }
}
