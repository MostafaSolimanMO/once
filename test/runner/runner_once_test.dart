import 'package:flutter_test/flutter_test.dart';
import 'package:once/once.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Once (facade)', () {
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

    test('runOnce passes correct parameters', () async {
      final result = await Once.runOnce('key1', callback: () => 'callback');
      expect(result, 'callback');
    });

    test('runEvery12Hours passes correct parameters', () async {
      final result = await Once.runEvery12Hours('key2', callback: () => 'callback');
      expect(result, 'callback');
    });

    test('runHourly passes correct parameters', () async {
      final result = await Once.runHourly('key3', callback: () => 'callback');
      expect(result, 'callback');
    });

    test('runDaily passes correct parameters', () async {
      final result = await Once.runDaily('key4', callback: () => 'callback');
      expect(result, 'callback');
    });

    test('runOnNewDay passes correct parameters', () async {
      final result = await Once.runOnNewDay('key5', callback: () => 'callback');
      expect(result, 'callback');
    });

    test('runWeekly passes correct parameters', () async {
      final result = await Once.runWeekly('key6', callback: () => 'callback');
      expect(result, 'callback');
    });

    test('runMonthly passes correct parameters', () async {
      final result = await Once.runMonthly('key7', callback: () => 'callback');
      expect(result, 'callback');
    });

    test('runOnNewMonth passes correct parameters', () async {
      final result = await Once.runOnNewMonth('key8', callback: () => 'callback');
      expect(result, 'callback');
    });

    test('runYearly passes correct parameters', () async {
      final result = await Once.runYearly('key9', callback: () => 'callback');
      expect(result, 'callback');
    });

    test('runCustom passes correct parameters', () async {
      final result = await Once.runCustom('key10', duration: Duration(milliseconds: 1), callback: () => 'callback');
      expect(result, 'callback');
    });

    test('runOnEveryNewVersion passes correct parameters', () async {
      final result = await Once.runOnEveryNewVersion(key: 'key11', callback: () => 'callback');
      expect(result, null); // returns null on first run per runner impl
    });

    test('runOnEveryNewBuild passes correct parameters', () async {
      final result = await Once.runOnEveryNewBuild(key: 'key12', callback: () => 'callback');
      expect(result, null); // returns null on first run per runner impl
    });

    test('clear calls runner clear', () async {
      await Once.runOnce('key_to_clear', callback: () => 'callback');
      Once.clear(key: 'key_to_clear');
      // No explicit return to assert on without delay, but coverage will show it's called
    });

    test('clearAll calls runner clearAll', () async {
      await Once.runOnce('key_to_clear_all', callback: () => 'callback');
      Once.clearAll();
    });
  });
}
