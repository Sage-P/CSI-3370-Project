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

  bool removeExpense(Expense e) {
    return _netExpenses.remove(e);
  }

  // Decreasing order
  void sortExpensesByAmount() {
    _netExpenses
        .sort((Expense a, Expense b) => b.getAmount().compareTo(a.getAmount()));
  }

  // Decreasing order
  void sortExpensesByMonthlyAmount() {
    _netExpenses.sort((Expense a, Expense b) =>
        b.getMonthlyAmount().compareTo(a.getMonthlyAmount()));
  }

  // Alphabetically by Category
  void sortExpensesByCategory() {
    _netExpenses.sort((Expense a, Expense b) =>
        a.getCategory().toString().compareTo(b.getCategory().toString()));
  }

  // Alphabetically by Description
  void sortExpensesByDescription() {
    _netExpenses.sort((Expense a, Expense b) =>
        a.getDescription().compareTo(b.getDescription()));
  }

  void toggleExpense(Expense e) {
    e.toggleVisibility();
  }

  String toString() {
    String s = '';
    for (Expense e in _netExpenses) {
      if (e.isHidden()) {
        s += "[HIDDEN] ";
      }
      s += e.toString() + '\n';
    }
    s += '\n Net Expenses per Month: \$' +
        (getNetExpensesMonthlyAmount() / 100).toStringAsFixed(2);
    return s;
  }
}
