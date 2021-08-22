import 'package:billing_app/constants.dart';
import 'package:billing_app/controllers/accounts_controller.dart';
import 'package:billing_app/views/home_views/add_account_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsList extends StatelessWidget {
  final accountsController = Get.put(AccountsController());
  @override
  Widget build(BuildContext context) {
    Widget accountContent(index) {
      return Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(accountsController.accounts[index].name),
            Text(accountsController.accounts[index].balance.toString())
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Constants.hideColor,
      appBar: Constants.customAppBar(),
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              for (var i = 0; i < accountsController.accounts.length; i++)
                Constants.responsiveGlassBlock(
                  context: context,
                  heightRatio: 0.1,
                  widthRatio: 1,
                  content: accountContent(i),
                ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddAccount());
        },
      ),
    );
  }
}
