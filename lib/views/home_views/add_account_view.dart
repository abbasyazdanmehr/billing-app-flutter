import 'package:billing_app/constants.dart';
import 'package:billing_app/controllers/accounts_controller.dart';
import 'package:billing_app/models/bank_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddAccount extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final accountsController = Get.put(AccountsController());
  @override
  Widget build(BuildContext context) {
    String _inputName = '';
    int _inputBalance = 0;
    return Scaffold(
      backgroundColor: Constants.themeColor,
      appBar: Constants.customAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Constants.responsiveGlassBlock(
              context: context,
              heightRatio: 0.5,
              widthRatio: 1,
              content: Form(
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
                          onSaved: (String value) =>
                              _inputBalance = int.parse(value),
                        ),
                        Obx(
                          () {
                            return Text(
                              accountsController.accounts.length.toString(),
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
                              accountsController.addAccount(BankAccount(
                                  name: _inputName, balance: _inputBalance));
                            }
                          },
                          child: Text('Add Account'),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
