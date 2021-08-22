import 'package:billing_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget blockContent(String text, Color color, double size) {
      return Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: size.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget accounts(context) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 1,
        heightRatio: 0.2,
        content: blockContent('Accounts', Constants.hideColor, 30),
      );
    }

    Widget bills(context) {
      return Constants.responsiveGlassBlock(
          context: context,
          widthRatio: 0.3,
          heightRatio: 0.2,
          content: blockContent('Bills', Constants.detailColor, 20));
    }

    Widget costs(context) {
      return Constants.responsiveGlassBlock(
          context: context,
          widthRatio: 0.3,
          heightRatio: 0.34,
          content: blockContent('Costs', Constants.darkColor, 20));
    }

    Widget futureCosts(context) {
      return Constants.responsiveGlassBlock(
          context: context,
          widthRatio: 0.66,
          heightRatio: 0.4,
          content: blockContent('FutureCosts', Constants.lightColor, 20));
    }

    Widget incomes(context) {
      return Constants.responsiveGlassBlock(
          context: context,
          widthRatio: 0.66,
          heightRatio: 0.14,
          content: blockContent('Incomes', Constants.themeColor, 20));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          accounts(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  bills(context),
                  costs(context),
                ],
              ),
              Column(
                children: [
                  futureCosts(context),
                  incomes(context),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
