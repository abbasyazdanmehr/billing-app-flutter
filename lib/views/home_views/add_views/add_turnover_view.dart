import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/models/turnover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class AddTurnoverView extends StatelessWidget {
  final controller = Get.put(ListViewController());
  final _formKey = GlobalKey<FormState>();
  final box = GetStorage();

  Widget formFields(BuildContext context) {
    int _inputMount;

    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                if (box.read('turnoverType') == TurnoverType.Income)
                  Text(
                    'Add Income!',
                    style: TextStyle(fontSize: 35.sp),
                  ),
                if (box.read('turnoverType') == TurnoverType.Cost)
                  Text(
                    'Add Cost!',
                    style: TextStyle(fontSize: 35.sp),
                  ),
                if (box.read('turnoverType') == TurnoverType.FutureCost)
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
                    hintText: 'description',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'this description is invalid';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Obx(
                  () {
                    return Text(
                      controller.turnovers.length.toString(),
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
                    controller.addTurnover(
                      Turnover(
                        mount: _inputMount,
                        turnoverType: box.read('turnoverType'),
                      ),
                    );
                    Navigator.pop(context);
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
