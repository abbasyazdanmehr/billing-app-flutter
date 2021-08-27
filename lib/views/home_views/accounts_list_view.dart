import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/db/bank_accounts_database.dart';
import 'package:billing_app/views/home_views/add_views/add_account_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AccountsListView extends StatefulWidget {
  @override
  _AccountsListViewState createState() => _AccountsListViewState();
}

class _AccountsListViewState extends State<AccountsListView> {
  var bankAccounts = [];

  @override
  Widget build(BuildContext context) {
    refreshBankAccounts() async {
      setState(() {});
      bankAccounts = await BankAccountsDatabase.instance.readAllBankAccount();
    }

    Widget accountContent(index) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bankAccounts[index].name,
                style: TextStyle(fontSize: 22.sp),
              ),
              Text(
                bankAccounts[index].balance.toString() + ' \$',
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
      body: RefreshIndicator(
        onRefresh: refreshBankAccounts,
        child: ListView(
          children: [
            for (var i = 0; i < bankAccounts.length; i++) block(i),
          ],
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
