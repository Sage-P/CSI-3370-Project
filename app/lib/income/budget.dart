import 'package:app/income/net_income.dart';


class Budget {
  NetIncome netIncome;
  double netMonthlyIncome;
  double threshold;
  Budget(){
    netIncome = new NetIncome();
    netMonthlyIncome = 0;
    calculatenetMonthlyincome();
  }

  void calculatenetMonthlyincome(){
    netMonthlyIncome = 0 + netIncome.getNetIncomeMothlyAmount();
  }

 
  String toString(){
    return netMonthlyIncome.toString() + '\n' + netIncome.toString();
  }
}