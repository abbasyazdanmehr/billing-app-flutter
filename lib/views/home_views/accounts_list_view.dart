import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/views/home_views/add_account_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsListView extends StatelessWidget {
  final controller = Get.put(ListViewController());
  @override
  Widget build(BuildContext context) {
    Widget accountContent(index) {
      return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Constants.themeColor),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(controller.bankAccounts[index].name),
              Text(controller.bankAccounts[index].balance.toString()),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: Constants.customAppBar(),
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              for (var i = 0; i < controller.bankAccounts.length; i++)
                accountContent(i),
            ],
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
