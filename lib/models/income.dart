import 'package:modoh/models/frequency.dart';

class Income {
  int amount;
  Frequency frequency;
  String description;
  int monthlyamount;
  bool isHidden;

  Income(int amount, Frequency frequency, String description) {
    this.amount = amount;
    this.frequency = frequency;
    this.description = description;
    isHidden = false;
    _convertAmounttoMonthly();
  }

  void _convertAmounttoMonthly() {
    monthlyamount = (amount * getMultiplier(frequency)).floor();
  }

  void setAmount(int amtInCents) {
    amount = amtInCents.isNegative ? amtInCents.abs() : amtInCents;
    _convertAmounttoMonthly();
  }

  int getAmount() {
    return amount;
  }

  void setDescription(String descrip) {
    description = descrip;
  }

  String getDescription() {
    return description;
  }

  void setFrequency(Frequency freq) {
    frequency = freq;
    _convertAmounttoMonthly();
  }

  Frequency getFrequency() {
    return frequency;
  }

  int getMonthlyAmount() {
    return monthlyamount;
  }

  void toggleVisibility() {
    isHidden = !isHidden;
  }

  bool ishidden() {
    return isHidden;
  }

  String toString() {
    return "$description : \n \t \$${(amount / 100).toStringAsFixed(2)} per $frequency \n \t \$${(monthlyamount / 100).toStringAsFixed(2)} per month.";
  }
}
