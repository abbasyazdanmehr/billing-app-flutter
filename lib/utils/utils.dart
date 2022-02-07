String getTurnoverType(int index) {
  if (index == 0) {
    return "Income";
  } else if (index == 1) {
    return "Cost";
  } else if (index == 2) {
    return "FutureCost";
  } else {
    return "All";
  }
}
