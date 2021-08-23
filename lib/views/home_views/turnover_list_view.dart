import 'package:billing_app/constants.dart';
import 'package:billing_app/controllers/accounts_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TurnoverListView extends StatelessWidget {
  final turnoverTypeView;
  TurnoverListView(this.turnoverTypeView);
  final controller = Get.put(ListViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(),
      body: Stack(
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            child: Column(
              children: [
                for (var i = 0; i < controller.turnovers.length; i++)
                  if (turnoverTypeView ==
                          controller.turnovers[i].turnoverTypeView ||
                      turnoverTypeView == TurnoverType.All)
                    Text('Hello World'),
                Text(
                  controller.bills.length.toString(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
