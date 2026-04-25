import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:once/once.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UntilDone Feature Tests', () {
    const String testKey = 'until-done-test-key';

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    test('Once.runUntilDone executes callback and then dismisses', () async {
      int count = 0;
      
      // First run: should execute callback
      await Once.runUntilDone(
        testKey,
        callback: (dismiss) {
          count++;
          // simulate user dismissal
          dismiss();
        },
      );
      expect(count, 1);

      // Second run: should NOT execute callback (key is marked 'done')
      await Once.runUntilDone(
        testKey,
        callback: (dismiss) {
          count++;
        },
      );
      expect(count, 1);
    });

    test('Once.runUntilDone returns fallback after dismissal', () async {
      bool fallbackCalled = false;

      // Mark as done first
      await Once.markDone(key: testKey);

      final result = await Once.runUntilDone(
        testKey,
        callback: (dismiss) => 'callback',
        fallback: () {
          fallbackCalled = true;
          return 'fallback';
        },
      );

      expect(result, 'fallback');
      expect(fallbackCalled, true);
    });

    testWidgets('OnceWidget.showUntilDone renders builder then fallback after dismiss', (tester) async {
      const String widgetKey = 'until-done-widget-key';
      
      // First pump: renders builder
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnceWidget.showUntilDone(
              widgetKey,
              builder: (dismiss) {
                return ElevatedButton(
                  onPressed: dismiss,
                  child: const Text('Dismiss'),
                );
              },
              fallback: () => const Text('Regular Screen'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Dismiss'), findsOneWidget);

      // Click dismiss
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Re-pump with a different Key to force a fresh state and re-check SharedPreferences
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnceWidget.showUntilDone(
              widgetKey,
              key: const ValueKey('second-pump'),
              builder: (dismiss) => const Text('Onboarding'),
              fallback: () => const Text('Regular Screen'),
            ),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      
      expect(find.text('Onboarding'), findsNothing);
      expect(find.text('Regular Screen'), findsOneWidget);
    });

    test('OnceRunner debug modes work for runUntilDone', () async {
      int count = 0;
      
      // debugCallback
      await Once.runUntilDone(
        testKey,
        debugCallback: true,
        callback: (dismiss) => count++,
      );
      expect(count, 1);

      // debugFallback
      final result = await Once.runUntilDone(
        testKey,
        debugFallback: true,
        callback: (dismiss) => 'callback',
        fallback: () => 'fallback',
      );
      expect(result, 'fallback');
    });

    test('OnceWidget.markDone works', () async {
      await OnceWidget.markDone(key: testKey);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('ONCE_PACKAGE_$testKey'), 'done');
    });

    testWidgets('OnceWidget.showUntilDone handles null fallback', (tester) async {
      await OnceWidget.markDone(key: 'null-fallback-key');
      await tester.pumpWidget(
        MaterialApp(
          home: OnceWidget.showUntilDone(
            'null-fallback-key',
            builder: (dismiss) => const Text('Onboarding'),
            // fallback is null
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(SizedBox), findsOneWidget);
    });
  });
}
