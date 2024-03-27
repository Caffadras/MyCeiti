class AbsencesModel{
  final int total;
  final int sick;
  final int motivated;
  final int unmotivated;

  AbsencesModel(this.total, this.sick, this.motivated, this.unmotivated);

  @override
  String toString() {
    return 'AbsencesModel{total: $total, sick: $sick, motivated: $motivated, unmotivated: $unmotivated}';
  }
}