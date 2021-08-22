import 'package:billing_app/models/bank_account.dart';
import 'package:flutter/cupertino.dart';

class Cost {
  int mount;
  BankAccount bankAccount;
  String description;
  DateTime time;
  Cost({@required this.mount, this.bankAccount, this.description});
}
