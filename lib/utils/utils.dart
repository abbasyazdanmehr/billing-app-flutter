String getTurnoverType(int index) {
  if (index == 0) {
    return "Income";
  } else if (index == 2) {
    return "Cost";
  } else if (index == 3) {
    return "FutureCost";
  } else {
    return "All";
  }
}
