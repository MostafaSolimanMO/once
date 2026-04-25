import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:once/once.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('OnceWidget (facade)', () {
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

    Widget wrap(Widget child) {
      return MaterialApp(
        home: Scaffold(
          body: child,
        ),
      );
    }

    testWidgets('showOnce renders builder on first run', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          OnceWidget.showOnce(
            'key_show_once',
            builder: () => const Text('Builder Content'),
            fallback: () => const Text('Fallback Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Builder Content'), findsOneWidget);
    });

    testWidgets('showOnEveryNewVersion renders fallback on first run', (WidgetTester tester) async {
      // First run returns null, so it falls back
      await tester.pumpWidget(
        wrap(
          OnceWidget.showOnEveryNewVersion(
            'key_show_version',
            builder: () => const Text('Builder Content'),
            fallback: () => const Text('Fallback Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Fallback Content'), findsOneWidget);
    });

    testWidgets('showOnEveryNewBuild renders fallback on first run', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          OnceWidget.showOnEveryNewBuild(
            'key_show_build',
            builder: () => const Text('Builder Content'),
            fallback: () => const Text('Fallback Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Fallback Content'), findsOneWidget);
    });

    testWidgets('showEvery12Hours renders builder on first run', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          OnceWidget.showEvery12Hours(
            'key_show_12h',
            builder: () => const Text('Builder Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Builder Content'), findsOneWidget);
    });

    testWidgets('showHourly renders builder on first run', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          OnceWidget.showHourly(
            'key_show_hourly',
            builder: () => const Text('Builder Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Builder Content'), findsOneWidget);
    });

    testWidgets('showDaily renders builder on first run', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          OnceWidget.showDaily(
            'key_show_daily',
            builder: () => const Text('Builder Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Builder Content'), findsOneWidget);
    });

    testWidgets('showOnNewDay renders builder on first run', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          OnceWidget.showOnNewDay(
            'key_show_newday',
            builder: () => const Text('Builder Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Builder Content'), findsOneWidget);
    });

    testWidgets('showWeekly renders builder on first run', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          OnceWidget.showWeekly(
            'key_show_weekly',
            builder: () => const Text('Builder Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Builder Content'), findsOneWidget);
    });

    testWidgets('showMonthly renders builder on first run', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          OnceWidget.showMonthly(
            'key_show_monthly',
            builder: () => const Text('Builder Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Builder Content'), findsOneWidget);
    });

    testWidgets('showOnNewMonth renders builder on first run', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          OnceWidget.showOnNewMonth(
            'key_show_newmonth',
            builder: () => const Text('Builder Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Builder Content'), findsOneWidget);
    });

    testWidgets('showYearly renders builder on first run', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          OnceWidget.showYearly(
            'key_show_yearly',
            builder: () => const Text('Builder Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Builder Content'), findsOneWidget);
    });

    testWidgets('showCustom renders builder on first run', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrap(
          OnceWidget.showCustom(
            'key_show_custom',
            duration: const Duration(seconds: 1),
            builder: () => const Text('Builder Content'),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Builder Content'), findsOneWidget);
    });

    testWidgets('clear works', (WidgetTester tester) async {
      OnceWidget.clear(key: 'some_key');
      // Just testing it does not crash
      expect(true, isTrue);
    });

    testWidgets('clearAll works', (WidgetTester tester) async {
      OnceWidget.clearAll();
      // Just testing it does not crash
      expect(true, isTrue);
    });
  });
}
