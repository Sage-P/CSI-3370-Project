import 'package:app/income/frequency.dart';
import 'package:app/income/income.dart';
import 'package:app/income/income.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {
   Income inc;

   setUp((){
      inc = new Income(75000, Frequency.Annually, "Pay Check");
   });

   test('Income instance is properly created.',(){
     expect(inc.getAmount(), equals(75 * 1000));
     expect(inc.getDescription(), equals("Pay Check"));
     expect(inc.getFrequency(), equals(Frequency.Annually));
     expect(inc.ishidden(), false);
     expect(inc.getMonthlyAmount(), equals(6.25 * 1000));
   });

   group('setAmount()', () {
     test('Reasonable input', () {
       inc.setAmount(1.0 * 1000);
       expect(inc.getAmount(), equals(100 * 1000));
       expect(inc.getMonthlyAmount(), equals(8.33 * 1000));

     });

     test('Negative Inputs', (){
       inc.setAmount(-1.0 * 1000);
       expect(inc.getAmount(), equals(100 * 1000));
       expect(inc.getMonthlyAmount(), equals(8.33 * 1000));
     });

     test('0 input', () {
      inc.setAmount(0);
      expect(inc.getAmount(), equals(0 * 1000));
      expect(inc.getMonthlyAmount(), equals(0 * 1000));
    });

     test('Small input', () {
      inc.setAmount(25); // 25 cents
      expect(inc.getAmount(), equals(0.25 * 100));
      expect(inc.getMonthlyAmount(), equals(0.02 * 100));
    });

   });

   test('setDescription()' , (){
     inc.setDescription("Pay Check");
     expect(inc.getDescription(), equals("Pay Check"));
   });

   group('setFrequency()', () {
     test('Daily', () {
        inc.setFrequency(Frequency.Daily);
      expect(inc.getFrequency(), equals(Frequency.Daily));
      expect(inc.getMonthlyAmount(), equals(3570 * 100));
    });

    test('Halfweekly', () {
      inc.setFrequency(Frequency.Halfweekly);
      expect(inc.getMonthlyAmount(), equals(952 * 100));
    });

    test('Weekly', () {
      inc.setFrequency(Frequency.Weekly);
      expect(inc.getMonthlyAmount(), equals(476 * 100));
    });

    test('Biweekly', () {
      inc.setFrequency(Frequency.Biweekly);
      expect(inc.getMonthlyAmount(), equals(238 * 100));
    });

      test('Monthly', () {
      inc.setFrequency(Frequency.Monthly);
      expect(inc.getMonthlyAmount(), equals(119 * 100));
    });

    test('Bimonthly', () {
      inc.setFrequency(Frequency.Bimonthly);
      expect(inc.getMonthlyAmount(), equals(59.5 * 100));
    });

    test('Trimonthly', () {
      inc.setFrequency(Frequency.Trimonthly);
      expect(inc.getMonthlyAmount(), equals((39.66 * 100).round()));
    });

    test('Halfannualy', () {
      inc.setFrequency(Frequency.Halfannually);
      expect(inc.getMonthlyAmount(), equals((19.83 * 100).round()));
    });

    test('Annualy', () {
      inc.setFrequency(Frequency.Annually);
      expect(inc.getMonthlyAmount(), equals(9.91 * 100));
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