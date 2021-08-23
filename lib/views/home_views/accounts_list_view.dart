import 'package:billing_app/constants.dart';
import 'package:billing_app/controllers/accounts_controller.dart';
import 'package:billing_app/models/bank_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AccountsList extends StatelessWidget {
  final controller = Get.put(ListViewController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String _inputName;
    int _inputBalance;
    Widget addAccountForm() {
      return Form(
        key: _formKey,
        child: Stack(
          children: [
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Account Name',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'this username is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) => _inputName = value,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.money),
                    hintText: 'First Deposite',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'this deposit is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) => _inputBalance = int.parse(value),
                ),
                Obx(
                  () {
                    return Text(
                      controller.accounts.length.toString(),
                    );
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 10.h,
                width: 92.w,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      print(_inputName);
                      _formKey.currentState.save();
                      print(_inputName);
                      controller.addAccount(BankAccount(
                          name: _inputName, balance: _inputBalance));
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Account'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget addAccountBottomSheet() {
      return Center(
        child: SingleChildScrollView(
          child: Constants.responsiveGlassBlock(
            context: context,
            heightRatio: 0.5,
            widthRatio: 1,
            content: addAccountForm(),
          ),
        ),
      );
    }

    Widget accountContent(index) {
      return Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(controller.accounts[index].name),
            Text(controller.accounts[index].balance.toString()),
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
              for (var i = 0; i < controller.accounts.length; i++)
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
          showModalBottomSheet(
            backgroundColor: Constants.themeColor.withOpacity(0.5),
            isScrollControlled: true,
            context: context,
            builder: (context) => addAccountBottomSheet(),
          );
        },
      ),
    );
  }
}
