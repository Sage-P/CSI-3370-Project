import 'package:modoh/models/net_expenses.dart';

class Budget {
  NetExpenses _netExpenses;
  int _netMonthlyCashflow;

  Budget() {
    _netExpenses = new NetExpenses();
    _netMonthlyCashflow = 0;
    _calculateNetMonthlyCashFlow();
  }

  void _calculateNetMonthlyCashFlow() {
    _netMonthlyCashflow = 0 - _netExpenses.getNetExpensesMonthlyAmount();
  }

  String toString() {
    return _netMonthlyCashflow.toString() + '\n' + _netExpenses.toString();
  }
}
