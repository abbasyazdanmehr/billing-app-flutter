import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bills_controller.dart';
import 'package:billing_app/views/home_views/add_views/add_bill_view.dart';
import 'package:billing_app/views/home_views/detail_views/bill_detail_view.dart';
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "mount: " + controller.bills[index].mount.toString() + ' \$',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontFamily: "serief",
                  ),
                ),
                Text(
                  "deadline: " + showDateTime(controller.bills[index].deadLine),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Constants.darkColor,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                controller.deleteBill(controller.bills[index].id);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      );
    }

    block(index) {
      return InkWell(
        onTap: () {
          Get.to(
            () => BillDetailView(
              index: index,
            ),
          );
        },
        child: Constants.responsiveGlassBlock(
            context: context,
            heightRatio: 0.16,
            widthRatio: 0.95,
            content: billContent(index)),
      );
    }

    return Scaffold(
      appBar: Constants.customAppBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/1155007.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Obx(() {
            return ListView(
              children: [
                for (var i = 0; i < controller.bills.length; i++) block(i),
              ],
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddBillView());
        },
      ),
    );
  }
}
