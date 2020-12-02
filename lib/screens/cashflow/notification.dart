import 'package:flutter/material.dart';
import 'package:modoh/models/expense.dart';
import 'package:modoh/models/income.dart';

Income i;
Expense e;

Future notifyAtQuater(BuildContext context) {
  if (e.getMonthlyAmount() > (0.25 * i.getMonthlyAmount())) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Spending Notification!"),
            content: Text("You have spent 25% of your income."),
            actions: [
              FlatButton(child: Text("OK"), onPressed: () {}),
            ]);
      },
    );
  } else {
    return null;
  }
}

Future notifyAtHalf(BuildContext context) {
  if (e.getMonthlyAmount() > (0.50 * i.getMonthlyAmount())) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Spending Notification!"),
            content: Text("You have spent 50% of your income."),
            actions: [
              FlatButton(child: Text("OK"), onPressed: () {}),
            ]);
      },
    );
  } else {
    return null;
  }
}

Future notifyAtThreeQuaters(BuildContext context) {
  if (e.getMonthlyAmount() > (0.75 * i.getMonthlyAmount())) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Spending Notification!"),
            content: Text("You have spent 75% of your income."),
            actions: [
              FlatButton(child: Text("OK"), onPressed: () {}),
            ]);
      },
    );
  } else {
    return null;
  }
}
