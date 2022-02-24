import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Once Durations in millisecands
const _year = _day * 365;
const _week = _day * 7;
const _day = 86400000;

abstract class Once {
  static Future<void> _run({
    required String key,
    required int duration,
    required void Function() callback,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;

    /// Run only Once
    if (duration == 0 && !prefs.containsKey(key)) {
      prefs.setString(key, key);
      return callback.call();
    }

    /// Run only Monthly
    if (duration == -1) {
      final monthMillisec = (_daysInMonth(currentMonth, currentYear) * _day);
      if (prefs.containsKey(key)) {
        final savedTime = prefs.getInt(key)!;

        if (savedTime <= currentTime) {
          prefs.setInt(
            key,
            savedTime + monthMillisec,
          );
          return callback.call();
        }
        return;
      }

      prefs.setInt(
        key,
        currentTime + monthMillisec,
      );
      return callback.call();
    }

    /// Run only on every start of Month
    if (duration > 0 && duration < 12) {
      if (prefs.containsKey(key)) {
        final savedMonth = prefs.getInt(key)!;

        if (savedMonth != duration) {
          prefs.setInt(key, duration);
          return callback.call();
        }
      }
      prefs.setInt(key, duration);
      return callback.call();
    }

    /// Run any other once options
    if (prefs.containsKey(key)) {
      final savedTime = prefs.getInt(key)!;
      final diffrance = currentTime - savedTime;

      if (diffrance > duration) return callback.call();
    }
    prefs.setInt(key, currentTime);
    return callback.call();
  }

  static Future<void> _runOnNewVersion({
    required void Function() callback,
  }) async {
    const key = 'ON_NEW_VERSION';
    final prefs = await SharedPreferences.getInstance();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    if (prefs.containsKey(key)) {
      final savedVersion = prefs.getString(key)!.replaceAll(".", "");
      String existingVersion = currentVersion.replaceAll(".", "");

      if (num.parse(savedVersion) < num.parse(existingVersion)) {
        prefs.setString(key, currentVersion);
        return callback.call();
      }
    }
    prefs.setString(key, currentVersion);
    return callback.call();
  }

  static void runOnce(
    String key,
    void Function() callback,
  ) =>
      _run(
        key: key,
        duration: 0,
        callback: callback,
      );

  static void runEvery12Hours(
    String key,
    void Function() callback,
  ) =>
      _run(
        key: key,
        duration: int.parse("${_day / 2}"),
        callback: callback,
      );

  static void runHourly(
    String key,
    void Function() callback,
  ) =>
      _run(
        key: key,
        duration: int.parse("${_day / 24}"),
        callback: callback,
      );

  static void runDaily(
    String key,
    void Function() callback,
  ) =>
      _run(
        key: key,
        duration: _day,
        callback: callback,
      );

  static void runWeekly(
    String key,
    void Function() callback,
  ) =>
      _run(
        key: key,
        duration: _week,
        callback: callback,
      );

  static void runMonthly(
    String key,
    void Function() callback,
  ) =>
      _run(
        key: key,
        duration: -1,
        callback: callback,
      );

  static void runOnNewMonth(
    String key,
    void Function() callback,
  ) =>
      _run(
        key: key,
        duration: DateTime.now().month,
        callback: callback,
      );

  static void runYearly(
    String key,
    void Function() callback,
  ) =>
      _run(
        key: key,
        duration: _year,
        callback: callback,
      );

  static void runCustom(
    String key,
    void Function() callback, {
    required Duration duration,
  }) =>
      _run(
        key: key,
        duration: duration.inMilliseconds,
        callback: callback,
      );

  static void runOnEveryNewVersion(
    void Function() callback,
  ) =>
      _runOnNewVersion(
        callback: callback,
      );
}

int _daysInMonth(final int monthNum, final int _year) {
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

  if (_leapYear(_year) == true) {
    monthLength[1] = 29;
  } else {
    monthLength[1] = 28;
  }

  return monthLength[monthNum - 1];
}

bool _leapYear(int _year) {
  bool leapYear = false;
  bool leap = ((_year % 100 == 0) && (_year % 400 != 0));
  if (leap == true) {
    leapYear = false;
  } else if (_year % 4 == 0) {
    leapYear = true;
  }

  return leapYear;
}