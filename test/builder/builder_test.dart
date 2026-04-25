import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:once/src/builder/builder.dart';

void main() {
  group('OnceWidget / OnceBuilder', () {
    testWidgets('shows SizedBox.shrink() while waiting', (WidgetTester tester) async {
      final Future<Widget?> future = Future.delayed(
        const Duration(milliseconds: 100),
        () => const Text('Future Data'),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnceBuilder.build(
              null,
              future,
              () => const Text('Fallback Data'),
            ),
          ),
        ),
      );

      // Initially, it should be waiting, so it shows SizedBox.shrink()
      expect(find.byType(SizedBox), findsWidgets);
      expect(find.text('Future Data'), findsNothing);
      expect(find.text('Fallback Data'), findsNothing);

      // Wait for the future to complete
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      expect(find.text('Future Data'), findsOneWidget);
    });

    testWidgets('shows callback widget when future has data', (WidgetTester tester) async {
      final Future<Widget?> future = Future.value(const Text('Future Data'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnceBuilder.build(
              null,
              future,
              () => const Text('Fallback Data'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Future Data'), findsOneWidget);
      expect(find.text('Fallback Data'), findsNothing);
    });

    testWidgets('shows fallback widget when future resolves to null', (WidgetTester tester) async {
      final Future<Widget?> future = Future.value(null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnceBuilder.build(
              null,
              future,
              () => const Text('Fallback Data'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Future Data'), findsNothing);
      expect(find.text('Fallback Data'), findsOneWidget);
    });

    testWidgets('shows SizedBox.shrink() when future resolves to null and fallback is null', (WidgetTester tester) async {
      final Future<Widget?> future = Future.value(null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnceBuilder.build(
              null,
              future,
              null,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      // Only SizedBox.shrink() should be there
      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
