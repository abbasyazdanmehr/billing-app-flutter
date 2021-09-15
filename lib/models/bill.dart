import 'package:flutter/cupertino.dart';

final String tableBills = 'bills';

class BillFields {
  static final List<String> values = [
    id,
    mount,
    description,
    creditorName,
    deadLine,
    isPayment,
  ];
  static final String id = '_id';
  static final String mount = 'mount';
  static final String description = 'description';
  static final String creditorName = 'creditorName';
  static final String deadLine = 'deadLine';
  static final String isPayment = 'isPayment';
}

class Bill {
  int id;
  int mount;
  String description;
  String creditorName;
  DateTime deadLine;
  bool isPayment;

  Bill({
    @required this.mount,
    @required this.creditorName,
    @required this.description,
    @required this.deadLine,
    @required this.isPayment,
    this.id,
  });

  Bill copy({
    int id,
    int mount,
    String description,
    String creditorName,
    DateTime deadLine,
    bool isPayment,
  }) {
    return Bill(
      id: id,
      mount: mount,
      description: description,
      creditorName: creditorName,
      deadLine: deadLine,
      isPayment: isPayment,
    );
  }

  Map<String, Object> toJson() {
    return {
      BillFields.id: id,
      BillFields.mount: mount,
      BillFields.description: description,
      BillFields.creditorName: creditorName,
      BillFields.deadLine: deadLine.toIso8601String(),
      BillFields.isPayment: isPayment ? 1 : 0
    };
  }

  static Bill fromJson(Map<String, Object> json) {
    return Bill(
      id: json[BillFields.id] as int,
      mount: json[BillFields.mount] as int,
      description: json[BillFields.description] as String,
      creditorName: json[BillFields.creditorName] as String,
      deadLine: DateTime.parse(json[BillFields.deadLine] as String),
      isPayment: json[BillFields.isPayment] == 1,
    );
  }

  changeIsPayment() {
    this.isPayment = !this.isPayment;
  }
}
