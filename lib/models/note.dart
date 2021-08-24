import 'package:flutter/cupertino.dart';

final String tableNote = 'notes';

class NoteFields {
  static final List<String> values = [
    id,
    number,
    title,
    description,
    isImportant,
  ];
  static final String id = '_id';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String isImportant = 'isImportant';
}

class Note {
  final int id;
  final int number;
  final String title;
  final String description;
  final bool isImportant;

  Note(
      {this.id,
      @required this.number,
      @required this.title,
      @required this.description,
      @required this.isImportant});

  Map<String, Object> toJson() => {
        NoteFields.id: id,
        NoteFields.number: number,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.isImportant: isImportant ? 1 : 0,
      };

  Note copy({
    int id,
    int number,
    String title,
    String description,
    bool isImportant,
  }) =>
      Note(
          id: id,
          number: number,
          title: title,
          description: description,
          isImportant: isImportant);

  static Note fromJson(Map<String, Object> json) => Note(
      id: json[NoteFields.id] as int,
      number: json[NoteFields.number] as int,
      title: json[NoteFields.title] as String,
      description: json[NoteFields.description] as String,
      isImportant: json[NoteFields.isImportant] == 1);
}
