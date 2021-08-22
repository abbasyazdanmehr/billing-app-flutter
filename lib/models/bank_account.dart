import 'package:billing_app/models/report.dart';
import 'package:billing_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class BankAccount {
  String name;
  int balance = 0;
  String description;
  User user;
  List<Report> reports = [];
  BankAccount(
      {@required this.name,
      @required this.balance,
      this.user,
      this.reports,
      this.description});
}
