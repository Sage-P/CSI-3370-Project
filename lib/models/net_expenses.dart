import 'package:modoh/models/category.dart';
import 'package:modoh/models/expense.dart';
import 'package:modoh/models/frequency.dart';

class NetExpenses {
  List<Expense> _netExpenses;

  NetExpenses() {
    _netExpenses = new List<Expense>();
  }

  List<Expense> getNetExpenses() {
    return _netExpenses;
  }

  int getNetExpensesMonthlyAmount() {
    int sum = 0;
    for (Expense e in _netExpenses) {
      if (!e.isHidden()) {
        sum += e.getMonthlyAmount();
      }
    }
    return sum;
  }

  bool isEmpty() {
    return _netExpenses.isEmpty;
  }

  int size() {
    return _netExpenses.length;
  }

  Expense addExpense(
      int amount, Frequency frequency, Category category, String description) {
    Expense newExpense = new Expense(amount, frequency, category, description);
    _netExpenses.add(newExpense);
    return newExpense;
  }

  void removeExpense(Expense e) {
    _netExpenses.remove(e);
  }

  void sortExpensesByAmount() {
    _netExpenses
        .sort((Expense a, Expense b) => a.getAmount().compareTo(b.getAmount()));
  }

  void sortExpensesByMonthlyAmount() {
    _netExpenses.sort((Expense a, Expense b) =>
        a.getMonthlyAmount().compareTo(b.getMonthlyAmount()));
  }

  void sortExpensesByCategory() {
    _netExpenses.sort((Expense a, Expense b) =>
        a.getCategory().toString().compareTo(b.getCategory().toString()));
  }

  void hideExpense(Expense e) {
    if (!e.isHidden()) {
      e.toggleVisibility();
    }
  }

  void unhideExpense(Expense e) {
    if (e.isHidden()) {
      e.toggleVisibility();
    }
  }

  String toString() {
    String s = '';
    for (Expense e in _netExpenses) {
      s += e.toString() + '\n';
    }
    return s;
  }
}
