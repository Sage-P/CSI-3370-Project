enum Frequency {
  DAILY,
  HALFWEEKLY,
  WEEKLY,
  BIWEEKLY,
  MONTHLY,
  BIMONTHLY,
  TRIMONTHLY,
  HALFANNUALLY,
  ANNUALLY
}

double getMultiplier(Frequency freq) {
  double multiplier;
  switch (freq) {
    case Frequency.DAILY:
      multiplier = 30;
      break;
    case Frequency.HALFWEEKLY:
      multiplier = 8;
      break;
    case Frequency.WEEKLY:
      multiplier = 4;
      break;
    case Frequency.BIWEEKLY:
      multiplier = 2;
      break;
    case Frequency.BIMONTHLY:
      multiplier = 1.0 / 2.0;
      break;
    case Frequency.TRIMONTHLY:
      multiplier = 1.0 / 3.0;
      break;
    case Frequency.HALFANNUALLY:
      multiplier = 1.0 / 6.0;
      break;
    case Frequency.ANNUALLY:
      multiplier = 1.0 / 12.0;
      break;
    default:
      multiplier = 1; // Defaults to monthly
  }
  return multiplier;
}
