import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/turnovers_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/utils/utils.dart';
import 'package:billing_app/views/home_views/add_views/add_turnover_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class TurnoversListView extends StatelessWidget {
  final int bankAccountId;
  TurnoversListView({this.bankAccountId = 0}); // 0 means no bank account id

  final box = GetStorage();
  final controller = Get.put(TurnoversController());

  @override
  Widget build(BuildContext context) {
    Widget turnoverContent(index) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "mount: " +
                      controller.turnovers[index].mount.toString() +
                      ' \$',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontFamily: "serief",
                  ),
                ),
                controller.turnovers[index].bankAccountId != null
                    ? Text(
                        "account: " +
                            getBankAccount(
                                    controller.turnovers[index].bankAccountId)
                                .name
                                .toString(),
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Constants.textColor,
                        ),
                      )
                    : TextButton(
                        onPressed: () {},
                        child: Container(
                          color: Constants.textColor,
                          child: Text('Choose Account!'),
                        ),
                      ),
                Text(
                  "time: " +
                      controller.turnovers[index].time
                          .toString()
                          .substring(0, 19),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "serief",
                  ),
                ),
                Text(
                  "type: " +
                      getTurnoverType(controller.turnovers[index].turnoverType),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: "serief",
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                controller.deleteTurnover(controller.turnovers[index].id);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      );
    }

    block(index) {
      return Constants.responsiveGlassBlock(
        context: context,
        heightRatio: 0.28,
        widthRatio: 0.95,
        content: turnoverContent(index),
      );
    }

    return Scaffold(
      appBar: Constants.customAppBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/1155007.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Obx(
            () {
              return ListView(
                children: [
                  for (var i = 0; i < controller.turnovers.length; i++)
                    if ((bankAccountId != 0 &&
                            bankAccountId ==
                                controller.turnovers[i].bankAccountId) ||
                        ((bankAccountId == 0) &&
                            (box.read('turnoverIndex') ==
                                    controller.turnovers[i].turnoverType ||
                                box.read('turnoverIndex') ==
                                    TurnoverType.All.index)))
                      block(i),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: box.read('turnoverIndex') != TurnoverType.All.index
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Get.to(() => AddCostView());
              },
            )
          : Container(),
    );
  }
}
