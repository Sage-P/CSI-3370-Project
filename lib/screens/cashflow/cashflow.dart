import 'package:flutter/material.dart';
import 'package:modoh/screens/cashflow/manage_expenses.dart';

class Cashflow extends StatefulWidget {
  @override
  _CashflowState createState() => _CashflowState();
}

class _CashflowState extends State<Cashflow> {
  @override
  Widget build(BuildContext context) {
    // Paste UI in here
    return RaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ManageExpenses()));
      },
      child: Text('Manage Expenses'),
    );
  }
}
