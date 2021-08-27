import 'package:billing_app/models/bank_account.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' show join;
import 'dart:async';

class BankAccountsDatabase {
  static final BankAccountsDatabase instance = BankAccountsDatabase._init();

  BankAccountsDatabase._init();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB('bankaccounts.db');
    return _database;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableBankAccounts (
      ${BankAccountsFields.id} $idType,
      ${BankAccountsFields.name} $textType,
      ${BankAccountsFields.balance} $intType,
      ${BankAccountsFields.created} $textType,
      ${BankAccountsFields.description} $textType
    )
    ''');
  }

  Future<BankAccount> createBankAccount(BankAccount bankAccount) async {
    final db = await instance.database;

    final id = await db.insert(tableBankAccounts, bankAccount.toJson());
    return bankAccount.copy(id: id);
  }

  Future<BankAccount> readBankAccount(int id) async {
    final db = await instance.database;
    final bankAccountMap = await db.query(
      tableBankAccounts,
      columns: BankAccountsFields.values,
      where: '${BankAccountsFields.id} = ?',
      whereArgs: [id],
    );
    if (bankAccountMap.isNotEmpty) {
      return BankAccount.fromJson(bankAccountMap.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<BankAccount>> readAllBankAccount() async {
    final db = await instance.database;
    final result = await db.query(tableBankAccounts);
    return result.map((json) => BankAccount.fromJson(json)).toList();
  }

  Future<int> updateBankAccount(BankAccount bankAccount) async {
    final db = await instance.database;

    return db.update(tableBankAccounts, bankAccount.toJson(),
        where: '${BankAccountsFields.id} = ?', whereArgs: [bankAccount.id]);
  }

  Future<int> deleteBankAccount(int id) async {
    final db = await instance.database;

    return db.delete(tableBankAccounts,
        where: '${BankAccountsFields.id} = ?', whereArgs: [id]);
  }
}
