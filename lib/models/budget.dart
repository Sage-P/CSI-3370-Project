import 'package:modoh/models/net_expenses.dart';

class Budget {
  NetExpenses _netExpenses;
  int _netMonthlyCashflow;

  Budget() {
    _netExpenses = new NetExpenses();
    _netMonthlyCashflow = 0;
    _calculateNetMonthlyCashFlow();
  }

  // List<Income> getListOfIncomes() {
  //   return _netIncomes.getNetIncomes();
  // }

  NetExpenses getListOfExpenses() {
    return _netExpenses;
  }

  int getNetMonthlyCashFlow() {
    _calculateNetMonthlyCashFlow();
    return _netMonthlyCashflow;
  }

  void _calculateNetMonthlyCashFlow() {
    _netMonthlyCashflow = 0 - _netExpenses.getNetExpensesMonthlyAmount();
  }

  String toString() {
    _calculateNetMonthlyCashFlow();
    if (_netMonthlyCashflow < 0) {
      return '-\$' +
          (_netMonthlyCashflow * -1 / 100).toStringAsFixed(2) +
          '\n' +
          _netExpenses.toString();
    } else {
      return '\$' +
          (_netMonthlyCashflow / 100).toStringAsFixed(2) +
          '\n' +
          _netExpenses.toString();
    }
  }
}
