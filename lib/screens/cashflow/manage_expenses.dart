import 'package:flutter/material.dart';
import 'package:modoh/models/budget.dart';
import 'package:modoh/models/category.dart';
import 'package:modoh/models/expense.dart';
import 'package:modoh/models/frequency.dart';
import 'package:modoh/models/net_expenses.dart';
import 'package:modoh/models/student.dart';
import 'package:modoh/screens/authenticate/home.dart';
import 'package:modoh/screens/authenticate/login.dart';
import 'package:modoh/screens/authenticate/signup.dart';
import 'package:modoh/services/auth.dart';
import 'package:modoh/services/database.dart';
import 'package:provider/provider.dart';

class ManageExpenses extends StatefulWidget {
  @override
  _ManageExpensesState createState() => _ManageExpensesState();
}

class _ManageExpensesState extends State<ManageExpenses> {
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
    NetExpenses _netExpenses = _budget.getListOfExpenses();
    _netExpenses.sortExpensesByMonthlyAmount();
    List<Expense> _expenseList = _netExpenses.getNetExpenses();
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
                    'Expenses Dashboard',
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
                    itemCount: _netExpenses.size(),
                    itemBuilder: (context, index) {
                      Color _color =
                          index.isOdd ? Colors.grey[200] : Colors.grey[300];
                      Expense e = _expenseList[index];
                      IconData categoryIcon = getIcon(e.getCategory());
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
                          leading: Icon(categoryIcon,
                              color: index == _selectedIndex
                                  ? Colors.white
                                  : Color(0xff37474f)),
                          title: Text(e.getDescription(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  color: index == _selectedIndex
                                      ? Colors.white
                                      : Color(0xff37474f))),
                          subtitle: Text(
                            '\$' +
                                (e.getAmount() / 100).toStringAsFixed(2) +
                                ' paid ' +
                                e
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
                            !e.isHidden()
                                ? '\$' +
                                    (e.getMonthlyAmount() / 100)
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
                              child: Text('Add Sample Expenses'),
                              onPressed: () async {
                                setState(() {
                                  _netExpenses.addExpense(
                                      1000000,
                                      Frequency.HALFANNUALLY,
                                      Category.UNIVERSITY,
                                      'Tuition');
                                  _netExpenses.addExpense(22500,
                                      Frequency.MONTHLY, Category.CAR, 'Lease');
                                  _netExpenses.addExpense(45000,
                                      Frequency.MONTHLY, Category.RENT, 'Rent');
                                  _netExpenses.addExpense(2000,
                                      Frequency.BIWEEKLY, Category.GAS, 'Gas');
                                  _netExpenses.addExpense(
                                      1300,
                                      Frequency.MONTHLY,
                                      Category.ENTERTAINMENT,
                                      'Netflix');
                                  _netExpenses.addExpense(
                                      20000,
                                      Frequency.HALFANNUALLY,
                                      Category.UTILITY,
                                      'Electricity');
                                  _netExpenses.sortExpensesByMonthlyAmount();
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
                              child: Text('Add New Expense'),
                              onPressed: () {
                                final List<Frequency> frequencies =
                                    Frequency.values;
                                final List<Category> categories =
                                    Category.values;

                                String _description;
                                int _amountInCents;
                                Frequency _frequency;
                                Category _category;
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
                                                'Create a new Expense',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'How would you describe this expense?',
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white,
                                                                    width:
                                                                        2.0)),
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
                                                        'How much is your expense? (Exclude the \$)',
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white,
                                                                    width:
                                                                        2.0)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xcc37474f),
                                                                width: 2.0))),
                                                validator: (val) => double
                                                            .parse(val) >
                                                        0.0
                                                    ? 'Please enter a valid number.'
                                                    : null,
                                                onChanged: (val) => setState(
                                                    () => _amountInCents =
                                                        (double.parse(val) *
                                                            100) as int),
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
                                                  items:
                                                      frequencies.map((freq) {
                                                    return DropdownMenuItem(
                                                      value: freq,
                                                      child: Text(
                                                          'Paid ${freq.toString().split('.')[1].toLowerCase()}'),
                                                    );
                                                  }).toList()),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              DropdownButtonFormField(
                                                  hint: Text(
                                                      'How would you categorize this expense?'),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _category = val;
                                                    });
                                                  },
                                                  items: categories.map((cate) {
                                                    return DropdownMenuItem(
                                                      value: cate,
                                                      child: Text(
                                                          '${cate.toString().split('.')[1]}'),
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
                                                      _netExpenses.addExpense(
                                                          _amountInCents ??
                                                              1000,
                                                          _frequency ??
                                                              Frequency.MONTHLY,
                                                          _category ??
                                                              Category.OTHERS,
                                                          _description ??
                                                              'Template');
                                                      _netExpenses
                                                          .sortExpensesByMonthlyAmount();
                                                    });
                                                    await DatabaseService(
                                                            uid: _user.uid)
                                                        .updateUserData(
                                                            _budget);
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
                              child: Text('Remove Expense'),
                              onPressed: (_netExpenses.size() > 0)
                                  ? () async {
                                      setState(() {
                                        if (_selectedIndex != null &&
                                            _selectedIndex >= 0 &&
                                            _selectedIndex <
                                                _netExpenses.size()) {
                                          _netExpenses.removeExpense(
                                              _expenseList[_selectedIndex]);
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
                              child: Text('Toggle Expense'),
                              onPressed: (_netExpenses.size() > 0)
                                  ? () async {
                                      setState(() {
                                        if (_selectedIndex != null &&
                                            _selectedIndex >= 0 &&
                                            _selectedIndex <
                                                _netExpenses.size()) {
                                          _netExpenses.toggleExpense(
                                              _expenseList[_selectedIndex]);
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
                              (_netExpenses.getNetExpensesMonthlyAmount() / 100)
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
        ]));
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
      return Icons.live_tv;
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
