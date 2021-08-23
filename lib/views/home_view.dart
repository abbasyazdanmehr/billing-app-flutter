import 'package:billing_app/constants.dart';
import 'package:billing_app/controllers/accounts_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/views/home_views/accounts_list_view.dart';
import 'package:billing_app/views/home_views/bills_list_view.dart';
import 'package:billing_app/views/home_views/turnover_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  final ListViewController accountsController = Get.put(ListViewController());
  @override
  Widget build(BuildContext context) {
    Widget accounts(context) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 1,
        heightRatio: 0.2,
        content: TextButton(
          onPressed: () {
            Get.to(AccountsList());
          },
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Accounts',
              style: TextStyle(
                color: Constants.darkColor,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    Widget incomes(context) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 0.3,
        heightRatio: 0.2,
        content: TextButton(
          onPressed: () {
            Get.to(TurnoverListView(TurnoverType.Income));
          },
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Incomes',
              style: TextStyle(
                color: Constants.darkColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    Widget costs(context) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 0.3,
        heightRatio: 0.34,
        content: TextButton(
          onPressed: () {
            Get.to(TurnoverListView(TurnoverType.Cost));
          },
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Costs',
              style: TextStyle(
                color: Constants.darkColor,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    Widget bills(context) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 0.66,
        heightRatio: 0.4,
        content: TextButton(
          onPressed: () {
            Get.to(BillsListView());
          },
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Bills',
              style: TextStyle(
                color: Constants.darkColor,
                fontSize: 35.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    Widget futureCosts(context) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 0.66,
        heightRatio: 0.14,
        content: TextButton(
          onPressed: () {
            Get.to(TurnoverListView(TurnoverType.FutureCost));
          },
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Future Costs',
              style: TextStyle(
                color: Constants.darkColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
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
                  incomes(context),
                  costs(context),
                ],
              ),
              Column(
                children: [
                  bills(context),
                  futureCosts(context),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
