import 'package:billing_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.account_circle,
          color: Colors.black,
          size: 150,
        ),
        for (var i = 0; i < 4; i++)
          Constants.responsiveGlassBlock(
            context: context,
            widthRatio: 1,
            heightRatio: 0.1,
            content: Text('list'),
          ),
      ],
    );
  }
}
