import 'package:flutter/material.dart';
import 'package:modoh/models/budget.dart';
import 'package:modoh/models/frequency.dart';
import 'package:modoh/models/income.dart';
import 'package:modoh/models/net_income.dart';
import 'package:modoh/models/student.dart';
import 'package:modoh/services/auth.dart';
import 'package:modoh/services/database.dart';
import 'package:provider/provider.dart';

class ManageIncome extends StatefulWidget {
  @override
  _ManageIncomeState createState() => _ManageIncomeState();
}

class _ManageIncomeState extends State<ManageIncome> {
  final AuthService _auth = AuthService();
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
    Student _user = Provider.of<Student>(context);
    Budget _budget = Provider.of<Budget>(context);
    NetIncome _netIncome = _budget.getListOfIncomes();
    _netIncome.sortIncomebyMonthlyAmount();
    List<Income> _incomeList = _netIncome.getNetIncome();
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
      body: Stack(children: [
        Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage("lib/assets/images/expenses.png"),
                  fit: BoxFit.fitWidth)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 62,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xff37474f),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Center(
                    child: Text(
                  'Income Dashboard',
                  style: TextStyle(
                      color: Color(0xff8adc16),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                )),
              ),
              Expanded(
                flex: 4,
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(5, 8, 5, 5),
                  itemCount: _netIncome.size(),
                  itemBuilder: (context, index) {
                    Color _color =
                        index.isOdd ? Colors.grey[200] : Colors.grey[300];
                    Income i = _incomeList[index];
                    IconData icon = Icons.money;
                    return Container(
                      color: _color,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            if (_selectedIndex == index) {
                              _selectedIndex = -1;
                            } else {
                              _selectedIndex = index;
                            }
                          });
                        },
                        selected: index == _selectedIndex,
                        selectedTileColor: Color(0x7737474f),
                        leading: Icon(icon,
                            color: index == _selectedIndex
                                ? Colors.white
                                : Color(0xff37474f)),
                        title: Text(i.getDescription(),
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                color: index == _selectedIndex
                                    ? Colors.white
                                    : Color(0xff37474f))),
                        subtitle: Text(
                          '\$' +
                              (i.getAmount() / 100).toStringAsFixed(2) +
                              ' paid ' +
                              i
                                  .getFrequency()
                                  .toString()
                                  .split('.')[1]
                                  .toLowerCase(),
                          style: TextStyle(
                              color: index == _selectedIndex
                                  ? Colors.white
                                  : Color(0xff37474f)),
                        ),
                        trailing: Text(
                          !i.ishidden()
                              ? '\$' +
                                  (i.getMonthlyAmount() / 100)
                                      .toStringAsFixed(2) +
                                  ' / month'
                              : '',
                          style: TextStyle(
                              color: _selectedIndex == index
                                  ? Colors.white
                                  : Color(0xff37474f)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RaisedButton(
                            color: Colors.lightGreen[300],
                            child: Text('Add Sample Incomes'),
                            onPressed: () async {
                              setState(() {
                                _netIncome.addIncome(
                                    65000 * 100,
                                    Frequency.ANNUALLY,
                                    'Software Engineering Career');
                                _netIncome.addIncome(2400 * 100,
                                    Frequency.TRIMONTHLY, 'Side Hustle');
                                _netIncome.sortIncomebyMonthlyAmount();
                              });
                              await DatabaseService(uid: _user.uid)
                                  .updateUserData(_budget);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            color: Colors.lightGreen[300],
                            child: Text('Add New Income'),
                            onPressed: () {
                              final List<Frequency> frequencies =
                                  Frequency.values;

                              String _description;
                              int _amountInCents;
                              Frequency _frequency;
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      color: Color(0x5537474f),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 60.0),
                                      child: Form(
                                        // key: _formKey,
                                        child: Column(
                                          children: [
                                            Text(
                                              'Create a new Income',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'How would you describe this income?',
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .white,
                                                              width: 2.0)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xcc37474f),
                                                              width: 2.0))),
                                              validator: (val) => val.isEmpty
                                                  ? 'Please enter a description'
                                                  : null,
                                              onChanged: (val) => setState(
                                                  () => _description = val),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'How much is does this income pay? (Exclude the \$)',
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .white,
                                                              width: 2.0)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xcc37474f),
                                                              width: 2.0))),
                                              validator: (val) => double.parse(
                                                          val) >
                                                      0.0
                                                  ? 'Please enter a valid number.'
                                                  : null,
                                              onChanged: (val) => setState(() =>
                                                  _amountInCents =
                                                      (double.parse(val) * 100)
                                                          as int),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            DropdownButtonFormField(
                                                hint: Text(
                                                    'How often do you pay above amount?'),
                                                onChanged: (val) {
                                                  setState(() {
                                                    _frequency = val;
                                                  });
                                                },
                                                items: frequencies.map((freq) {
                                                  return DropdownMenuItem(
                                                    value: freq,
                                                    child: Text(
                                                        'Received ${freq.toString().split('.')[1].toLowerCase()}'),
                                                  );
                                                }).toList()),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RaisedButton(
                                                color: Colors.lightGreen[300],
                                                child: Text('Create'),
                                                onPressed: () async {
                                                  setState(() {
                                                    _netIncome.addIncome(
                                                        _amountInCents ?? 1000,
                                                        _frequency ??
                                                            Frequency.MONTHLY,
                                                        _description ??
                                                            'Template');
                                                    _netIncome
                                                        .sortIncomebyMonthlyAmount();
                                                  });
                                                  await DatabaseService(
                                                          uid: _user.uid)
                                                      .updateUserData(_budget);
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            color: Colors.lightGreen[300],
                            child: Text('Remove Income'),
                            onPressed: (_netIncome.size() > 0)
                                ? () async {
                                    setState(() {
                                      if (_selectedIndex != null &&
                                          _selectedIndex >= 0 &&
                                          _selectedIndex < _netIncome.size()) {
                                        _netIncome.removeIncome(
                                            _incomeList[_selectedIndex]);
                                      }
                                    });
                                    await DatabaseService(uid: _user.uid)
                                        .updateUserData(_budget);
                                  }
                                : null,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            color: Colors.lightGreen[300],
                            child: Text('Toggle Income'),
                            onPressed: (_netIncome.size() > 0)
                                ? () async {
                                    setState(() {
                                      if (_selectedIndex != null &&
                                          _selectedIndex >= 0 &&
                                          _selectedIndex < _netIncome.size()) {
                                        _netIncome.toggleIncome(
                                            _incomeList[_selectedIndex]);
                                      }
                                    });
                                    await DatabaseService(uid: _user.uid)
                                        .updateUserData(_budget);
                                  }
                                : null,
                          )
                        ],
                      ),
                      Text(
                        '\$' +
                            (_netIncome.getNetIncomeMonthlyAmount() / 100)
                                .toStringAsFixed(2) +
                            ' / month',
                        style: TextStyle(
                            backgroundColor: Colors.white,
                            color: Color(0xff37474f),
                            fontFamily: 'Roboto',
                            fontSize: 24),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
