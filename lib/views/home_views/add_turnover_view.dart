import 'package:billing_app/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/controllers/small_object_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/models/turnover.dart';
import 'package:billing_app/views/home_views/turnover_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddTurnoverView extends StatelessWidget {
  final controller = Get.put(ListViewController());
  final _formKey = GlobalKey<FormState>();
  final smallController = Get.put(SmallObjectController());

  Widget formFields(BuildContext context) {
    int _inputMount;

    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Column(
            children: [
              Text(
                'Add Turnover!',
                style: TextStyle(fontSize: 35.sp),
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
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 10.h,
              width: 84.w,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    controller.addTurnover(
                      Turnover(
                        mount: _inputMount,
                        turnoverType: smallController.turnoverType[0],
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Turnover'),
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
