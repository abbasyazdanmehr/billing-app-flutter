import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bank_accounts_controller.dart';
import 'package:billing_app/views/home_views/add_views/add_account_view.dart';
import 'package:billing_app/views/home_views/detail_views/account_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AccountsListView extends StatelessWidget {
  final controller = Get.put(BankAccountsController());
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
              Obx(() {
                return Text(
                  controller.bankAccounts[index].name,
                  style: TextStyle(fontSize: 22.sp),
                );
              }),
              Row(
                children: [
                  Text(
                    controller.bankAccounts[index].balance.toString() + ' \$',
                    style: TextStyle(
                      color: Constants.themeColor,
                      fontFamily: 'dubay',
                      fontSize: 22.sp,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (result) {
                      if (result.contains('Delete')) {
                        controller.deleteBankAccount(
                            controller.bankAccounts[index].id);
                      } else if (result.contains('Edit')) {
                      } else if (result.contains('Info')) {
                      } else {
                        print('Not fount!!!');
                      }
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
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    block(index) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Constants.responsiveGlassBlock(
          context: context,
          heightRatio: 0.1,
          widthRatio: 0.93,
          content: accountContent(index),
        ),
        onPressed: () {
          Get.to(
            AccountDetailView(
              index: index,
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: Constants.customAppBar(),
      body: RefreshIndicator(
        onRefresh: controller.fetchBankAccountsFromDatabase,
        child: Obx(
          () {
            return ListView(
              children: [
                for (var i = 0; i < controller.bankAccounts.length; i++)
                  block(i),
              ],
            );
          },
        ),
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
