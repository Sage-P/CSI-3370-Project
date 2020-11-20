import 'package:modoh/models/category.dart';
import 'package:modoh/models/expense.dart';
import 'package:modoh/models/frequency.dart';

import 'package:test/test.dart';

void main() {
  Expense exp;

  setUp(() {
    exp = new Expense(
        11900, Frequency.ANNUALLY, Category.SUBSCRIPTION, "Amazon Prime");
  });

  test('Expense instance is properly created.', () {
    expect(exp.getAmount(), equals(119 * 100));
    expect(exp.getDescription(), equals('Amazon Prime'));
    expect(exp.getCategory(), equals(Category.SUBSCRIPTION));
    expect(exp.getFrequency(), equals(Frequency.ANNUALLY));
    expect(exp.isHidden(), false);
    expect(exp.getMonthlyAmount(), equals(9.91 * 100));
  });

  group('setAmount()', () {
    test('Reasonable input', () {
      exp.setAmount(125 * 100);
      expect(exp.getAmount(), equals(125 * 100));
      expect(exp.getMonthlyAmount(), equals(10.41 * 100));
    });
    test('Negative input', () {
      exp.setAmount(-125 * 100);
      expect(exp.getAmount(), equals(125 * 100));
      expect(exp.getMonthlyAmount(), equals(10.41 * 100));
    });
    test('0 input', () {
      exp.setAmount(0);
      expect(exp.getAmount(), equals(0 * 100));
      expect(exp.getMonthlyAmount(), equals(0 * 100));
    });
    test('Small input', () {
      exp.setAmount(25); // 25 cents
      expect(exp.getAmount(), equals(0.25 * 100));
      expect(exp.getMonthlyAmount(), equals(0.02 * 100));
    });
  });

  test('setDescription()', () {
    exp.setDescription('Netflix');
    expect(exp.getDescription(), equals('Netflix'));
  });

  group('setFrequency()', () {
    test('DAILY', () {
      exp.setFrequency(Frequency.DAILY);
      expect(exp.getFrequency(), equals(Frequency.DAILY));
      expect(exp.getMonthlyAmount(), equals(3570 * 100));
    });
    test('HALFWEEKLY', () {
      exp.setFrequency(Frequency.HALFWEEKLY);
      expect(exp.getMonthlyAmount(), equals(952 * 100));
    });
    test('WEEKLY', () {
      exp.setFrequency(Frequency.WEEKLY);
      expect(exp.getMonthlyAmount(), equals(476 * 100));
    });
    test('BIWEEKLY', () {
      exp.setFrequency(Frequency.BIWEEKLY);
      expect(exp.getMonthlyAmount(), equals(238 * 100));
    });
    test('MONTHLY', () {
      exp.setFrequency(Frequency.MONTHLY);
      expect(exp.getMonthlyAmount(), equals(119 * 100));
    });
    test('BIMONTHLY', () {
      exp.setFrequency(Frequency.BIMONTHLY);
      expect(exp.getMonthlyAmount(), equals(59.5 * 100));
    });
    test('TRIMONTHLY', () {
      exp.setFrequency(Frequency.TRIMONTHLY);
      expect(exp.getMonthlyAmount(), equals((39.66 * 100).round()));
    });
    test('HALFANNUALLY', () {
      exp.setFrequency(Frequency.HALFANNUALLY);
      expect(exp.getMonthlyAmount(), equals((19.83 * 100).round()));
    });
    test('ANNUALLY', () {
      exp.setFrequency(Frequency.ANNUALLY);
      expect(exp.getMonthlyAmount(), equals(9.91 * 100));
    });
  });

  test('setCategory()', () {
    exp.setCategory(Category.CAR);
    expect(exp.getCategory(), equals(Category.CAR));
  });

  group('toggleVisibility()', () {
    test('hiding', () {
      exp.toggleVisibility();
      expect(exp.isHidden(), true);
    });
    test('unhiding', () {
      exp.toggleVisibility();
      exp.toggleVisibility();
      expect(exp.isHidden(), false);
    });
  });
}
