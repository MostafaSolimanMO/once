import 'package:flutter_test/flutter_test.dart';
import 'package:once/src/utils.dart';

void main() {
  group('Utils.daysInMonth', () {
    test('returns correct days for non-leap year', () {
      expect(Utils.daysInMonth(1, 2023), 31);
      expect(Utils.daysInMonth(2, 2023), 28);
      expect(Utils.daysInMonth(3, 2023), 31);
      expect(Utils.daysInMonth(4, 2023), 30);
      expect(Utils.daysInMonth(5, 2023), 31);
      expect(Utils.daysInMonth(6, 2023), 30);
      expect(Utils.daysInMonth(7, 2023), 31);
      expect(Utils.daysInMonth(8, 2023), 31);
      expect(Utils.daysInMonth(9, 2023), 30);
      expect(Utils.daysInMonth(10, 2023), 31);
      expect(Utils.daysInMonth(11, 2023), 30);
      expect(Utils.daysInMonth(12, 2023), 31);
    });

    test('returns correct days for leap year (divisible by 4, not 100)', () {
      expect(Utils.daysInMonth(2, 2024), 29);
    });

    test('returns correct days for leap year (divisible by 400)', () {
      expect(Utils.daysInMonth(2, 2000), 29);
    });

    test('returns correct days for non-leap year (divisible by 100, not 400)', () {
      expect(Utils.daysInMonth(2, 1900), 28);
    });
  });
}
