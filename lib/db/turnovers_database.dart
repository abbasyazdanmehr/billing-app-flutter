import 'package:billing_app/models/bank_account.dart';
import 'package:billing_app/models/turnover.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' show join;
import 'dart:async';

class TurnoversDatabase {
  static final TurnoversDatabase instance = TurnoversDatabase._init();

  TurnoversDatabase._init();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB('turnovers.db');
    return _database;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableTurnovers (
      ${TurnoverFields.id} $idType,
      ${TurnoverFields.mount} $intType,
      ${TurnoverFields.bankAccountId} $intType,
      ${TurnoverFields.time} $textType,
      ${TurnoverFields.turnoverType} $intType,
      ${TurnoverFields.description} $textType,
      FOREIGN KEY(${TurnoverFields.bankAccountId}) 
      REFERENCES $tableBankAccounts(${BankAccountsFields.id})
      ON DELETE CASCADE
    )
    ''');
  }

  Future dropDB() async {
    final db = await instance.database;

    db.execute('''DROP TABLE IF EXISTS $tableTurnovers''');
  }

  Future<Turnover> createTurnover(Turnover turnover) async {
    final db = await instance.database;

    final id = await db.insert(tableTurnovers, turnover.toJson());
    return turnover.copy(id: id);
  }

  Future<Turnover> readTurnover(int id) async {
    final db = await instance.database;
    final turnoversMap = await db.query(
      tableTurnovers,
      columns: TurnoverFields.values,
      where: '${TurnoverFields.id} = ?',
      whereArgs: [id],
    );
    if (turnoversMap.isNotEmpty) {
      return Turnover.fromJson(turnoversMap.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<Turnover>> readAllTurnovers() async {
    final db = await instance.database;
    final result = await db.query(tableTurnovers);
    return result.map((json) => Turnover.fromJson(json)).toList();
  }

  Future<int> updateTurnover(Turnover turnover) async {
    final db = await instance.database;

    return db.update(tableTurnovers, turnover.toJson(),
        where: '${TurnoverFields.id} = ?', whereArgs: [turnover.id]);
  }

  Future<int> deleteTurnover(int id) async {
    final db = await instance.database;

    return db.delete(tableTurnovers,
        where: '${TurnoverFields.id} = ?', whereArgs: [id]);
  }
}
