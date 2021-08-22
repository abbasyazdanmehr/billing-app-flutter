import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/models/bank_account.dart';
import 'package:billing_app/models/user.dart';
import 'package:flutter/cupertino.dart';

//تراکنش یا گردش حساب
class Turnover {
  int id;
  int mount;
  BankAccount bankAccount;
  String description;
  DateTime time;
  TurnoverType turnoverType;
  User from;
  User to;
  Turnover(
      {@required this.mount,
      this.bankAccount,
      this.description,
      this.time,
      this.turnoverType,
      this.from,
      this.to,
      this.id});
}