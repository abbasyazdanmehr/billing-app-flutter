import 'package:billing_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(),
      body: Container(
        child: Text('Hello world!'),
      ),
    );
  }
}
