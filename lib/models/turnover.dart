import 'package:billing_app/enums/turnover_type.dart';
import 'package:flutter/cupertino.dart';

final String tableTurnovers = 'turnovers';

class TurnoverFields {
  static final List<String> values = [
    id,
    mount,
    bankAccountId,
    time,
    turnoverType,
    description,
  ];
  static final String id = '_id';
  static final String mount = 'mount';
  static final String bankAccountId = 'bankAccountId';
  static final String time = 'time';
  static final String turnoverType = 'turnoverType';
  static final String description = 'description';
}

class Turnover {
  int id;
  int mount;
  int bankAccountId;
  DateTime time;
  TurnoverType turnoverType = TurnoverType.All;
  String description;
  Turnover({
    this.id,
    @required this.mount,
    this.bankAccountId,
    this.time,
    @required this.turnoverType,
    this.description,
  });

  Turnover copy({
    int id,
    int mount,
    int bankAccountId,
    DateTime time,
    TurnoverType turnoverType = TurnoverType.All,
    String description,
  }) {
    return Turnover(
      id: id,
      mount: mount,
      bankAccountId: bankAccountId,
      time: time,
      turnoverType: turnoverType,
      description: description,
    );
  }

  Map<String, Object> toJson() {
    return {
      TurnoverFields.id: id,
      TurnoverFields.mount: mount,
      TurnoverFields.bankAccountId: bankAccountId,
      TurnoverFields.time: time.toIso8601String(),
      TurnoverFields.turnoverType: turnoverType,
      TurnoverFields.description: description,
    };
  }

  static Turnover fromJson(Map<String, Object> json) {
    return Turnover(
      id: json[TurnoverFields.id] as int,
      mount: json[TurnoverFields.mount] as int,
      bankAccountId: json[TurnoverFields.bankAccountId] as int,
      time: DateTime.parse(json[TurnoverFields.time] as String),
      turnoverType: json[TurnoverFields.turnoverType] as TurnoverType,
      description: json[TurnoverFields.description] as String,
    );
  }
}
