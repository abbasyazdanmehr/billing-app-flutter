import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bills_controller.dart';
import 'package:billing_app/views/home_views/add_views/add_bill_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BillsListView extends StatelessWidget {
  final controller = Get.put(BillsController());

  String showDateTime(DateTime dateTime) {
    return dateTime.year.toString() +
        '/' +
        dateTime.month.toString() +
        '/' +
        dateTime.day.toString();
  }

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
                showDateTime(controller.bills[index].deadLine),
                style: TextStyle(fontSize: 15.sp, color: Constants.themeColor),
              ),
              PopupMenuButton<String>(
                onSelected: (result) {
                  if (result.contains('Delete')) {
                    controller.deleteBill(controller.bills[index].id);
                  } else if (result.contains('Edit')) {
                  } else if (result.contains('Info')) {}
                },
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    child: Text('Delete!'),
                    value: 'Delete!',
                  ),
                  const PopupMenuItem<String>(
                    child: Text('Edit!'),
                    value: 'Edit!',
                  ),
                  const PopupMenuItem<String>(
                    child: Text('Info!'),
                    value: 'Info!',
                  ),
                ],
              )
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
      body: Obx(() {
        return ListView(
          children: [
            for (var i = 0; i < controller.bills.length; i++) block(i),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddBillView());
        },
      ),
    );
  }
}
