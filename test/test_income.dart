import 'package:modoh/models/frequency.dart';
import 'package:modoh/models/income.dart';
import 'package:test/test.dart';

void main() {
  Income inc;

  setUp(() {
    inc = new Income(75000 * 100, Frequency.ANNUALLY, "Pay Check");
  });

  test('Income instance is properly created.', () {
    expect(inc.getAmount(), equals(75000 * 100));
    expect(inc.getDescription(), equals("Pay Check"));
    expect(inc.getFrequency(), equals(Frequency.ANNUALLY));
    expect(inc.ishidden(), false);
    expect(inc.getMonthlyAmount(), equals(6250 * 100));
  });

  group('setAmount()', () {
    test('Reasonable input', () {
      inc.setAmount(1000 * 100);
      expect(inc.getAmount(), equals(1000 * 100));
      expect(inc.getMonthlyAmount(), equals(83.33 * 100));
    });

    test('Negative Inputs', () {
      inc.setAmount(-1000 * 100);
      expect(inc.getAmount(), equals(1000 * 100));
      expect(inc.getMonthlyAmount(), equals(83.33 * 100));
    });

    test('0 input', () {
      inc.setAmount(0);
      expect(inc.getAmount(), equals(0));
      expect(inc.getMonthlyAmount(), equals(0));
    });

    test('Small input', () {
      inc.setAmount(25); // 25 cents
      expect(inc.getAmount(), equals(0.25 * 100));
      expect(inc.getMonthlyAmount(), equals(0.02 * 100));
    });
  });

  test('setDescription()', () {
    inc.setDescription("Pay Check");
    expect(inc.getDescription(), equals("Pay Check"));
  });

  group('setFrequency()', () {
    test('Daily', () {
      inc.setFrequency(Frequency.DAILY);
      expect(inc.getFrequency(), equals(Frequency.DAILY));
      expect(inc.getMonthlyAmount(), equals(6250 * 100 * 360));
    });

    test('Halfweekly', () {
      inc.setFrequency(Frequency.HALFWEEKLY);
      expect(inc.getMonthlyAmount(), equals(6250 * 100 * 96));
    });

    test('Weekly', () {
      inc.setFrequency(Frequency.WEEKLY);
      expect(inc.getMonthlyAmount(), equals(6250 * 100 * 48));
    });

    test('Biweekly', () {
      inc.setFrequency(Frequency.BIWEEKLY);
      expect(inc.getMonthlyAmount(), equals(6250 * 100 * 24));
    });

    test('Monthly', () {
      inc.setFrequency(Frequency.MONTHLY);
      expect(inc.getMonthlyAmount(), equals(6250 * 100 * 12));
    });

    test('Bimonthly', () {
      inc.setFrequency(Frequency.BIMONTHLY);
      expect(inc.getMonthlyAmount(), equals(6250 * 100 * 6));
    });

    test('Trimonthly', () {
      inc.setFrequency(Frequency.TRIMONTHLY);
      expect(inc.getMonthlyAmount(), equals(6250 * 100 * 4));
    });

    test('Halfannualy', () {
      inc.setFrequency(Frequency.HALFANNUALLY);
      expect(inc.getMonthlyAmount(), equals(6250 * 100 * 2));
    });

    test('Annualy', () {
      inc.setFrequency(Frequency.ANNUALLY);
      expect(inc.getMonthlyAmount(), equals(6250 * 100 * 1));
    });
  });

  group('toggleVisibility()', () {
    test('hiding', () {
      inc.toggleVisibility();
      expect(inc.ishidden(), true);
    });

    test('unhiding', () {
      inc.toggleVisibility();
      inc.toggleVisibility();
      expect(inc.ishidden(), false);
    });
  });
}
