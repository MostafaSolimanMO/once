import 'package:flutter_test/flutter_test.dart';
import 'package:once/src/runner/runner.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:once/src/const.dart';

void main() {
  group('OnceRunner', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
      PackageInfo.setMockInitialValues(
        appName: 'once_app',
        packageName: 'com.example.once',
        version: '1.0.0',
        buildNumber: '1',
        buildSignature: 'buildSignature',
      );
    });

    test('runOnce (duration -2) executes callback and caches it', () async {
      bool callbackCalled = false;
      bool fallbackCalled = false;

      final result = await OnceRunner.run(
        key: 'test_once',
        duration: -2,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result, 'callback');
      expect(callbackCalled, true);
      expect(fallbackCalled, false);

      // Second run should call fallback
      callbackCalled = false;
      fallbackCalled = false;

      final result2 = await OnceRunner.run(
        key: 'test_once',
        duration: -2,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result2, 'fallback');
      expect(callbackCalled, false);
      expect(fallbackCalled, true);
    });

    test('run with debugCallback calls callback and ignores cache', () async {
      SharedPreferences.setMockInitialValues({
        'ONCE_PACKAGE_test_debug': 'once',
      });

      bool callbackCalled = false;
      bool fallbackCalled = false;

      final result = await OnceRunner.run(
        key: 'test_debug',
        duration: -2,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
        debugCallback: true,
      );

      expect(result, 'callback');
      expect(callbackCalled, true);
      expect(fallbackCalled, false);
    });

    test('run with debugFallback calls fallback and ignores cache', () async {
      bool callbackCalled = false;
      bool fallbackCalled = false;

      final result = await OnceRunner.run(
        key: 'test_debug_fall',
        duration: -2,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
        debugFallback: true,
      );

      expect(result, 'fallback');
      expect(callbackCalled, false);
      expect(fallbackCalled, true);
    });

    test('runOnNewVersion executes callback when version increases', () async {
      bool callbackCalled = false;
      bool fallbackCalled = false;

      // First run should not execute callback because there is no previous version cache.
      // Wait, let's see what the implementation does:
      // If preferences doesn't contain key, it sets it and returns null.
      final result1 = await OnceRunner.runOnNewVersion(
        key: 'test_version',
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result1, null);
      expect(callbackCalled, false);
      expect(fallbackCalled, false);

      // Now mock a new version
      PackageInfo.setMockInitialValues(
        appName: 'once_app',
        packageName: 'com.example.once',
        version: '1.0.1',
        buildNumber: '1',
        buildSignature: 'buildSignature',
      );

      final result2 = await OnceRunner.runOnNewVersion(
        key: 'test_version',
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result2, 'callback');
      expect(callbackCalled, true);
      expect(fallbackCalled, false);

      // Run again with same version should call fallback
      callbackCalled = false;
      fallbackCalled = false;

      final result3 = await OnceRunner.runOnNewVersion(
        key: 'test_version',
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result3, 'fallback');
      expect(callbackCalled, false);
      expect(fallbackCalled, true);
    });

    test('runOnNewBuild executes callback when build number increases', () async {
      bool callbackCalled = false;
      bool fallbackCalled = false;

      final result1 = await OnceRunner.runOnNewBuild(
        key: 'test_build',
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result1, null);

      // Now mock a new build
      PackageInfo.setMockInitialValues(
        appName: 'once_app',
        packageName: 'com.example.once',
        version: '1.0.0',
        buildNumber: '2',
        buildSignature: 'buildSignature',
      );

      final result2 = await OnceRunner.runOnNewBuild(
        key: 'test_build',
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result2, 'callback');
      expect(callbackCalled, true);

      // Run again with same build should call fallback
      callbackCalled = false;
      fallbackCalled = false;

      final result3 = await OnceRunner.runOnNewBuild(
        key: 'test_build',
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result3, 'fallback');
      expect(fallbackCalled, true);
    });

    test('runOnNewVersion debugCallback ignores cache', () async {
      bool callbackCalled = false;
      final result = await OnceRunner.runOnNewVersion(
        key: 'test_version_debug',
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        debugCallback: true,
      );
      expect(result, 'callback');
      expect(callbackCalled, true);
    });

    test('runOnNewVersion debugFallback ignores cache', () async {
      bool fallbackCalled = false;
      final result = await OnceRunner.runOnNewVersion(
        key: 'test_version_debug_fall',
        callback: () => 'callback',
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
        debugFallback: true,
      );
      expect(result, 'fallback');
      expect(fallbackCalled, true);
    });

    test('runOnNewBuild debugCallback ignores cache', () async {
      bool callbackCalled = false;
      final result = await OnceRunner.runOnNewBuild(
        key: 'test_build_debug',
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        debugCallback: true,
      );
      expect(result, 'callback');
      expect(callbackCalled, true);
    });

    test('runOnNewBuild debugFallback ignores cache', () async {
      bool fallbackCalled = false;
      final result = await OnceRunner.runOnNewBuild(
        key: 'test_build_debug_fall',
        callback: () => 'callback',
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
        debugFallback: true,
      );
      expect(result, 'fallback');
      expect(fallbackCalled, true);
    });

    test('clear and clearAll works', () async {
      await OnceRunner.run(key: 'test_clear_1', duration: -2, callback: () => true);
      await OnceRunner.run(key: 'test_clear_2', duration: -2, callback: () => true);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey('ONCE_PACKAGE_test_clear_1'), true);
      expect(prefs.containsKey('ONCE_PACKAGE_test_clear_2'), true);

      OnceRunner.clear(key: 'test_clear_1');
      // SharedPreferences operations are async, wait a bit or use reload
      await Future.delayed(Duration(milliseconds: 10));
      // In tests setMockInitialValues writes to memory synchronously for basic stuff but native takes a tick
      expect(prefs.containsKey('ONCE_PACKAGE_test_clear_1'), false);
      expect(prefs.containsKey('ONCE_PACKAGE_test_clear_2'), true);

      OnceRunner.clearAll();
      await Future.delayed(Duration(milliseconds: 10));
      expect(prefs.containsKey('ONCE_PACKAGE_test_clear_2'), false);
    });

    test('legacy key migration works', () async {
      // Simulate an old key without the ONCE_PACKAGE_ prefix
      SharedPreferences.setMockInitialValues({
        'legacy_key': 'once',
        'legacy_key_time': '1600000000000',
      });

      final result1 = await OnceRunner.run(
        key: 'legacy_key',
        duration: -2, // Once
        callback: () => 'callback',
        fallback: () => 'fallback',
      );
      expect(result1, 'fallback');

      final result2 = await OnceRunner.run(
        key: 'legacy_key_time',
        duration: Const.day,
        callback: () => 'callback',
        fallback: () => 'fallback',
      );
      expect(result2, 'callback'); // Should run because current time > 1600000000000 + 1 day
      
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey('legacy_key'), false);
      expect(prefs.containsKey('ONCE_PACKAGE_legacy_key'), true);
      expect(prefs.containsKey('legacy_key_time'), false);
      expect(prefs.containsKey('ONCE_PACKAGE_legacy_key_time'), true);
    });

    test('run monthly (duration -1) works', () async {
      bool callbackCalled = false;
      bool fallbackCalled = false;

      // First run
      final result1 = await OnceRunner.run(
        key: 'test_monthly',
        duration: -1,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result1, 'callback');
      expect(callbackCalled, true);
      expect(fallbackCalled, false);

      // Second run immediately
      callbackCalled = false;
      final result2 = await OnceRunner.run(
        key: 'test_monthly',
        duration: -1,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result2, 'fallback');
      expect(fallbackCalled, true);

      // Simulate a month passing by modifying cache
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('ONCE_PACKAGE_test_monthly', '1');

      callbackCalled = false;
      fallbackCalled = false;
      final result3 = await OnceRunner.run(
        key: 'test_monthly',
        duration: -1,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result3, 'callback');
      expect(callbackCalled, true);
    });

    test('run on start of day (duration -3) works', () async {
      bool callbackCalled = false;
      bool fallbackCalled = false;

      final result1 = await OnceRunner.run(
        key: 'test_day_start',
        duration: -3,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );
      expect(result1, 'callback');

      callbackCalled = false;
      fallbackCalled = false;
      final result2 = await OnceRunner.run(
        key: 'test_day_start',
        duration: -3,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );
      expect(result2, 'fallback');

      // Simulate different day
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('ONCE_PACKAGE_test_day_start', '-1');

      callbackCalled = false;
      final result3 = await OnceRunner.run(
        key: 'test_day_start',
        duration: -3,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );
      expect(result3, 'callback');
    });

    test('run on start of month (duration >0 <12) works', () async {
      bool callbackCalled = false;
      bool fallbackCalled = false;
      final currentMonth = DateTime.now().month;

      final result1 = await OnceRunner.run(
        key: 'test_month_start',
        duration: currentMonth,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );
      expect(result1, 'callback');

      callbackCalled = false;
      fallbackCalled = false;
      final result2 = await OnceRunner.run(
        key: 'test_month_start',
        duration: currentMonth,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );
      expect(result2, 'fallback');

      // Simulate different month
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('ONCE_PACKAGE_test_month_start', '-1');

      callbackCalled = false;
      final result3 = await OnceRunner.run(
        key: 'test_month_start',
        duration: currentMonth,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );
      expect(result3, 'callback');
    });

    test('run custom duration works', () async {
      bool callbackCalled = false;
      bool fallbackCalled = false;

      final result1 = await OnceRunner.run(
        key: 'test_custom',
        duration: 1000, // 1 second
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );
      expect(result1, 'callback');

      callbackCalled = false;
      fallbackCalled = false;
      final result2 = await OnceRunner.run(
        key: 'test_custom',
        duration: 1000,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );
      expect(result2, 'fallback');

      // Wait for 1.1 seconds
      await Future.delayed(Duration(milliseconds: 1100));

      callbackCalled = false;
      final result3 = await OnceRunner.run(
        key: 'test_custom',
        duration: 1000,
        callback: () {
          callbackCalled = true;
          return 'callback';
        },
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );
      expect(result3, 'callback');
    });
  });
}
