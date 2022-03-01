import 'package:once/src/const.dart';
import 'package:once/src/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnceRunner {
  static Future<T?> run<T>({
    required String key,
    required int duration,
    required T? Function() callback,
    T? Function()? fallback,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;

    /// Run only Once
    if (duration == -2 && !preferences.containsKey(key)) {
      preferences.setString(key, 'once');
      return callback.call();
    }

    /// Run only Monthly
    if (duration == -1) {
      final monthMilliseconds =
          (Utils.daysInMonth(currentMonth, currentYear) * Const.day);
      if (preferences.containsKey(key)) {
        final savedTime = preferences.getInt(key)!;

        if (savedTime <= currentTime) {
          preferences.setInt(
            key,
            savedTime + monthMilliseconds,
          );
          return callback.call();
        }
        return fallback?.call();
      }

      preferences.setInt(
        key,
        currentTime + monthMilliseconds,
      );
      return callback.call();
    }

    /// Run only on every start of Month
    if (duration > 0 && duration < 12) {
      if (preferences.containsKey(key)) {
        final savedMonth = preferences.getInt(key)!;

        if (savedMonth != duration) {
          preferences.setInt(key, duration);
          return callback.call();
        }
        return fallback?.call();
      }
      preferences.setInt(key, duration);
      return callback.call();
    }

    /// Run any other once options
    if (duration != -2 && preferences.containsKey(key)) {
      final int savedTime = preferences.getInt(key)!;
      final difference = currentTime - savedTime;

      if (difference > duration) {
        preferences.setInt(key, currentTime);
        return callback.call();
      }

      return fallback?.call();
    }

    preferences.setInt(key, currentTime);
    return callback.call();
  }

  /// Runs only on every new app number version
  static Future<T?> runOnNewVersion<T>({
    required T? Function() callback,
    T? Function()? fallback,
  }) async {
    const key = 'ON_NEW_VERSION';
    final preferences = await SharedPreferences.getInstance();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    if (preferences.containsKey(key)) {
      final savedVersion = preferences.getString(key)!.replaceAll(".", "");
      String existingVersion = currentVersion.replaceAll(".", "");

      if (num.parse(existingVersion) > num.parse(savedVersion)) {
        preferences.setString(key, currentVersion);
        return callback.call();
      }
      return fallback?.call();
    }
    preferences.setString(key, currentVersion);
    return callback.call();
  }
}
