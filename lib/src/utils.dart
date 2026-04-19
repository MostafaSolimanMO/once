/// Utils class contains the helper methods that we depends
/// on in the package
abstract class Utils {
  /// Returns the number of days in a given month and year, considering leap years.
  static int daysInMonth(final int monthNum, final int year) {
    return DateTime(year, monthNum + 1, 0).day;
  }

}
