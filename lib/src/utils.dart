/// Utils class contains the helper methods that we depends
/// on in the package
abstract class Utils {
  /// Return month days with accuracy in it, taking the current month and year
  /// considering the leap year
  static int daysInMonth(final int monthNumber, final int year) {
    List<int> daysPerMonth = List.filled(12, 0);
    daysPerMonth[0] = 31;
    daysPerMonth[2] = 31;
    daysPerMonth[3] = 30;
    daysPerMonth[4] = 31;
    daysPerMonth[5] = 30;
    daysPerMonth[6] = 31;
    daysPerMonth[7] = 31;
    daysPerMonth[8] = 30;
    daysPerMonth[9] = 31;
    daysPerMonth[10] = 30;
    daysPerMonth[11] = 31;

    if (_isLeapYear(year) == true) {
      daysPerMonth[1] = 29;
    } else {
      daysPerMonth[1] = 28;
    }

    return daysPerMonth[monthNumber - 1];
  }

  static bool _isLeapYear(int year) {
    bool leapYear = false;
    bool isNonLeapCentury = ((year % 100 == 0) && (year % 400 != 0));
    if (isNonLeapCentury == true) {
      leapYear = false;
    } else if (year % 4 == 0) {
      leapYear = true;
    }

    return leapYear;
  }
}
