import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/turnovers_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/views/home_views/add_views/add_turnover_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class TurnoversListView extends StatefulWidget {
  @override
  _TurnoversListViewState createState() => _TurnoversListViewState();
}

class _TurnoversListViewState extends State<TurnoversListView> {
  final box = GetStorage();
  final controller = Get.put(TurnoversController());

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
              controller.turnovers[index].bankAccountId != null
                  ? Text(
                      controller.turnovers[index].bankAccountId.toString(),
                      style: TextStyle(
                          fontSize: 22.sp, color: Constants.themeColor),
                    )
                  : TextButton(
                      onPressed: () {},
                      child: Container(
                        color: Constants.textColor,
                        child: Text('Choose Account!'),
                      ),
                    ),
              PopupMenuButton<String>(
                onSelected: (result) {
                  if (result.contains('Delete')) {
                    controller.deleteTurnover(controller.turnovers[index].id);
                  } else if (result.contains('Edit')) {
                  } else if (result.contains('Info')) {}
                  setState(() {});
                },
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    child: Text('Delete!'),
                    value: 'Delete!',
                  ),
                  const PopupMenuItem<String>(
                    child: Text('Edit!'),
                    value: 'Edit!',
                  ),
                  const PopupMenuItem<String>(
                    child: Text('Info!'),
                    value: 'Info!',
                  ),
                ],
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
      body: Obx(
        () {
          return ListView(
            children: [
              for (var i = 0; i < controller.turnovers.length; i++)
                if (box.read('turnoverIndex') ==
                        controller.turnovers[i].turnoverType ||
                    box.read('turnoverIndex') == TurnoverType.All.index)
                  block(i),
            ],
          );
        },
      ),
      floatingActionButton: box.read('turnoverIndex') != TurnoverType.All.index
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Get.to(AddTurnoverView());
              },
            )
          : Container(),
    );
  }
}
