import 'package:flutter/cupertino.dart';

class Bill {
  int id;
  int mount;
  String description;
  String creditorName;
  DateTime deadLine;

  Bill(
      {@required this.mount,
      @required this.creditorName,
      this.description,
      this.deadLine,
      this.id});
}
