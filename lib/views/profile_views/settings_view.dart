import 'package:billing_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('${MediaQuery.of(context).size.height.toString()} =? ${10.h}');
  }
}
