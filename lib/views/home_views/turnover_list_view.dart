import 'package:billing_app/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/controllers/small_object_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/views/home_views/add_turnover_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TurnoverListView extends StatelessWidget {
  final controller = Get.put(ListViewController());
  final smallController = Get.put(SmallObjectController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Obx(
          () => Column(
            children: [
              for (var i = 0; i < controller.turnovers.length; i++)
                if (smallController.turnoverType[0] ==
                    controller.turnovers[i].turnoverType)
                  Text(controller.turnovers[i].mount.toString()),
              Text(
                controller.turnovers.length.toString(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddTurnoverView());
        },
      ),
    );
  }
}
