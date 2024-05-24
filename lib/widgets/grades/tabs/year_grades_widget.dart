import 'package:flutter/material.dart';

import '../../../models/grades/semester_model.dart';

class YearGradesWidget extends StatefulWidget {
  final SemesterModel semesterModel;

  const YearGradesWidget({super.key, required this.semesterModel});

  @override
  State<YearGradesWidget> createState() => _YearGradesWidgetState();
}

class _YearGradesWidgetState extends State<YearGradesWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("Year Grades");
  }
}
