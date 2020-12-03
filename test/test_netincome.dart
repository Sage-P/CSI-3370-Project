import 'package:modoh/models/frequency.dart';
import 'package:modoh/models/income.dart';
import 'package:modoh/models/net_income.dart';
import 'package:test/test.dart';

void main() {
  NetIncome ni;
  Income i1, i2, i3;

  setUp(() {
    ni = new NetIncome();
    i1 = new Income(75000 * 100, Frequency.ANNUALLY, "Pay");
    i2 = new Income(1500 * 100, Frequency.MONTHLY, "Incoming Rent");
    i3 = new Income(950 * 100, Frequency.DAILY, "Side Business");
  });

  test('NetIncome insance is properly created.', () {
    expect(ni.size(), 0);
    expect(ni.isEmpty(), true);
    expect(ni.removeIncome(i3), false);
  });

  test('Adding Income', () {
    Income i4 =
        ni.addIncome(650 * 100, Frequency.HALFANNUALLY, "Phone Bill (Jhon)");
    expect(ni.size(), 1);
    expect(ni.isEmpty(), false);
    expect(ni.getNetIncomeMonthlyAmount(), (108.33 * 100));

    ni.removeIncome(i4);
    expect(ni.size(), 0);
    expect(ni.isEmpty(), true);
    expect(ni.getNetIncomeMonthlyAmount(), (0 * 100));
  });

  group('Removing', () {
    test('nonexistant Income', () {
      ni.getNetIncome().add(i1);
      ni.getNetIncome().add(i2);
      expect(ni.removeIncome(i3), false);
      expect(ni.size(), 2);
      expect(ni.getNetIncomeMonthlyAmount(), 7750 * 100);
    });

    test('existing Income', () {
      ni.getNetIncome().add(i1);
      ni.getNetIncome().add(i2);
      expect(ni.removeIncome(i2), true);
      expect(ni.size(), 1);
      expect(ni.getNetIncomeMonthlyAmount(), 6250 * 100);
    });
  });

  group('Income', () {
    test('hiding', () {
      ni.getNetIncome().add(i1);
      ni.getNetIncome().add(i2);
      ni.getNetIncome().add(i3);
      expect(ni.getNetIncomeMonthlyAmount(), (36250 * 100));

      ni.toggleIncome(i1);
      expect(ni.size(), 3);
      expect(ni.getNetIncomeMonthlyAmount(), 30000 * 100);
    });
    test('unhiding', () {
      ni.getNetIncome().add(i1);
      ni.getNetIncome().add(i2);

      ni.toggleIncome(i1);
      ni.toggleIncome(i2);
      expect(ni.size(), 2);
      expect(ni.getNetIncomeMonthlyAmount(), 0);

      ni.toggleIncome(i2);
      expect(ni.size(), 2);
      expect(ni.getNetIncomeMonthlyAmount(), 1500 * 100);
    });
  });

  group('Sorting Income', () {
    test('by Amount', () {
      i1 = ni.addIncome(5000, Frequency.MONTHLY, "Savings");
      i2 = ni.addIncome(1000, Frequency.DAILY, "Small Business");
      i3 = ni.addIncome(3000, Frequency.MONTHLY, "Rent");

      expect(ni.getNetIncome(), equals([i1, i2, i3]));
      ni.sortIncomebyAmount();
      expect(ni.getNetIncome(), equals([i1, i3, i2]));
      print(ni);
    });

    test('by monthly amount', () {
      i1 = ni.addIncome(5000, Frequency.MONTHLY, "Savings");
      i2 = ni.addIncome(1000, Frequency.DAILY, "Small Business");
      i3 = ni.addIncome(3000, Frequency.MONTHLY, "Rent");

      expect(ni.getNetIncome(), equals([i1, i2, i3]));
      ni.sortIncomebyMonthlyAmount();
      expect(ni.getNetIncome(), [i2, i1, i3]);
      print(ni);
    });
  });
}
