import 'package:flutter/material.dart';

import '../../../models/grades/semester_model.dart';

class ExamGradesWidget extends StatefulWidget {
  final SemesterModel semesterModel;

  const ExamGradesWidget({super.key, required this.semesterModel});

  @override
  State<ExamGradesWidget> createState() => _ExamGradesWidgetState();
}

class _ExamGradesWidgetState extends State<ExamGradesWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("Exam Grades");
  }
}
