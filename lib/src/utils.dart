abstract class Utils {
  /// Returns the number of days in a given month and year, considering leap years.
  static int daysInMonth(final int monthNum, final int year) {
    // Create a DateTime object for the first day of the next month,
    // then subtract one day to get the last day of the current month.
    final firstDayOfNextMonth = DateTime(year, monthNum + 1, 1);
    final lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    
    return lastDayOfCurrentMonth.day;
  }

  /// Checks if a given year is a leap year.
  static bool _leapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }
}
