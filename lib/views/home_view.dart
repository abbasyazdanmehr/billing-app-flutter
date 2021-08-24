import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/controllers/small_object_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/views/home_views/accounts_list_view.dart';
import 'package:billing_app/views/home_views/add_account_view.dart';
import 'package:billing_app/views/home_views/add_bill_view.dart';
import 'package:billing_app/views/home_views/add_turnover_view.dart';
import 'package:billing_app/views/home_views/bills_list_view.dart';
import 'package:billing_app/views/home_views/turnovers_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  final ListViewController accountsController = Get.put(ListViewController());
  final smallController = Get.put(SmallObjectController());
  @override
  Widget build(BuildContext context) {
    Widget listBlock(String choiceText) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            choiceText,
            style: TextStyle(
              color: Constants.darkColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    Widget addBlock(choiceText) {
      return TextButton(
        onPressed: () {
          if (choiceText == 'Accounts') {
            Get.to(AddAccountView());
          } else if (choiceText == 'Bills') {
            Get.to(AddBillView());
          } else if (choiceText == 'Incomes') {
            smallController.setTurnOver(TurnoverType.Income);
            Get.to(AddTurnoverView());
          } else if (choiceText == 'Costs') {
            smallController.setTurnOver(TurnoverType.Cost);
            Get.to(AddTurnoverView());
          } else {
            // Future Costs
            smallController.setTurnOver(TurnoverType.FutureCost);
            Get.to(AddTurnoverView());
          }
        },
        child: Constants.responsiveGlassBlock(
          context: context,
          widthRatio: 0.2,
          heightRatio: 0.1,
          content: Center(
            child: Icon(Icons.add),
          ),
        ),
      );
    }

    choiceBlock(choiceText) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 1,
        heightRatio: 0.13,
        content: TextButton(
            onPressed: () {
              if (choiceText == 'Accounts') {
                Get.to(AccountsListView());
              } else if (choiceText == 'Bills') {
                Get.to(BillsListView());
              } else if (choiceText == 'Incomes') {
                smallController.setTurnOver(TurnoverType.Income);
                Get.to(TurnoversListView());
              } else if (choiceText == 'Costs') {
                smallController.setTurnOver(TurnoverType.Cost);
                Get.to(TurnoversListView());
              } else {
                // Future Costs
                smallController.setTurnOver(TurnoverType.FutureCost);
                Get.to(TurnoversListView());
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [listBlock(choiceText), addBlock(choiceText)],
            )),
      );
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            choiceBlock('Accounts'),
            choiceBlock('Bills'),
            choiceBlock('Incomes'),
            choiceBlock('Costs'),
            choiceBlock('Future Costs'),
          ],
        ),
      ),
    );
  }
}
