import 'package:billing_app/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/models/bill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddBillView extends StatelessWidget {
  final controller = Get.put(ListViewController());
  final _formKey = GlobalKey<FormState>();

  Widget formFields(BuildContext context) {
    String _inputCreditorName;
    int _inputMount;
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Column(
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
                    return 'this username is invalid';
                  } else {
                    return null;
                  }
                },
                onSaved: (String value) => _inputCreditorName = value,
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
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 10.h,
              width: 84.w,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    print(_inputCreditorName);
                    _formKey.currentState.save();
                    print(_inputCreditorName);
                    controller.addBill(Bill(mount: _inputMount));
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Bill'),
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
