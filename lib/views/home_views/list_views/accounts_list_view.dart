import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bank_accounts_controller.dart';
import 'package:billing_app/views/home_views/add_views/add_account_view.dart';
import 'package:billing_app/views/home_views/detail_views/account_detail_view.dart';
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Text(
                    "name: " + controller.bankAccounts[index].name,
                    style: TextStyle(fontSize: 22.sp),
                  );
                }),
                Text(
                  "balance: " +
                      controller.bankAccounts[index].balance.toString() +
                      ' \$',
                  style: TextStyle(
                    color: Constants.textColor,
                    fontFamily: 'serief',
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                controller.deleteBankAccount(controller.bankAccounts[index].id);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      );
    }

    block(index) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        child: InkWell(
          child: Constants.responsiveGlassBlock(
            context: context,
            heightRatio: 0.18,
            widthRatio: 0.93,
            content: accountContent(index),
          ),
          onTap: () {
            Get.to(
              () => AccountDetailView(
                index: index,
              ),
            );
          },
        ),
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
                    fit: BoxFit.cover)),
          ),
          Obx(
            () {
              return ListView(
                children: [
                  for (var i = 0; i < controller.bankAccounts.length; i++)
                    block(i),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddAccountView());
        },
      ),
    );
  }
}
