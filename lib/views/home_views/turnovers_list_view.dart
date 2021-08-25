import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/views/home_views/add_turnover_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class TurnoversListView extends StatelessWidget {
  final controller = Get.put(ListViewController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    Widget turnoverContent(index) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.turnovers[index].mount.toString() + ' \$',
                style: TextStyle(
                  fontSize: 22.sp,
                ),
              ),
              controller.turnovers[index].bankAccount != null
                  ? Text(
                      controller.turnovers[index]
                          .bankAccount, // TODO: changing to time
                      style: TextStyle(
                          fontSize: 22.sp, color: Constants.themeColor),
                    )
                  : TextButton(
                      onPressed: () {},
                      child: Container(
                        color: Constants.textColor,
                        child: Text('Choose Account!'),
                      ),
                    )
            ],
          ),
        ),
      );
    }

    block(index) {
      return Constants.responsiveGlassBlock(
          context: context,
          heightRatio: 0.1,
          widthRatio: 0.95,
          content: turnoverContent(index));
    }

    return Scaffold(
      appBar: Constants.customAppBar(),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Obx(
          () => Column(
            children: [
              for (var i = 0; i < controller.turnovers.length; i++)
                if (box.read('turnoverType') ==
                    controller.turnovers[i].turnoverType)
                  block(i),
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
