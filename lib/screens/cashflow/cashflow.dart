import 'package:flutter/material.dart';
import 'package:modoh/models/budget.dart';
import 'package:modoh/screens/cashflow/manage_expenses.dart';
import 'package:modoh/screens/cashflow/manage_incomes.dart';
import 'package:modoh/services/auth.dart';
import 'package:provider/provider.dart';

class Cashflow extends StatefulWidget {
  @override
  _CashflowState createState() => _CashflowState();
}

class _CashflowState extends State<Cashflow> {
  int _cashFlowAmount;
  final AuthService _auth = new AuthService();
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
    final Budget _budget = Provider.of<Budget>(context) ?? new Budget();

    if (_budget != null) {
      setState(() {
        _cashFlowAmount = _budget.getNetMonthlyCashFlow();
      });
    }

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                    onPressed: () {}),
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
                        onTap: () async {
                          await _auth.signOut();
                          print('Signed out!');
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              child: Center(
                  child: Text(
                '${_budget.toString().split('\n')[0]}',
                style: TextStyle(
                    fontSize: 40,
                    color: (_cashFlowAmount > 0) ? Colors.green : Colors.red),
              )),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageIncomes()));
                      },
                      child: Container(
                          child: Center(
                              child: Text(
                        'Manage Incomes',
                        style: TextStyle(fontSize: 24),
                      ))),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (_) => ManageExpenses()));
                      },
                      child: Container(
                          child: Center(
                              child: Text(
                        'Manage Expenses',
                        style: TextStyle(fontSize: 24),
                      ))),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
