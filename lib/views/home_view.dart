import 'package:billing_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget accountsContent() {
      return Align(
        alignment: Alignment.center,
        child: Text(
          'Accounts',
          style: TextStyle(
            color: Constants.darkColor,
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.responsiveGlassBlock(
          context: context,
          widthRatio: 1,
          heightRatio: 0.2,
          content: accountsContent(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Constants.responsiveGlassBlock(
                  context: context,
                  widthRatio: 0.3,
                  heightRatio: 0.2,
                  content: Text(
                    'smaller',
                  ),
                ),
                Constants.responsiveGlassBlock(
                  context: context,
                  widthRatio: 0.3,
                  heightRatio: 0.35,
                  content: Text(
                    'smaller',
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Constants.responsiveGlassBlock(
                  context: context,
                  widthRatio: 0.66,
                  heightRatio: 0.4,
                  content: Text(
                    'smaller',
                  ),
                ),
                Constants.responsiveGlassBlock(
                  context: context,
                  widthRatio: 0.66,
                  heightRatio: 0.15,
                  content: Text(
                    'smaller',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
