enum Frequency {
  Daily, Halfweekly, Weekly, Biweekly, Monthly, Bimonthly, Trimonthly,
  Halfannually, Annually 
  
}

double getMultiplier(Frequency freq){
  double multiplier;
  switch (freq){
     case Frequency.Daily:
          multiplier = 30;
          break;
     case Frequency.Halfweekly:
           multiplier = 8;
           break;
     case Frequency.Weekly:
            multiplier = 4;
            break;
     case Frequency.Biweekly:
            multiplier = 2;
            break;
     case Frequency.Bimonthly:
            multiplier = 1.0 / 2.0;
            break;
     case Frequency.Trimonthly:
              multiplier = 1.0 / 3.0;
              break;
     case Frequency.Halfannually:
              multiplier = 1.0 / 6.0;
              break;
     case Frequency.Annually:
              multiplier = 1.0 / 12.0;
              break;
      default:
        multiplier = 1;

  }
   
  return multiplier;
}