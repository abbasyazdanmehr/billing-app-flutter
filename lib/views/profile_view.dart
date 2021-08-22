import 'package:billing_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.account_circle,
          color: Colors.black,
          size: size.height * 0.25,
        ),
        for (var i = 0; i < 4; i++)
          Constants.simpleBlock(size.height * 0.1, size.height, 'ali'),
      ],
    );
  }
}
