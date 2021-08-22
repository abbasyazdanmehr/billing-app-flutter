import 'package:billing_app/models/bank_account.dart';
import 'package:flutter/cupertino.dart';

class User {
  int id;
  String username;
  String password;
  BankAccount account;
  User(
      {@required this.username,
      @required this.password,
      this.account,
      this.id});
}
