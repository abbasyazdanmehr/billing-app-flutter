import 'package:billing_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class Bill {
  int mount;
  String description;
  DateTime deadLine;
  User creditor;
  Bill({@required this.mount, this.description, this.deadLine, this.creditor});
}
