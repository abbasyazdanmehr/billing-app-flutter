import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/db/notes_database.dart';
import 'package:billing_app/models/note.dart';
import 'package:billing_app/views/profile_views/add_note_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesListView extends StatefulWidget {
  @override
  _NotesListViewState createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  List<Note> notes = [];

  Future refreshNote() async {
    setState(() {});
    this.notes = await NoteDatabase.instance.readAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IconButton(
                onPressed: () {
                  Get.to(AddNoteView());
                },
                icon: Icon(Icons.add_rounded)),
            for (var i = 0; i < notes.length; i++) Text(notes[i].id.toString())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await refreshNote();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
