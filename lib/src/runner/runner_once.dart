import 'package:once/src/const.dart';
import 'package:once/src/runner/runner.dart';

abstract class Once {
  static Future<T?> runOnce<T>(
    String key, {
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.run(
      key: key,
      duration: -2,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// A generic callback that runs every 12 hours
  static Future<T?> runEvery12Hours<T>(
    String key, {
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.run(
      key: key,
      duration: Const.day ~/ 2,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// A generic callback that runs on an hourly basis
  static Future<T?> runHourly<T>(
    String key, {
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.run(
      key: key,
      duration: Const.day ~/ 24,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// A generic callback that runs on a daily basis
  /// The day here means you run the function at 3:00 AM. So, Day means
  /// the next 3:00 AM
  static Future<T?> runDaily<T>(
    String key, {
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.run(
      key: key,
      duration: Const.day,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// A generic callback that runs on every new day
  /// The day here means you run the function at 3:00 AM. So, Day means
  /// the next 12:00 AM
  static Future<T?> runOnNewDay<T>(
    String key, {
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.run(
      key: key,
      duration: -3,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// A generic callback that runs on an weekly basis
  static Future<T?> runWeekly<T>(
    String key, {
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.run(
      key: key,
      duration: Const.week,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// A generic callback that runs on an monthly basis
  static Future<T?> runMonthly<T>(
    String key, {
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.run(
      key: key,
      duration: -1,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// A generic callback that runs at the beginning of each month
  static Future<T?> runOnNewMonth<T>(
    String key, {
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.run(
      key: key,
      duration: DateTime.now().month,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// A generic callback that runs on an yearly basis
  static Future<T?> runYearly<T>(
    String key, {
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.run(
      key: key,
      duration: Const.year,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// A generic callback that runs on a custom basis set by the user/developer
  /// by referencing a period [duration]
  static Future<T?> runCustom<T>(
    String key, {
    required T? Function() callback,
    T? Function()? fallback,
    required Duration duration,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.run(
      key: key,
      duration: duration.inMilliseconds,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// A generic callback that runs each time the app version changes
  static Future<T?> runOnEveryNewVersion<T>({
    /// Key used to runOnEveryNewVersion in multiple places
    /// without key it will run only once
    String? key,
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.runOnNewVersion(
      key: key,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// A generic callback that runs each time the app build number changes
  static Future<T?> runOnEveryNewBuild<T>({
    /// Key used to runOnEveryNewBuild in multiple places
    /// without key it will run only once
    String? key,
    required T? Function() callback,
    T? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceRunner.runOnNewBuild(
      key: key,
      callback: callback,
      fallback: fallback,
      debugCallback: debugCallback,
      debugFallback: debugFallback,
    );
  }

  /// Clear OnceBuilder cache for a specific [key]
  static void clear({
    required String key,
  }) {
    OnceRunner.clear(key: key);
  }

  /// Clear OnceBuilder cache for all keys
  static void clearAll() {
    OnceRunner.clearAll();
  }
}
