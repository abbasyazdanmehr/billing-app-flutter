import 'package:flutter/material.dart';

class AccountDetailView extends StatelessWidget {
  final index;
  AccountDetailView({this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Hello $index'),
    );
  }
}
