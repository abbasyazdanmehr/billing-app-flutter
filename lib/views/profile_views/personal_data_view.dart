import 'package:billing_app/constants/constants.dart';
import 'package:flutter/material.dart';

class PersonalDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(),
      body: Container(
        child: Center(
          child: Text("It is open for premium account!"),
        ),
      ),
    );
  }
}
