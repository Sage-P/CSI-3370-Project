import 'package:modoh/models/category.dart';
import 'package:modoh/models/expense.dart';
import 'package:modoh/models/frequency.dart';
import 'package:modoh/models/net_expenses.dart';
import 'package:test/test.dart';

void main() {
  NetExpenses ne;
  Expense e1, e2, e3;

  setUp(() {
    ne = new NetExpenses();
    e1 = new Expense(5000, Frequency.WEEKLY, Category.GROCERIES, 'Kroger');
    e2 = new Expense(
        1250, Frequency.MONTHLY, Category.SUBSCRIPTION, 'New York Times');
    e3 = new Expense(7500, Frequency.BIWEEKLY, Category.GROCERIES, 'Costco');
  });

  test('NetExpenses instance is properly created.', () {
    expect(ne.size(), 0);
    expect(ne.isEmpty(), true);
    expect(ne.getNetExpensesMonthlyAmount(), 0);
    expect(ne.removeExpense(e2), false);
  });

  test('Adding Expenses', () {
    Expense e4 =
        ne.addExpense(3000, Frequency.BIWEEKLY, Category.SUBSCRIPTION, "GYM");
    expect(ne.size(), 1);
    expect(ne.isEmpty(), false);
    expect(ne.getNetExpensesMonthlyAmount(), 6000);

    ne.addExpense(5000, Frequency.MONTHLY, Category.UTILITY, "ISP");
    expect(ne.size(), 2);
    expect(ne.isEmpty(), false);
    expect(ne.getNetExpensesMonthlyAmount(), 11000);

    ne.removeExpense(e4);
    expect(ne.size(), 1);
    expect(ne.isEmpty(), false);
    expect(ne.getNetExpensesMonthlyAmount(), 5000);
  });

  group('Removing', () {
    test('nonexistant Expense', () {
      ne.getNetExpenses().add(e1);
      ne.getNetExpenses().add(e2);
      expect(ne.removeExpense(e3), false);
      expect(ne.size(), 2);
      expect(ne.getNetExpensesMonthlyAmount(), 21250);
    });
    test('existing Expense', () {
      ne.getNetExpenses().add(e1);
      ne.getNetExpenses().add(e2);
      expect(ne.removeExpense(e2), true);
      expect(ne.size(), 1);
      expect(ne.getNetExpensesMonthlyAmount(), 20000);
    });
  });

  group('Expense', () {
    test('hiding', () {
      ne.getNetExpenses().add(e1);
      ne.getNetExpenses().add(e2);
      ne.getNetExpenses().add(e3);
      expect(ne.getNetExpensesMonthlyAmount(), 36250);

      ne.toggleExpense(e1);
      expect(ne.size(), 3);
      expect(ne.getNetExpensesMonthlyAmount(), 16250);
    });
    test('unhiding', () {
      ne.getNetExpenses().add(e1);
      ne.getNetExpenses().add(e2);

      ne.toggleExpense(e1);
      ne.toggleExpense(e2);
      expect(ne.size(), 2);
      expect(ne.getNetExpensesMonthlyAmount(), 0);

      ne.toggleExpense(e2);
      expect(ne.size(), 2);
      expect(ne.getNetExpensesMonthlyAmount(), 1250);
    });
  });

  group('Sorting Expenses', () {
    test('by Category', () {
      e1 = ne.addExpense(
          1000000, Frequency.HALFANNUALLY, Category.UNIVERSITY, 'Tuition');
      e2 = ne.addExpense(22500, Frequency.MONTHLY, Category.CAR, 'Lease');
      e3 = ne.addExpense(45000, Frequency.MONTHLY, Category.RENT, 'Rent');
      Expense e4 = ne.addExpense(2000, Frequency.BIWEEKLY, Category.GAS, 'Gas');
      Expense e5 = ne.addExpense(
          1300, Frequency.MONTHLY, Category.ENTERTAINMENT, 'Netflix');
      Expense e6 =
          ne.addExpense(20000, Frequency.HALFANNUALLY, Category.CAR, 'Repairs');

      expect(ne.getNetExpenses(), equals([e1, e2, e3, e4, e5, e6]));

      ne.sortExpensesByCategory();
      expect(ne.getNetExpenses(), equals([e2, e6, e5, e4, e3, e1]));
      print(ne);
    });
    test('by Amount', () {
      e1 = ne.addExpense(
          1000000, Frequency.HALFANNUALLY, Category.UNIVERSITY, 'Tuition');
      e2 = ne.addExpense(22500, Frequency.MONTHLY, Category.CAR, 'Lease');
      e3 = ne.addExpense(45000, Frequency.MONTHLY, Category.RENT, 'Rent');
      Expense e4 = ne.addExpense(2000, Frequency.BIWEEKLY, Category.GAS, 'Gas');
      Expense e5 = ne.addExpense(
          1300, Frequency.MONTHLY, Category.ENTERTAINMENT, 'Netflix');
      Expense e6 =
          ne.addExpense(20000, Frequency.HALFANNUALLY, Category.CAR, 'Repairs');

      expect(ne.getNetExpenses(), equals([e1, e2, e3, e4, e5, e6]));

      ne.sortExpensesByAmount();
      expect(ne.getNetExpenses(), equals([e1, e3, e2, e6, e4, e5]));
      print(ne);
    });
    test('by Monthly Amount', () {
      e1 = ne.addExpense(
          1000000, Frequency.HALFANNUALLY, Category.UNIVERSITY, 'Tuition');
      e2 = ne.addExpense(22500, Frequency.MONTHLY, Category.CAR, 'Lease');
      e3 = ne.addExpense(45000, Frequency.MONTHLY, Category.RENT, 'Rent');
      Expense e4 = ne.addExpense(2000, Frequency.BIWEEKLY, Category.GAS, 'Gas');
      Expense e5 = ne.addExpense(
          1300, Frequency.MONTHLY, Category.ENTERTAINMENT, 'Netflix');
      Expense e6 =
          ne.addExpense(20000, Frequency.HALFANNUALLY, Category.CAR, 'Repairs');

      expect(ne.getNetExpenses(), equals([e1, e2, e3, e4, e5, e6]));

      ne.sortExpensesByMonthlyAmount();
      expect(ne.getNetExpenses(), equals([e1, e3, e2, e4, e6, e5]));
      print(ne);
    });
    test('by Description', () {
      e1 = ne.addExpense(
          1000000, Frequency.HALFANNUALLY, Category.UNIVERSITY, 'Tuition');
      e2 = ne.addExpense(22500, Frequency.MONTHLY, Category.CAR, 'Lease');
      e3 = ne.addExpense(45000, Frequency.MONTHLY, Category.RENT, 'Rent');
      Expense e4 = ne.addExpense(2000, Frequency.BIWEEKLY, Category.GAS, 'Gas');
      Expense e5 = ne.addExpense(
          1300, Frequency.MONTHLY, Category.ENTERTAINMENT, 'Netflix');
      Expense e6 =
          ne.addExpense(20000, Frequency.HALFANNUALLY, Category.CAR, 'Repairs');

      expect(ne.getNetExpenses(), equals([e1, e2, e3, e4, e5, e6]));

      ne.sortExpensesByDescription();
      expect(ne.getNetExpenses(), equals([e4, e2, e5, e3, e6, e1]));
      print(ne);
    });
  });
}
