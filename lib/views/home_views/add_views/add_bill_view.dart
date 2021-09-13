import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bills_controller.dart';
import 'package:billing_app/models/bill.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class AddBillView extends StatefulWidget {
  @override
  _AddBillViewState createState() => _AddBillViewState();
}

class _AddBillViewState extends State<AddBillView> {
  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(BillsController());

  DateTime _inputDeadLine;

  Widget formFields(context) {
    String _inputCreditorName;
    String _inputDescription;

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
                    print(deadLine);
                    _inputDeadLine = deadLine;
                    print('//////lll');
                    print(_inputDeadLine);
                    return deadLine;
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
                    controller.createBill(Bill(
                      mount: _inputMount,
                      creditorName: _inputCreditorName,
                      description: _inputDescription,
                      deadLine: _inputDeadLine,
                    ));
                    Get.back();
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
