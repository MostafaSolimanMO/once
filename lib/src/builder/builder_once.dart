import 'package:flutter/widgets.dart';
import 'package:once/once.dart';
import 'package:once/src/builder/builder.dart';
import 'package:once/src/const.dart';
import 'package:once/src/runner/runner.dart';

abstract class OnceWidget {
  /// A generic callback that runs on an every new version
  static FutureBuilder<Widget?> showOnEveryNewVersion<T>({
    /// Key used to runOnEveryNewVersion in multiple places
    /// without key it will run only once
    String? key,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runOnEveryNewVersion(
        key: key,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every once
  static FutureBuilder<Widget?> showOnce<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runOnce(
        key,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every 12 hours
  static FutureBuilder<Widget?> showEvery12Hours<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runEvery12Hours(
        key,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every hours
  static FutureBuilder<Widget?> showHourly<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runHourly(
        key,
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
  static FutureBuilder<Widget?> showDaily<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runDaily(
        key,
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
  static FutureBuilder<Widget?> showOnNewDay<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      Once.runOnNewDay(
        key,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every week
  static FutureBuilder<Widget?> showWeekly<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      OnceRunner.run(
        key: key,
        duration: Const.week,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every new month
  static FutureBuilder<Widget?> showMonthly<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      OnceRunner.run(
        key: key,
        duration: -1,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs every month
  static FutureBuilder<Widget?> showOnNewMonth<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      OnceRunner.run(
        key: key,
        duration: DateTime.now().month,
        callback: builder,
        debugCallback: debugCallback,
        debugFallback: debugFallback,
      ),
      fallback,
    );
  }

  /// A generic callback that runs yearly
  static FutureBuilder<Widget?> showYearly<T>(
    String key, {
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      OnceRunner.run(
        key: key,
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
  static FutureBuilder<Widget?> showCustom<T>(
    String key, {
    required Duration duration,
    required Widget? Function() builder,
    Widget? Function()? fallback,
    bool debugCallback = false,
    bool debugFallback = false,
  }) {
    return OnceBuilder.build(
      OnceRunner.run(
        key: key,
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
