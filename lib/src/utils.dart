/// Utils class contains the helper methods that we depends
/// on in the package
abstract class Utils {
  /// Return month days with accuracy in it, taking the current month and year
  /// considering the leap year
  static int daysInMonth(final int monthNum, final int year) {
    RangeError.checkValueInInterval(monthNum, 1, 12, 'monthNum');

    // Create a DateTime object for the first day of the next month,
    // then subtract one day to get the last day of the current month.
    final firstDayOfNextMonth = DateTime(year, monthNum + 1, 1);
    final lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfCurrentMonth.day;
  }

  static bool _leapYear(int year) {
    bool leapYear = false;
    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true) {
      leapYear = false;
    } else if (year % 4 == 0) {
      leapYear = true;
    }

    return leapYear;
  }
}
