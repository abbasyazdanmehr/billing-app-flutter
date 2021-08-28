import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/db/bank_accounts_database.dart';
import 'package:billing_app/views/home_views/add_views/add_account_view.dart';
import 'package:billing_app/views/home_views/detail_views/account_detail_view.dart';
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
      bankAccounts = await BankAccountsDatabase.instance.readAllBankAccount();
      setState(() {});
      print('object');
    }

    delete(id) async {
      await BankAccountsDatabase.instance.deleteBankAccount(id);
      setState(() {});
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
              Row(
                children: [
                  Text(
                    bankAccounts[index].balance.toString() + ' \$',
                    style: TextStyle(
                      color: Constants.themeColor,
                      fontFamily: 'dubay',
                      fontSize: 22.sp,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (result) {
                      if (result.contains('Delete')) {
                        delete(bankAccounts[index].id);
                      } else if (result.contains('Edit')) {
                      } else if (result.contains('Info')) {}
                      setState(() {});
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
            ],
          ),
        ),
      );
    }

    block(index) {
      return TextButton(
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
