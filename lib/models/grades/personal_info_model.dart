class PersonalInfoModel {
  final String? firstName;
  final String? lastName;
  final String? year;
  final int? numYear;

  PersonalInfoModel(this.firstName, this.lastName, this.year, this.numYear);

  @override
  String toString() {
    return 'PersonalInfoModel{firstName: $firstName, lastName: $lastName, year: $year}';
  }
}