import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modoh/models/budget.dart';
import 'package:modoh/models/category.dart';
import 'package:modoh/models/expense.dart';
import 'package:modoh/models/frequency.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference budgetCollection =
      FirebaseFirestore.instance.collection('budgets');

  Future updateUserData(Budget budget) async {
    Map<String, dynamic> data = {};
    budget
        .getListOfExpenses()
        .addExpense(5000, Frequency.WEEKLY, Category.ENTERTAINMENT, 'Movies');
    for (Expense e in budget.getListOfExpenses().getNetExpenses()) {
      data.putIfAbsent(e.getDescription(), () => e.toMap());
    }

    print(data);

    return await budgetCollection.doc(uid).set({
      'net-cashflow-amount': budget.getNetMonthlyCashFlow(),
      'expenses': data,
    });
  }
}
