

class DateTimeService{

  bool isFirstSemester({DateTime? date}) {
    date ??= DateTime.now();

    // First semester starts on September 1
    DateTime firstSemesterStart = DateTime(date.year, 9, 1);
    // Second semester starts on January 1 of the current year
    DateTime secondSemesterStart = DateTime(date.year, 1, 1);
    // Next year's January 1
    DateTime nextYearSecondSemesterStart = DateTime(date.year + 1, 1, 1);

    // If the date is before September 1 and after January 1 of the current year
    if (date.isBefore(firstSemesterStart) && date.isAfter(secondSemesterStart.subtract(Duration(days: 1)))) {
      return false;
    }
    // If the date is after September 1 of the current year
    else if (date.isAfter(firstSemesterStart.subtract(Duration(days: 1)))) {
      return true;
    }
    // If the date is between January 1 and September 1 of the next year
    else if (date.isAfter(secondSemesterStart.subtract(Duration(days: 1))) && date.isBefore(nextYearSecondSemesterStart)) {
      return false;
    }

    return false;
  }

}