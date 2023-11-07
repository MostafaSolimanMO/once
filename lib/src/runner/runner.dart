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
    /// if the key itself it exists, add the same value
    /// to the key with the prefix
    if (preferences.containsKey(key)) {
      if (!key.contains(_keyPrefix)) {
        if (preferences.get(key) == 'once') {
          preferences.remove(key);
          key = '$_keyPrefix$key';
          preferences.setString(key, 'once');
        } else {
          final currentValue = preferences.get(key);
          preferences.remove(key);
          key = '$_keyPrefix$key';
          preferences.setString(key, currentValue.toString());
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
        final savedTime = int.parse(preferences.get(key).toString());

        if (savedTime <= currentTime) {
          preferences.setString(
            key,
            (savedTime + monthMilliseconds).toString(),
          );
          return callback.call();
        }
        return fallback?.call();
      }

      preferences.setString(
        key,
        (currentTime + monthMilliseconds).toString(),
      );
      return callback.call();
    }

    /// Run only on every start of day
    if (duration == -3) {
      if (preferences.containsKey(key)) {
        final savedWeekday = int.parse(preferences.get(key).toString());

        if (savedWeekday != currentWeekday) {
          preferences.setString(key, currentWeekday.toString());
          return callback.call();
        }
        return fallback?.call();
      }
      preferences.setString(key, currentWeekday.toString());
      return callback.call();
    }

    /// Run only on every start of Month
    if (duration > 0 && duration < 12) {
      if (preferences.containsKey(key)) {
        final savedMonth = int.parse(preferences.get(key).toString());

        if (savedMonth != duration) {
          preferences.setString(key, duration.toString());
          return callback.call();
        }
        return fallback?.call();
      }
      preferences.setString(key, duration.toString());
      return callback.call();
    }

    /// Run any other once options
    if (duration != -2 && preferences.containsKey(key)) {
      final int savedTime = int.parse(preferences.get(key).toString());
      final difference = currentTime - savedTime;

      if (difference > duration) {
        preferences.setString(key, currentTime.toString());
        return callback.call();
      }

      return fallback?.call();
    }

    preferences.setString(key, currentTime.toString());
    return callback.call();
  }

  /// Runs only on every new app number version
  static Future<T?> runOnNewVersion<T>({
    /// Key used to runOnEveryNewVersion in multiple places
    /// without key it will run only once
    String? key,
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

    final onceKey = 'ON_NEW_VERSION_${key ?? 'once_key'}';
    final preferences = await SharedPreferences.getInstance();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    if (preferences.containsKey(onceKey)) {
      String savedVersion = preferences.get(onceKey).toString();
      savedVersion = savedVersion.replaceAll(RegExp(r'[^\d]+'), '');

      String existingVersion = currentVersion.replaceAll(RegExp(r'[^\d]+'), '');

      if (num.parse(existingVersion) > num.parse(savedVersion)) {
        preferences.setString(onceKey, currentVersion);
        return callback.call();
      }
      return fallback?.call();
    }
    preferences.setString(onceKey, currentVersion);
    return null;
  }

  /// Runs only on every app build number change
  static Future<T?> runOnNewBuild<T>({
    /// Key used to runOnEveryNewBuild in multiple places
    /// without key it will run only once
    String? key,
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

    final buildKey = 'ON_NEW_BUILD_${key ?? 'build_key'}';
    final preferences = await SharedPreferences.getInstance();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentBuild = packageInfo.buildNumber;

    if (preferences.containsKey(buildKey)) {
      final savedBuild = preferences.get(buildKey).toString();
      String existingBuild = currentBuild.replaceAll(RegExp(r'[^\d]+'), '');

      if (num.parse(existingBuild) > num.parse(savedBuild)) {
        preferences.setString(buildKey, currentBuild);
        return callback.call();
      }
      return fallback?.call();
    }
    preferences.setString(buildKey, currentBuild);
    return null;
  }

  /// Clear cache for a specific [key]
  static void clear({
    required String key,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove('$_keyPrefix$key');
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
