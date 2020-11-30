import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Income Tracker'),
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
