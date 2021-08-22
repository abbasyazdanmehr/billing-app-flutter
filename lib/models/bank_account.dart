import 'package:billing_app/models/report.dart';
import 'package:billing_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class BankAccount {
  String name;
  int deposit = 0;
  User user;
  List<Report> reports = [];
  BankAccount(
      {@required this.name, @required this.deposit, this.user, this.reports});
}
