import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/views/home_views/list_views/accounts_list_view.dart';
import 'package:billing_app/views/home_views/add_views/add_account_view.dart';
import 'package:billing_app/views/home_views/add_views/add_bill_view.dart';
import 'package:billing_app/views/home_views/add_views/add_turnover_view.dart';
import 'package:billing_app/views/home_views/list_views/bills_list_view.dart';
import 'package:billing_app/views/home_views/list_views/turnovers_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  final box = GetStorage();
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
          if (choiceText.contains('Accounts')) {
            Get.to(() => AddAccountView());
          } else if (choiceText.contains('Bills')) {
            Get.to(() => AddBillView());
          } else if (choiceText.contains('Incomes')) {
            box.write('turnoverIndex', TurnoverType.Income.index);
            Get.to(() => AddTurnoverView());
          } else if (choiceText.contains('Costs')) {
            box.write('turnoverIndex', TurnoverType.Cost.index);
            Get.to(() => AddTurnoverView());
          } else if (choiceText.contains('Future Cost')) {
            // Future Costs
            box.write('turnoverIndex', TurnoverType.FutureCost.index);
            Get.to(() => AddTurnoverView());
          }
        },
        child: Constants.responsiveGlassBlock(
          context: context,
          widthRatio: 0.15,
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
        widthRatio: 0.8,
        heightRatio: 0.13,
        content: TextButton(
            onPressed: () {
              if (choiceText.contains('Accounts')) {
                Get.to(() => AccountsListView());
              } else if (choiceText.contains('Bills')) {
                Get.to(() => BillsListView());
              } else if (choiceText.contains('Incomes')) {
                box.write('turnoverIndex', TurnoverType.Income.index);
                Get.to(() => TurnoversListView());
              } else if (choiceText.contains('Costs')) {
                box.write('turnoverIndex', TurnoverType.Cost.index);
                Get.to(() => TurnoversListView());
              } else {
                // Future Costs
                box.write('turnoverIndex', TurnoverType.FutureCost.index);
                Get.to(() => TurnoversListView());
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [listBlock(choiceText), addBlock(choiceText)],
            )),
      );
    }

    blocks() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            choiceBlock('🏛️ Accounts'),
            choiceBlock('🧾 Bills'),
            choiceBlock('💰 Incomes'),
            choiceBlock('💵 Costs'),
            choiceBlock('📈 Future Cost'),
          ],
        ),
      );
    }

    return Center(
      child: SingleChildScrollView(
        child: Constants.responsiveGlassBlock(
          context: context,
          heightRatio: 0.73,
          widthRatio: 0.9,
          content: blocks(),
        ),
      ),
    );
  }
}
