import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bank_accounts_controller.dart';
import 'package:billing_app/models/bank_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddAccountView extends StatelessWidget {
  final controller = Get.put(BankAccountsController());
  final _formKey = GlobalKey<FormState>();

  Widget formFields(BuildContext context) {
    String _inputName;
    int _inputBalance;
    String _inputDescription;
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                Text(
                  'Add Account!',
                  style: TextStyle(fontSize: 35.sp),
                ),
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
                    icon: Icon(Icons.description),
                    hintText: 'Description',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'this description is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) => _inputDescription = value,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.money),
                    hintText: 'First Balance',
                  ),
                  validator: (String value) {
                    if (value.isEmpty || !Constants.isInteger(value)) {
                      return 'this balance is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) => _inputBalance = int.parse(value),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 1.h,
            right: 2.w,
            child: Container(
              height: 7.h,
              width: 86.w,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    controller.createBankAccount(
                      BankAccount(
                        name: _inputName,
                        balance: _inputBalance,
                        created: DateTime.now(),
                        description: _inputDescription,
                      ),
                    );
                    Get.back();
                  }
                },
                child: Text('Add'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/5390239.jpg"),
                    fit: BoxFit.cover)),
          ),
          Center(
            child: SingleChildScrollView(
              child: Constants.responsiveGlassBlock(
                context: context,
                heightRatio: 0.7,
                widthRatio: 0.9,
                content: formFields(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
