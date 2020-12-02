import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modoh/models/budget.dart';
import 'package:modoh/models/category.dart';
import 'package:modoh/models/expense.dart';
import 'package:modoh/models/frequency.dart';
import 'package:modoh/models/net_expenses.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference budgetCollection =
      FirebaseFirestore.instance.collection('budgets');

  Future updateUserData(Budget budget) async {
    Map<String, dynamic> data = {};
    for (Expense e in budget.getListOfExpenses().getNetExpenses()) {
      data[e.getDescription()] = e.toMap();
    }

    return await budgetCollection.doc(uid).set({
      'net-cashflow-amount': budget.getNetMonthlyCashFlow(),
      'expenses': data,
    });
  }

  Budget _budgetFromSnapshot(DocumentSnapshot snapshot) {
    Budget budget = new Budget();
    NetExpenses netExpenses = budget.getListOfExpenses();

    Map<String, dynamic> expensesMap = snapshot.get('expenses');

    expensesMap.entries.forEach((element) {
      Map<String, dynamic> expenseFields = element.value;
      int _amount = expenseFields['amount-in-cents'] ?? 10000;
      Frequency _frequency =
          _getFrequencyFromString(expenseFields['frequency']) ??
              Frequency.MONTHLY;
      Category _category =
          _getCategoryFromString(expenseFields['category']) ?? Category.OTHERS;
      String _description = expenseFields['description'] ?? 'TEMPLATE';
      bool _isHidden = expenseFields['is-hidden'] ?? false;
      Expense e =
          netExpenses.addExpense(_amount, _frequency, _category, _description);
      if (_isHidden) e.toggleVisibility();
    });
    return budget;
  }

  Category _getCategoryFromString(String s) {
    switch (s) {
      case 'GROCERIES':
        return Category.GROCERIES;
        break;
      case 'GAS':
        return Category.GAS;
        break;
      case 'TRANSPORT':
        return Category.TRANSPORT;
        break;
      case 'ENTERTAINMENT':
        return Category.ENTERTAINMENT;
        break;
      case 'UTILITY':
        return Category.UTILITY;
        break;
      case 'MORTGAGE':
        return Category.MORTGAGE;
        break;
      case 'RENT':
        return Category.RENT;
        break;
      case 'UNIVERSITY':
        return Category.UNIVERSITY;
        break;
      case 'CAR':
        return Category.CAR;
        break;
      case 'SUBSCRIPTION':
        return Category.SUBSCRIPTION;
        break;
      default:
        return Category.OTHERS;
    }
  }

  Frequency _getFrequencyFromString(String s) {
    switch (s) {
      case 'DAILY':
        return Frequency.DAILY;
        break;
      case 'HALFWEEKLY':
        return Frequency.HALFWEEKLY;
        break;
      case 'WEEKLY':
        return Frequency.WEEKLY;
        break;
      case 'BIWEEKLY':
        return Frequency.BIWEEKLY;
        break;
      case 'MONTHLY':
        return Frequency.MONTHLY;
        break;
      case 'BIMONTHLY':
        return Frequency.BIMONTHLY;
        break;
      case 'TRIMONTHLY':
        return Frequency.TRIMONTHLY;
        break;
      case 'HALFANNUALLY':
        return Frequency.HALFANNUALLY;
        break;
      case 'ANNUALLY':
        return Frequency.ANNUALLY;
        break;
      default:
        return Frequency.MONTHLY;
    }
  }

  Stream<Budget> get budgets {
    return budgetCollection.doc(uid).snapshots().map(_budgetFromSnapshot);
  }
}
