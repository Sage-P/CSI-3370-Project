import 'package:modoh/models/net_expenses.dart';
import 'package:modoh/models/net_income.dart';

class Budget {
  NetExpenses _netExpenses;
  NetIncome _netIncome;
  int _netMonthlyCashflow;
  double threshold;

  Budget() {
    _netExpenses = new NetExpenses();
    _netIncome = new NetIncome();
    _netMonthlyCashflow = 0;
    _calculateNetMonthlyCashFlow();
  }

  NetExpenses getListOfExpenses() {
    return _netExpenses;
  }

  int getNetMonthlyCashFlow() {
    _calculateNetMonthlyCashFlow();
    return _netMonthlyCashflow;
  }

  void _calculateNetMonthlyCashFlow() {
    _netMonthlyCashflow = _netIncome.getNetIncomeMonthlyAmount() -
        _netExpenses.getNetExpensesMonthlyAmount();
  }

  String toString() {
    _calculateNetMonthlyCashFlow();
    if (_netMonthlyCashflow < 0) {
      return '-\$' +
          (_netMonthlyCashflow * -1 / 100).toStringAsFixed(2) +
          '\n' +
          _netExpenses.toString() +
          '\n' +
          _netIncome.toString();
    } else {
      return '\$' +
          (_netMonthlyCashflow / 100).toStringAsFixed(2) +
          '\n' +
          _netExpenses.toString() +
          '\n' +
          _netIncome.toString();
    }
  }
}
