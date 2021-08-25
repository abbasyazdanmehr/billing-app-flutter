import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' show join;
import 'dart:async';
import 'package:billing_app/models/bill.dart';

class BillsDatabase {
  static final BillsDatabase instance = BillsDatabase._init();

  BillsDatabase._init();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB('bills.db');
    return _database;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableBills (
      ${BillFields.id} $idType,
      ${BillFields.mount} $intType,
      ${BillFields.description} $textType,
      ${BillFields.creditorName} $textType,
      ${BillFields.deadLine} $textType
    )
    ''');
  }

  Future<Bill> createBill(Bill bill) async {
    final db = await instance.database;

    final id = await db.insert(tableBills, bill.toJson());
    return bill.copy(id: id);
  }

  Future<Bill> readBill(int id) async {
    final db = await instance.database;
    final billMap = await db.query(
      tableBills,
      columns: BillFields.values,
      where: '${BillFields.id} = ?',
      whereArgs: [id],
    );
    if (billMap.isNotEmpty) {
      return Bill.fromJson(billMap.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<Bill>> readAllBills() async {
    final db = await instance.database;
    final result = await db.query(tableBills);
    return result.map((json) => Bill.fromJson(json)).toList();
  }

  Future<int> updateBill(Bill bill) async {
    final db = await instance.database;

    return db.update(tableBills, bill.toJson(),
        where: '${BillFields.id} = ?', whereArgs: [bill.id]);
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;

    return db
        .delete(tableBills, where: '${BillFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
