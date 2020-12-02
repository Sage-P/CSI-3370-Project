import 'package:flutter/material.dart';
import 'package:modoh/screens/cashflow/manage_expenses.dart';
import 'package:modoh/screens/cashflow/manage_incomes.dart';
import 'package:modoh/services/auth.dart';

class Cashflow extends StatefulWidget {
  @override
  _CashflowState createState() => _CashflowState();
}

class _CashflowState extends State<Cashflow> {
  @override
  Widget build(BuildContext context) {
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
        child: Row(
          children: [
            Expanded(
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ManageIncomes()));
                },
                child: Container(
                    height: screenSize.height,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ManageExpenses()));
                },
                child: Container(
                    height: screenSize.height,
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
    );
  }
}
