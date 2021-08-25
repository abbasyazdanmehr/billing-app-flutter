import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/views/home_views/add_bill_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BillsListView extends StatelessWidget {
  final controller = Get.put(ListViewController());
  @override
  Widget build(BuildContext context) {
    Widget billContent(index) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.bills[index].mount.toString() + ' \$',
                style: TextStyle(
                  fontSize: 22.sp,
                ),
              ),
              Text(
                controller.bills[index].creditorName, // TODO: changing to time
                style: TextStyle(fontSize: 22.sp, color: Constants.themeColor),
              ),
            ],
          ),
        ),
      );
    }

    block(index) {
      return Constants.responsiveGlassBlock(
          context: context,
          heightRatio: 0.1,
          widthRatio: 0.95,
          content: billContent(index));
    }

    return Scaffold(
      appBar: Constants.customAppBar(),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return Center(
              child: Column(
                children: [
                  for (var i = 0; i < controller.bills.length; i++) block(i),
                  Text(controller.bills.length.toString())
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddBillView());
        },
      ),
    );
  }
}
