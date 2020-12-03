import 'package:modoh/models/category.dart';
import 'package:modoh/models/frequency.dart';

class Expense {
  int _amount; // Expense amount in cents
  String _description;
  Frequency _frequency;
  Category _category;
  int _monthlyAmount; // Expense amount as monthly in cents
  bool _isHidden;

  Expense(int amountInCents, Frequency frequency, Category category,
      String description) {
    _amount = amountInCents;
    _frequency = frequency;
    _category = category;
    _description = description;
    _isHidden = false;
    _convertAmountToMonthly();
  }

  void _convertAmountToMonthly() {
    _monthlyAmount = (_amount * getMultiplier(_frequency)).floor();
  }

  void setAmount(int amtInCents) {
    _amount = amtInCents.isNegative ? amtInCents.abs() : amtInCents;
    _convertAmountToMonthly();
  }

  int getAmount() {
    return _amount;
  }

  void setDescription(String desc) {
    _description = desc;
  }

  String getDescription() {
    return _description;
  }

  void setFrequency(Frequency freq) {
    _frequency = freq;
    _convertAmountToMonthly();
  }

  Frequency getFrequency() {
    return _frequency;
  }

  void setCategory(Category cate) {
    _category = cate;
  }

  Category getCategory() {
    return _category;
  }

  int getMonthlyAmount() {
    return _monthlyAmount;
  }

  void toggleVisibility() {
    _isHidden = !_isHidden;
  }

  bool isHidden() {
    return _isHidden;
  }

  Map<String, dynamic> toMap() {
    String _frequencyString = _frequency.toString().split('.')[1];
    String _categoryString = _category.toString().split('.')[1];
    return {
      'amount-in-cents': _amount,
      'description': _description,
      'frequency': _frequencyString,
      'category': _categoryString,
      'monthly-amount-in-cents': _monthlyAmount,
      'is-hidden': _isHidden,
    };
  }

  String toString() {
    return "$_description ($_category):\n\t \$${(_amount / 100).toStringAsFixed(2)} per $_frequency \n\t \$${(_monthlyAmount / 100).toStringAsFixed(2)} per month";
  }
}
