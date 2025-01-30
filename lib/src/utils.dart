/// Utils class contains the helper methods that we depends
/// on in the package
abstract class Utils {
  /// Returns the number of days in a given month and year, considering leap years.
  static int daysInMonth(final int monthNum, final int year) {
    // Create a DateTime object for the first day of the next month,
    // then subtract one day to get the last day of the current month.
    final firstDayOfNextMonth = DateTime(year, monthNum + 1, 1);
    final lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    
    return lastDayOfCurrentMonth.day;
  }

}
