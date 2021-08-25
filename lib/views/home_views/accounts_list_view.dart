import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/views/home_views/add_views/add_account_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AccountsListView extends StatelessWidget {
  final controller = Get.put(ListViewController());
  @override
  Widget build(BuildContext context) {
    Widget accountContent(index) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.bankAccounts[index].name,
                style: TextStyle(fontSize: 22.sp),
              ),
              Text(
                controller.bankAccounts[index].balance.toString() + ' \$',
                style: TextStyle(
                  color: Constants.themeColor,
                  fontFamily: 'dubay',
                  fontSize: 22.sp,
                ),
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
          content: accountContent(index));
    }

    return Scaffold(
      appBar: Constants.customAppBar(),
      body: SingleChildScrollView(
        child: Obx(() {
          return Center(
            child: Column(
              children: [
                for (var i = 0; i < controller.bankAccounts.length; i++)
                  block(i),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddAccountView());
        },
      ),
    );
  }
}
