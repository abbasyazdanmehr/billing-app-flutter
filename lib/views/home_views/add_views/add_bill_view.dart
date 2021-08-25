import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/db/bills_database.dart';
import 'package:billing_app/models/bill.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class AddBillView extends StatelessWidget {
  final controller = Get.put(ListViewController());
  final _formKey = GlobalKey<FormState>();

  Future create(Bill bill) async {
    await BillsDatabase.instance.createBill(bill);
  }

  Widget formFields(BuildContext context) {
    String _inputCreditorName;
    String _inputDescription;
    DateTime _inputDeadLine;
    int _inputMount;
    final format = DateFormat("yyyy-MM-dd");
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                Text(
                  'Add Bill!',
                  style: TextStyle(fontSize: 40.sp),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.money),
                    hintText: 'Bill Mount',
                  ),
                  validator: (String value) {
                    if (value.isEmpty || !Constants.isInteger(value)) {
                      return 'this mount is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) => _inputMount = int.parse(value),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Creditor Name',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'this name is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) => _inputCreditorName = value,
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
                DateTimeField(
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final deadLine = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    await Future.delayed(Duration(seconds: 2));
                    _inputDeadLine = deadLine;
                    return deadLine;
                  },
                ),
                Obx(
                  () {
                    return Text(
                      controller.bills.length.toString(),
                    );
                  },
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
                    create(Bill(
                      mount: _inputMount,
                      creditorName: _inputCreditorName,
                      description: _inputDescription,
                      deadLine: _inputDeadLine,
                    ));
                    // controller.addBill(Bill(
                    //     mount: _inputMount, creditorName: _inputCreditorName));
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 18.sp),
                ),
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
      body: Center(
        child: SingleChildScrollView(
          child: Constants.responsiveGlassBlock(
            context: context,
            heightRatio: 0.8,
            widthRatio: 0.9,
            content: formFields(context),
          ),
        ),
      ),
    );
  }
}
