import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/models/bank_account.dart';
import 'package:flutter/cupertino.dart';

class Turnover {
  int mount;
  BankAccount bankAccount;
  String description;
  DateTime time;
  TurnoverType turnoverType;
  Turnover(
      {@required this.mount,
      this.bankAccount,
      this.description,
      this.time,
      this.turnoverType});
}
