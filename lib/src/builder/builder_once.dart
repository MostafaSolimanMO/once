import 'package:flutter/widgets.dart';
import 'package:once/once.dart';
import 'package:once/src/builder/builder.dart';
import 'package:once/src/const.dart';
import 'package:once/src/runner/runner.dart';

abstract class OnceWidget {
  /// A generic callback that runs on an every new version
  static Widget showOnEveryNewVersion<T>(
    /// Key used to runOnEveryNewVersion in multiple places
    /// without key it will run only once
    onceKey, {
    Key? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      Once.runOnEveryNewVersion(
        key: onceKey,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs on an every new build number
  static Widget showOnEveryNewBuild<T>(
    /// Key used to runOnEveryNewBuild in multiple places
    /// without key it will run only once
    onceKey, {
    Key? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      Once.runOnEveryNewBuild(
        key: onceKey,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every once
  static Widget showOnce<T>(
    String onceKey, {
    Key? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      Once.runOnce(
        onceKey,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every 12 hours
  static Widget showEvery12Hours<T>(
    onceKey, {
    Key? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      Once.runEvery12Hours(
        onceKey,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs after every hour
  static Widget showHourly<T>(
    onceKey, {
    Key? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      Once.runHourly(
        onceKey,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs on a daily basis
  /// The day here means you run the function at 3:00 AM. So, Day means
  /// the next 3:00 AM
  static Widget showDaily<T>(
    onceKey, {
    Key? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      Once.runDaily(
        onceKey,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs on every new day
  /// The day here means you run the function at 3:00 AM. So, Day means
  /// the next 12:00 AM
  static Widget showOnNewDay<T>(
    onceKey, {
    Key? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      Once.runOnNewDay(
        onceKey,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every week
  static Widget showWeekly<T>(
    onceKey, {
    Key? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      OnceRunner.run(
        key: onceKey,
        duration: Const.week,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every new month
  static Widget showMonthly<T>(
    onceKey, {
    Key? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      OnceRunner.run(
        key: onceKey,
        duration: -1,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every month
  static Widget showOnNewMonth<T>(
    onceKey, {
    Key? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      OnceRunner.run(
        key: onceKey,
        duration: DateTime.now().month,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs yearly
  static Widget showYearly<T>(
    onceKey, {
    Key? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      OnceRunner.run(
        key: onceKey,
        duration: Const.year,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs on a custom basis set by the user/developer
  /// by referencing a period [duration]
  static Widget showCustom<T>(
    onceKey, {
    Key? key,
    required Duration duration,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      OnceRunner.run(
        key: onceKey,
        duration: duration.inMilliseconds,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
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
