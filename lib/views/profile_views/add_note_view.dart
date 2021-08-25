import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/db/notes_database.dart';
import 'package:billing_app/models/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddNoteView extends StatelessWidget {
  final controller = Get.put(ListViewController());
  final _formKey = GlobalKey<FormState>();

  Future createNote(Note note) async {
    await NoteDatabase.instance.createNote(note);
  }

  Widget formFields(BuildContext context) {
    String _inputTitle;
    String _inputDescription;
    bool _isImportant;
    int _inputNumber;
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                Text(
                  'Add Note!',
                  style: TextStyle(fontSize: 30.sp),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.format_list_numbered),
                    hintText: 'Number',
                  ),
                  validator: (String value) {
                    if (value.isEmpty || !Constants.isInteger(value)) {
                      return 'this number is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) => _inputNumber = int.parse(value),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.title),
                    hintText: 'Title',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Title is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) => _inputTitle = value,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.description),
                    hintText: 'Description',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Description is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) => _inputDescription = value,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.star),
                    hintText: 'Is important?',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Description is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) {
                    if (value.contains('true'))
                      _isImportant = true;
                    else
                      _isImportant = false;
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 1.h,
            right: 2.w,
            child: Container(
              height: 7.h,
              width: 86.w,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    createNote(
                      Note(
                        number: _inputNumber,
                        title: _inputTitle,
                        description: _inputDescription,
                        isImportant: _isImportant,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Add'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Constants.responsiveGlassBlock(
            context: context,
            heightRatio: 0.7,
            widthRatio: 0.9,
            content: formFields(context),
          ),
        ),
      ),
    );
  }
}
