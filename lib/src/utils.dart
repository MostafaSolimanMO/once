/// Utils class contains the helper methods that we depends
/// on in the package
abstract class Utils {
  /// Return month days with accuracy in it, taking the current month and year
  /// considering the leap year
  static int daysInMonth(final int monthNum, final int year) {
    List<int> monthLength = List.filled(12, 0);
    monthLength[0] = 31;
    monthLength[2] = 31;
    monthLength[3] = 30;
    monthLength[4] = 31;
    monthLength[5] = 30;
    monthLength[6] = 31;
    monthLength[7] = 31;
    monthLength[8] = 30;
    monthLength[9] = 31;
    monthLength[10] = 30;
    monthLength[11] = 31;

    if (_leapYear(year) == true) {
      monthLength[1] = 29;
    } else {
      monthLength[1] = 28;
    }

    return monthLength[monthNum - 1];
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
