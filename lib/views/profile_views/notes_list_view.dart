import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/db/notes_database.dart';
import 'package:billing_app/models/note.dart';
import 'package:billing_app/views/profile_views/add_note_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
    Widget accountContent(index) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                notes[index].title,
                style: TextStyle(fontSize: 22.sp),
              ),
              notes[index].isImportant
                  ? Icon(Icons.star)
                  : Icon(Icons.star_border),
            ],
          ),
        ),
      );
    }

    block(index) {
      return Constants.responsiveGlassBlock(
          context: context,
          heightRatio: 0.1,
          widthRatio: 0.95,
          content: accountContent(index));
    }

    // List<Widget> childs = [
    //   for (var i = 0; i < notes.length; i++) Text(notes[i].title),
    // ];

    return Scaffold(
      appBar: Constants.customAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await refreshNote();
        },
        child: ListView(
          children: List.generate(notes.length, (index) => block(index)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(AddNoteView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
