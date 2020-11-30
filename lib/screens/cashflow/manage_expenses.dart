import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modoh/models/category.dart';
import 'package:modoh/models/expense.dart';
import 'package:modoh/models/frequency.dart';
import 'package:modoh/models/net_expenses.dart';
import 'package:modoh/screens/authenticate/home.dart';
import 'package:modoh/screens/authenticate/login.dart';
import 'package:modoh/screens/authenticate/signup.dart';

class ManageExpenses extends StatefulWidget {
  @override
  _ManageExpensesState createState() => _ManageExpensesState();
}

class _ManageExpensesState extends State<ManageExpenses> {
  NetExpenses _netExpenses;
  List<Expense> _expenseList;
  int _selectedIndex;
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  @override
  Widget build(BuildContext context) {
    setState(() {
      _netExpenses = new NetExpenses();
      _netExpenses.addExpense(
          1000000, Frequency.HALFANNUALLY, Category.UNIVERSITY, 'Tuition');
      _netExpenses.addExpense(22500, Frequency.MONTHLY, Category.CAR, 'Lease');
      _netExpenses.addExpense(45000, Frequency.MONTHLY, Category.RENT, 'Rent');
      _netExpenses.addExpense(2000, Frequency.BIWEEKLY, Category.GAS, 'Gas');
      _netExpenses.addExpense(
          1300, Frequency.MONTHLY, Category.ENTERTAINMENT, 'Netflix');
      _netExpenses.addExpense(
          20000, Frequency.HALFANNUALLY, Category.UTILITY, 'Electricity');
      _expenseList = _netExpenses.getNetExpenses();
    });
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: Container(
            color: Color(0xff37474f),
            child: Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 20,
                left: 20,
              ),
              child: Row(
                children: [
                  FlatButton(
                      child: Text(
                        'MODOH',
                        style: TextStyle(
                          color: Color(0xff8adc16),
                          fontSize: 30,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 3,
                        ),
                      ),
                      onPressed: () {
                        navigateToHome(context);
                      }),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onHover: (value) {
                            setState(() {
                              value
                                  ? _isHovering[0] = true
                                  : _isHovering[0] = false;
                            });
                          },
                          onTap: () {
                            navigateToHome(context);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Roboto',
                                  color: _isHovering[0]
                                      ? Colors.white
                                      : Color(0xff8adc16),
                                ),
                              ),
                              SizedBox(height: 5),
                              Visibility(
                                maintainAnimation: true,
                                maintainState: true,
                                maintainSize: true,
                                visible: _isHovering[0],
                                child: Container(
                                  height: 2,
                                  width: 20,
                                  color: Color(0xff8adc16),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: _netExpenses.size(),
            itemBuilder: (context, index) {
              Expense e = _expenseList[index];
              IconData categoryIcon = getIcon(e.getCategory());
              return Container(
                width: 500.0,
                child: ListTile(
                  enabled: true,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  selected: index == _selectedIndex,
                  selectedTileColor: Color(0xffe1e7ea),
                  leading: Column(
                    children: [
                      Icon(
                        categoryIcon,
                        color: Color(0xff37474f),
                        size: 24,
                      ),
                    ],
                  ),
                  title: Text(
                    e.getDescription(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: (_selectedIndex == index)
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                  subtitle: Text('\$' +
                      (e.getAmount() / 100).toStringAsFixed(2) +
                      ' paid ' +
                      e.getFrequency().toString().split('.')[1].toLowerCase()),
                  trailing: Text('\$' +
                      (e.getMonthlyAmount() / 100).toStringAsFixed(2) +
                      ' / month'),
                ),
              );
            },
          ),
        ));
  }

  Future navigateToSignUp(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  Future navigateToHome(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  Future navigateToLogIn(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }
}

IconData getIcon(Category c) {
  switch (c) {
    case Category.GROCERIES:
      return Icons.local_grocery_store;
    case Category.GAS:
      return Icons.local_gas_station;
    case Category.TRANSPORT:
      return Icons.local_taxi;
    case Category.ENTERTAINMENT:
      return Icons.local_movies;
    case Category.UTILITY:
      return Icons.bolt;
    case Category.MORTGAGE:
      return Icons.house;
    case Category.RENT:
      return Icons.apartment;
    case Category.UNIVERSITY:
      return Icons.school;
    case Category.CAR:
      return Icons.directions_car;
    case Category.SUBSCRIPTION:
      return Icons.subscriptions;
    case Category.OTHERS:
      return Icons.local_atm;
    default:
      return Icons.local_atm;
  }
}
