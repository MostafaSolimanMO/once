import 'package:flutter/foundation.dart';
import 'package:once/src/const.dart';
import 'package:once/src/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _keyPrefix = 'ONCE_PACKAGE_';

abstract class OnceRunner {
  static Future<T?> run<T>({
    required String key,
    required int duration,
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final currentMonth = DateTime.now().month;
    final currentWeekday = DateTime.now().weekday;
    final currentYear = DateTime.now().year;

    /// if the debug mode is enabled, we will not check
    /// the cache and run the callback function
    if (debugCallback && kDebugMode) {
      return callback.call();
    }

    /// if the debug mode is enabled, we will not check
    /// the cache and run the fallback function
    if (debugFallback && kDebugMode) {
      return fallback?.call();
    }

    /// Add ONCE_PREFIX to the key if it doesn't exist and
    /// if the key itself it exists, add the sane value
    /// to the key with the prefix
    if (preferences.containsKey(key)) {
      if (!key.contains(_keyPrefix)) {
        if (preferences.get(key) == 'once') {
          preferences.remove(key);
          key = '$_keyPrefix$key';
          preferences.setString(key, 'once');
        } else {
          int? currentValue = preferences.getInt(key);
          preferences.remove(key);
          key = '$_keyPrefix$key';
          preferences.setInt(key, currentValue!);
        }
      }
    } else {
      key = '$_keyPrefix$key';
    }

    /// Run only Once
    if (duration == -2 && !preferences.containsKey(key)) {
      preferences.setString(key, 'once');
      return callback.call();
    } else if (duration == -2 && preferences.containsKey(key)) {
      return fallback?.call();
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

    /// Run only on every start of day
    if (duration == -3) {
      if (preferences.containsKey(key)) {
        final savedWeekday = preferences.getInt(key)!;

        if (savedWeekday != currentWeekday) {
          preferences.setInt(key, currentWeekday);
          return callback.call();
        }
        return fallback?.call();
      }
      preferences.setInt(key, currentWeekday);
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
    bool debugCallback = false,
    bool debugFallback = false,
  }) async {
    /// if the debug mode is enabled, we will not check
    /// the cache and run the callback function
    if (debugCallback && kDebugMode) {
      return callback.call();
    }

    /// if the debug mode is enabled, we will not check
    /// the cache and run the fallback function
    if (debugFallback && kDebugMode) {
      return fallback?.call();
    }

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

  /// Clear cache for a specific [key]
  static void clear({
    required String key,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  /// Clear cache for all Once package keys
  static void clearAll() async {
    final preferences = await SharedPreferences.getInstance();
    for (final key in preferences.getKeys()) {
      if (key.contains(_keyPrefix)) {
        preferences.remove(key);
      }
    }
  }
}
