

import 'dart:js';

import 'package:app/income/budget.dart';
import 'package:app/income/income.dart';
import 'package:flutter/material.dart';
import 'package:modoh/models/expense.dart';

 
    Income i;
    Expense e;

Future notifyAtQuater(BuildContext context){
    if(e.getMonthlyAmount() > (0.25 * i.getMonthlyAmount())){
        return showDialog(
          context: context,
          builder: (BuildContext context){

            AlertDialog(
          title: Text("Spending Notification!"),
          content: Text("You have spent 25% of your income."),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed:() { }
              ),
            ]
            );  

          },
          );
    }
}

Future notifyAtHalf(BuildContext context){
    if(e.getMonthlyAmount() > (0.50 * i.getMonthlyAmount())){
        return showDialog(
          context: context,
          builder: (BuildContext context){

            AlertDialog(
          title: Text("Spending Notification!"),
          content: Text("You have spent 50% of your income."),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed:() { }
              ),
            ]
            );  

          },
          );
    }
}

Future notifyAtThreeQuaters(BuildContext context){
    if(e.getMonthlyAmount() > (0.75 * i.getMonthlyAmount())){
        return showDialog(
          context: context,
          builder: (BuildContext context){

            AlertDialog(
          title: Text("Spending Notification!"),
          content: Text("You have spent 75% of your income."),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed:() { }
              ),
            ]
            );  

          },
          );
    }
}
          





