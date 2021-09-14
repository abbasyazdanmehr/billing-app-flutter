import 'package:flutter/cupertino.dart';

final String tableBankAccounts = 'bankaccounts';

class BankAccountsFields {
  static final List<String> values = [
    id,
    name,
    balance,
    created,
    description,
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String balance = 'balance';
  static final String created = 'created';
  static final String description = 'description';
}

class BankAccount {
  int id;
  String name;
  int balance = 0;
  DateTime created;
  String description;
  BankAccount({
    this.id,
    @required this.name,
    @required this.balance,
    @required this.created,
    this.description,
  });

  BankAccount copy({
    int id,
    String name,
    int balance = 0,
    DateTime created,
    String description,
  }) {
    return BankAccount(
      id: id,
      name: name,
      balance: balance,
      created: created,
      description: description,
    );
  }

  Map<String, Object> toJson() {
    return {
      BankAccountsFields.id: id,
      BankAccountsFields.name: name,
      BankAccountsFields.balance: balance,
      BankAccountsFields.created: created.toIso8601String(),
      BankAccountsFields.description: description,
    };
  }

  static BankAccount fromJson(Map<String, Object> json) {
    return BankAccount(
      id: json[BankAccountsFields.id] as int,
      name: json[BankAccountsFields.name] as String,
      balance: json[BankAccountsFields.balance] as int,
      created: DateTime.parse(json[BankAccountsFields.created] as String),
      description: json[BankAccountsFields.description] as String,
    );
  }

  addingBalance(int value) {
    this.balance += value;
  }
}
