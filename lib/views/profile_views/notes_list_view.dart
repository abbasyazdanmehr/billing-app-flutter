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
    this.notes = await NotesDatabase.instance.readAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(int index) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Description"),
            content: SingleChildScrollView(
              child: Text(notes[index].description),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Widget blockContent(index) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    _showMyDialog(index);
                  },
                  child: Text(
                    notes[index].title,
                    style: TextStyle(
                      fontSize: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
            notes[index].isImportant
                ? Icon(Icons.star)
                : Icon(Icons.star_border),
          ],
        ),
      );
    }

    block(index) {
      return Constants.responsiveGlassBlock(
          context: context,
          heightRatio: 0.15,
          widthRatio: 0.95,
          content: blockContent(index));
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
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/1155007.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListView(
              children: List.generate(notes.length, (index) => block(index)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(() => AddNoteView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
