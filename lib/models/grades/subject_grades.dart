class SubjectGrades{
  String name;
  String gradesAndAbsences;
  List<int> grades;
  List<String> absences;

  SubjectGrades(this.name, this.gradesAndAbsences, this.grades, this.absences);

  @override
  String toString() {
    return 'SubjectGrades{name: $name, grades: $gradesAndAbsences}';
  }
}