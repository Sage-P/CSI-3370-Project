import 'package:flutter/material.dart';
import 'package:modoh/models/budget.dart';
import 'package:modoh/screens/cashflow/cashflow.dart';
import 'package:modoh/services/database.dart';
import 'package:provider/provider.dart';

class CashflowWrapper extends StatelessWidget {
  final String uid;
  CashflowWrapper({this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Budget>.value(
        value: DatabaseService(uid: uid).budgets,
        child: MaterialApp(
          home: Cashflow(),
        ));
  }
}
