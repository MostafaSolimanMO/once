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
    String? onceKey, {
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
    String? onceKey, {
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
    String onceKey, {
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
    String onceKey, {
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
    String onceKey, {
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
    String onceKey, {
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
    String onceKey, {
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
    String onceKey, {
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
    String onceKey, {
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
    String onceKey, {
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
    String onceKey, {
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

  /// A generic builder that keeps rendering until the user dismisses it.
  /// The [builder] receives a `dismiss` callback; calling it persists a
  /// 'done' marker so that subsequent builds with the same [onceKey]
  /// render [fallback] instead of [builder].
  static Widget showUntilDone(
    String onceKey, {
    Key? key,
    required Widget? Function(VoidCallback dismiss) builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      key,
      OnceRunner.runUntilDone(
        key: onceKey,
        callback: builder,
        fallback: fallback,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// Marks the [key] used by [showUntilDone] as done, so that subsequent
  /// builds render their `fallback` instead of the original builder.
  static Future<void> markDone({required String key}) {
    return OnceRunner.markDone(key: key);
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
