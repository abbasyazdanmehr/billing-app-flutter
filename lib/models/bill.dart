import 'package:flutter/cupertino.dart';

final String tableBills = 'bills';

class BillFields {
  static final List<String> values = [
    id,
    mount,
    description,
    creditorName,
    deadLine,
  ];
  static final String id = '_id';
  static final String mount = 'mount';
  static final String description = 'description';
  static final String creditorName = 'creditorName';
  static final String deadLine = 'deadLine';
}

class Bill {
  int id;
  int mount;
  String description;
  String creditorName;
  DateTime deadLine;

  Bill(
      {@required this.mount,
      @required this.creditorName,
      @required this.description,
      @required this.deadLine,
      this.id});

  Bill copy({
    int id,
    int mount,
    String description,
    String creditorName,
    DateTime deadLine,
  }) {
    return Bill(
      id: id,
      mount: mount,
      description: description,
      creditorName: creditorName,
      deadLine: deadLine,
    );
  }

  Map<String, Object> toJson() {
    return {
      BillFields.id: id,
      BillFields.mount: mount,
      BillFields.description: description,
      BillFields.creditorName: creditorName,
      BillFields.deadLine: deadLine.toIso8601String(),
    };
  }

  static Bill fromJson(Map<String, Object> json) {
    return Bill(
      id: json[BillFields.id] as int,
      mount: json[BillFields.mount] as int,
      description: json[BillFields.description] as String,
      creditorName: json[BillFields.creditorName] as String,
      deadLine: DateTime.parse(json[BillFields.deadLine] as String),
    );
  }
}
