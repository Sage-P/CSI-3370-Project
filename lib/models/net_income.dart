import 'package:modoh/models/frequency.dart';
import 'package:modoh/models/income.dart';

class NetIncome {
  List<Income> netincome;

  NetIncome() {
    netincome = new List<Income>();
  }

  List<Income> getNetIncome() {
    return netincome;
  }

  int getNetIncomeMonthlyAmount() {
    int sum = 0;
    for (Income i in netincome) {
      if (!i.ishidden()) {
        sum += i.getMonthlyAmount();
      }
    }
    return sum;
  }

  bool isEmpty() {
    return netincome.isEmpty;
  }

  int size() {
    return netincome.length;
  }

  Income addIncome(int amount, Frequency frequency, String description) {
    Income newIncome = new Income(amount, frequency, description);
    netincome.add(newIncome);
    return newIncome;
  }

  bool removeIncome(Income i) {
    return netincome.remove(i);
  }

  void sortIncomebyAmount() {
    netincome
        .sort((Income a, Income b) => b.getAmount().compareTo(a.getAmount()));
  }

  void sortIncomebyMonthlyAmount() {
    netincome.sort((Income a, Income b) =>
        b.getMonthlyAmount().compareTo(a.getMonthlyAmount()));
  }

  void toggleIncome(Income i) {
    i.toggleVisibility();
  }

  String toString() {
    String s = ' ';

    for (Income i in netincome) {
      if (i.ishidden()) {
        s += "[HIDDEN]";
      }

      s += i.toString() + '\n';
    }
    s += '\n Net Income per Month: \$' +
        (getNetIncomeMonthlyAmount() / 100).toStringAsFixed(2);
    return s;
  }
}
