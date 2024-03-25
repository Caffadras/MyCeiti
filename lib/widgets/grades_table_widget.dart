import 'package:flutter/material.dart';

import '../models/grades/subject_grades.dart';

class GradesTableWidget extends StatefulWidget {
  final List<SubjectGrades> grades;

  const GradesTableWidget({super.key, required this.grades});

  @override
  State<GradesTableWidget> createState() => _GradesTableWidgetState();
}

class _GradesTableWidgetState extends State<GradesTableWidget> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text("Subject Name")),
        DataColumn(label: Text("Grades")),
      ],
      rows: List<DataRow>.generate(
        widget.grades.length,
        (index) => DataRow(
          cells: [
            DataCell(Text(widget.grades[index].name)),
            DataCell(Text(widget.grades[index].grades)),
          ],
        ),
      ),
    );
  }
}
