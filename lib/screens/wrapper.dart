import 'package:flutter/material.dart';
import 'package:modoh/models/student.dart';
import 'package:modoh/screens/authenticate/home.dart';
import 'package:modoh/screens/cashflow/cashflow_wrapper.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Returns either LandingPage or Cashflow widget
    final student = Provider.of<Student>(context);
    if (student != null) {
      return CashflowWrapper(uid: student.uid);
    } else {
      return LandingPage();
    }
  }
}
