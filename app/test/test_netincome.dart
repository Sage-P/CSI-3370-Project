import 'package:app/income/frequency.dart';
import 'package:app/income/income.dart';
import 'package:app/income/net_income.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {
  NetIncome ni;
  Income i1, i2, i3;

  setUp((){
    ni = new NetIncome();
    i1 = new Income(75000, Frequency.Annually, "Pay");
    i2 = new Income(1500, Frequency.Monthly, "Incoming Rent");
    i3 = new Income(950, Frequency.Daily, "Side Business");

  });

  test('NetIncome insance is properly created.', (){
    expect(ni.size(), 0);
    expect(ni.isEmpty(), true);
    expect(ni.removeIncome(i3), false);
  });

  test('Adding Income', (){
    Income i4;
      ni.addIncome(650, Frequency.Halfannually, "Phone Bill (Jhon)");
      expect(ni.size(), 1);
      expect(ni.isEmpty(), false);
      expect(ni.getNetIncomeMothlyAmount(), (1.0 * 100));

      ni.removeIncome(i4);
      expect(ni.size(), 1);
      expect(ni.isEmpty(), false);
      expect(ni.getNetIncomeMothlyAmount(), (1.0 * 100));

  });

  group('Removing', () {
    test('nonexistant Income', (){
      ni.getNetIncome().add(i1);
      ni.getNetIncome().add(i2);
      expect(ni.removeIncome(i3), false);
      expect(ni.size(), 2);
      expect(ni.getNetIncomeMothlyAmount(), 7750);

    });

    test('existing Income', () {
      ni.getNetIncome().add(i1);
      ni.getNetIncome().add(i2);
      expect(ni.removeIncome(i2), true);
      expect(ni.size(), 1);
      expect(ni.getNetIncomeMothlyAmount(), 6250);
    });
  });

  group('Income', (){
    test('hiding', () {
      ni.getNetIncome().add(i1);
      ni.getNetIncome().add(i2);
      ni.getNetIncome().add(i3);
      expect(ni.getNetIncomeMothlyAmount(), (36250));

      ni.toggleIncome(i1);
      expect(ni.size(), 3);
      expect(ni.getNetIncomeMothlyAmount(), 30000);
    });
    test('unhiding', () {
      ni.getNetIncome().add(i1);
      ni.getNetIncome().add(i2);

      ni.toggleIncome(i1);
      ni.toggleIncome(i2);
      expect(ni.size(), 2);
      expect(ni.getNetIncomeMothlyAmount(), 0);

      ni.toggleIncome(i2);
      expect(ni.size(), 2);
      expect(ni.getNetIncomeMothlyAmount(), 35700);
    });
  });

  group('Sorting Income', () {
    test('by Amount', () {
      i1 = ni.addIncome(5000, Frequency.Monthly, "Savings");
      i2 = ni.addIncome(1000, Frequency.Daily, "Small Business");
      i3 = ni.addIncome(3000, Frequency.Monthly, "Rent");
     
      expect(ni.getNetIncome(), equals([i1, i2, i3]));
       ni.sortIncomebyAmount();
       expect(ni.getNetIncome(), equals([i1, i3, i2]));
       print(ni);
    });

    test('by monthly amount', () {
      i1 = ni.addIncome(5000, Frequency.Monthly, "Savings");
      i2 = ni.addIncome(1000, Frequency.Daily, "Small Business");
      i3 = ni.addIncome(3000, Frequency.Monthly, "Rent");
     
      expect(ni.getNetIncome(), equals([i1, i2, i3]));
      ni.sortIncomebyMonthlyAmount();
      expect(ni.getNetIncome(), [i1, i3, i2]);
      print(ni);
      });
    });

}