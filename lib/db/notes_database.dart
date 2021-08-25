import 'package:billing_app/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' show join;
import 'dart:async';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  NoteDatabase._init();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB('note.db');
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
    CREATE TABLE $tableNote (
      ${NoteFields.id} $idType,
      ${NoteFields.number} $intType,
      ${NoteFields.title} $textType,
      ${NoteFields.description} $textType,
      ${NoteFields.isImportant} $boolType
    )
    ''');
  }

  Future<Note> createNote(Note note) async {
    final db = await instance.database;

    final id = await db.insert(tableNote, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;
    final noteMap = await db.query(
      tableNote,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
    if (noteMap.isNotEmpty) {
      return Note.fromJson(noteMap.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final result = await db.query(tableNote);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await instance.database;

    return db.update(tableNote, note.toJson(),
        where: '${NoteFields.id} = ?', whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;

    return db.delete(tableNote, where: '${NoteFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
