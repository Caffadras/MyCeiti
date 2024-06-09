class SubjectGradesModel{
  String name;
  String gradesAndAbsences;
  List<int> grades;
  List<String> absences;

  SubjectGradesModel(this.name, this.gradesAndAbsences, this.grades, this.absences);

  @override
  String toString() {
    return 'SubjectGradesModel{name: $name, grades: $gradesAndAbsences}';
  }
}