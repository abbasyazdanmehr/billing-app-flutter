import 'package:billing_app/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/controllers/small_object_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/views/home_views/accounts_list_view.dart';
import 'package:billing_app/views/home_views/add_bill_view.dart';
import 'package:billing_app/views/home_views/bills_list_view.dart';
import 'package:billing_app/views/home_views/turnover_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  final ListViewController accountsController = Get.put(ListViewController());
  final smallController = Get.put(SmallObjectController());
  @override
  Widget build(BuildContext context) {
    Widget accounts(context) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 1,
        heightRatio: 0.14,
        content: TextButton(
          onPressed: () {
            Get.to(AccountsList());
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Accounts',
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

    Widget incomes(context) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 1,
        heightRatio: 0.14,
        content: TextButton(
          onPressed: () {
            smallController.setTurnOver(TurnoverType.Income);
            Get.to(TurnoverListView());
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Incomes',
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

    Widget costs(context) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 1,
        heightRatio: 0.14,
        content: TextButton(
          onPressed: () {
            smallController.setTurnOver(TurnoverType.Cost);
            Get.to(TurnoverListView());
          },
          child: Align(
            alignment: Alignment.centerLeft,
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

    Widget addBill() {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 0.2,
        heightRatio: 0.1,
        content: Center(
          child: IconButton(
            onPressed: () {
              Get.to(AddBillView());
            },
            icon: Icon(Icons.add),
          ),
        ),
      );
    }

    Widget listBills() {
      return TextButton(
        onPressed: () {
          Get.to(BillsListView());
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Bills',
            style: TextStyle(
              color: Constants.darkColor,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    Widget bills(context) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 1,
        heightRatio: 0.14,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            listBills(),
            addBill(),
          ],
        ),
      );
    }

    Widget futureCosts(context) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 1,
        heightRatio: 0.14,
        content: TextButton(
          onPressed: () {
            smallController.setTurnOver(TurnoverType.FutureCost);
            Get.to(TurnoverListView());
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Future Costs',
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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          accounts(context),
          bills(context),
          incomes(context),
          costs(context),
          futureCosts(context),
        ],
      ),
    );
  }
}
