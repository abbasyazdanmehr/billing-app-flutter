import 'package:billing_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Constants.simpleBlock(size.height * 0.3, size.width, 'text');
  }
}
