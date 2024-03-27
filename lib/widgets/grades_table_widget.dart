import 'package:flutter/material.dart';
import 'package:my_ceiti/models/grades/semester_model.dart';

import '../models/grades/subject_grades.dart';

class GradesTableWidget extends StatefulWidget {
  final SemesterModel semesterModel;

  const GradesTableWidget({super.key, required this.semesterModel});

  @override
  State<GradesTableWidget> createState() => _GradesTableWidgetState();
}

class _GradesTableWidgetState extends State<GradesTableWidget> {
  @override
  Widget build(BuildContext context) {
    List<SubjectGrades> grades = widget.semesterModel.subjectGrades;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(label: Text("Subject Name")),
          DataColumn(label: Text("Grades")),
        ],
        rows: List<DataRow>.generate(
          grades.length,
          (index) => DataRow(
            cells: [
              DataCell(Text(grades[index].name)),
              DataCell(Text(grades[index].grades)),
            ],
          ),
        ),
      ),
    );
  }
}
