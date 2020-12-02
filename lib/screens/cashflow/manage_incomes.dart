import 'package:flutter/material.dart';
import 'package:modoh/services/auth.dart';

class ManageIncomes extends StatefulWidget {
  @override
  _ManageIncomesState createState() => _ManageIncomesState();
}

class _ManageIncomesState extends State<ManageIncomes> {
  final List<String> amount = <String>[];

  TextEditingController amountController = TextEditingController();

  void addItemToList() {
    setState(() {
      amount.insert(0, amountController.text);
    });
  }

  void removeItemToList() {
    setState(() {
      amount.remove(amountController.text);
    });
  }

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
                      onPressed: () {
                        Navigator.pop(context);
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
                          onTap: () async {
                            await _auth.signOut();
                            print('Signed out!');
                            Navigator.pop(context);
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
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Income',
              ),
            ),
          ),
          RaisedButton(
            child: Text('ADD'),
            onPressed: () {
              addItemToList();
            },
          ),
          RaisedButton(
            child: Text('REMOVE'),
            onPressed: () {
              removeItemToList();
            },
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: amount.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      margin: EdgeInsets.all(2),
                      color: Colors.green,
                      child: Center(
                          child: Text(
                        '${amount[index]}',
                        style: TextStyle(fontSize: 18),
                      )),
                    );
                  }))
        ]));
  }
}
