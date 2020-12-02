import 'package:app/income/frequency.dart';

class Income {
  
  double amount;
  Frequency frequency;
  String description;
  double monthlyamount;
  bool isHidden;

  Income(double amount, Frequency frequency, String description ){
    amount = amount;
    frequency = frequency;
    description = description;
    isHidden = false;
    convertAmounttoMonthly();
  }

  void convertAmounttoMonthly(){
       monthlyamount = (amount * getMultiplier(frequency)).floorToDouble();
  }

  void setAmount(double amtInCents){
      amount = amtInCents.isNegative ? amtInCents.abs() : amtInCents;
      convertAmounttoMonthly();
  }

  double getAmount(){
    return amount;
  }

  void setDescription( String descrip){
    description = descrip;
  }

  String getDescription(){
    return description;
  }

  void setFrequency( Frequency freq){
    frequency = freq;
    convertAmounttoMonthly();
  }
  Frequency getFrequency(){
    return frequency;
  }

  double getMonthlyAmount(){
    return monthlyamount;
  }

  void toggleVisibility(){
    isHidden = !isHidden;
  }

  bool ishidden(){
    return isHidden;
  }
    

    String toString(){
      return "$description : \n \t \$${(amount/100).toStringAsFixed(2)} per $frequency \n \t \$${(monthlyamount / 100).toStringAsFixed(2)} per month.";
    }

}
