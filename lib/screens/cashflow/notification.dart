import 'package:flutter/material.dart';

Future sendSpendingNotification(int percentThreshold, BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text("Spending Notification!"),
          content:
              Text("You have spent over $percentThreshold% of your income."),
          actions: [
            FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ]);
    },
  );
}
