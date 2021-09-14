import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bank_accounts_controller.dart';
import 'package:billing_app/controllers/turnovers_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/models/bank_account.dart';
import 'package:billing_app/models/turnover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class AddCostView extends StatefulWidget {
  @override
  _AddCostViewState createState() => _AddCostViewState();
}

class _AddCostViewState extends State<AddCostView> {
  final _formKey = GlobalKey<FormState>();

  final box = GetStorage();

  final turnoverController = Get.put(TurnoversController());

  final bankAccountsController = Get.put(BankAccountsController());
  int _inputMount;
  int _inputBankAccountIndex;
  String _inputDescription;

  bankChoice(index) {
    return TextButton(
      onPressed: () {
        _inputBankAccountIndex = index;
        setState(() {});
        Get.back();
      },
      child: Text(bankAccountsController.bankAccounts[index].name),
    );
  }

  chosingBankAccount() {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            child: Wrap(
              children: [
                for (var i = 0;
                    i < bankAccountsController.bankAccounts.length;
                    i++)
                  bankChoice(i),
              ],
            ),
          ),
        );
      },
      child: Text('Change bank account'),
    );
  }

  Widget formFields(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                if (box.read('turnoverIndex') == TurnoverType.Income.index)
                  Text(
                    'Add Income!',
                    style: TextStyle(fontSize: 35.sp),
                  ),
                if (box.read('turnoverIndex') == TurnoverType.Cost.index)
                  Text(
                    'Add Cost!',
                    style: TextStyle(fontSize: 35.sp),
                  ),
                if (box.read('turnoverIndex') == TurnoverType.FutureCost.index)
                  Text(
                    'Add Future Cost!',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.money),
                      hintText: 'Mount',
                    ),
                    validator: (String value) {
                      if (value.isEmpty || !Constants.isInteger(value))
                        return 'this mount is invalid';
                      else if (box.read('turnoverIndex') ==
                              TurnoverType.Cost.index &&
                          _inputBankAccountIndex != null &&
                          bankAccountsController
                                  .bankAccounts[_inputBankAccountIndex]
                                  .balance <
                              int.parse(value)) {
                        return 'no enough balance';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String value) {
                      if (box.read('turnoverIndex') ==
                          TurnoverType.Income.index)
                        _inputMount = int.parse(value);
                      else if (box.read('turnoverIndex') ==
                          TurnoverType.Cost.index)
                        _inputMount = -int.parse(value);
                    }),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'description',
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
                  height: 10.h,
                ),
                chosingBankAccount(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _inputBankAccountIndex == null
                        ? Text('no One')
                        : Text(
                            bankAccountsController
                                .bankAccounts[_inputBankAccountIndex].name,
                          ),
                    _inputBankAccountIndex == null
                        ? Container(
                            height: 45,
                          )
                        : IconButton(
                            onPressed: () {
                              _inputBankAccountIndex = null;
                              setState(() {});
                            },
                            icon: Icon(Icons.close),
                          ),
                  ],
                )
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
                    bankAccountsController.bankAccounts[_inputBankAccountIndex]
                        .addingBalance(_inputMount);
                    print(_inputMount);
                    bankAccountsController.updateBankAccount(
                        bankAccountsController
                                .bankAccounts[_inputBankAccountIndex]
                            as BankAccount);
                    turnoverController.createTurnover(
                      Turnover(
                        mount: _inputMount,
                        bankAccountId: _inputBankAccountIndex == null
                            ? 0
                            : bankAccountsController
                                .bankAccounts[_inputBankAccountIndex].id,
                        time: DateTime.now(),
                        turnoverType: box.read('turnoverIndex'),
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Constants.responsiveGlassBlock(
              context: context,
              heightRatio: 0.8,
              widthRatio: 0.9,
              content: formFields(context),
            ),
          ),
        ),
      ),
    );
  }
}
