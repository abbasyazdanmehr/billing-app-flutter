import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bills_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillDetailView extends StatelessWidget {
  final index;
  final controller = Get.put(BillsController());
  BillDetailView({this.index});
  @override
  Widget build(BuildContext context) {
    block() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Index: $index'),
              Text('Id: ${controller.bills[index].id}')
            ],
          ),
          Text('Mount: ${controller.bills[index].mount.toString()} \$'),
          Text('Creditor Name: ${controller.bills[index].creditorName}'),
          Text(
              'DeadLine: ${controller.bills[index].deadLine.toString().substring(0, 10)}'),
          Text('Description: ${controller.bills[index].description}'),
        ],
      );
    }

    return Scaffold(
      appBar: Constants.customAppBar(),
      body: Center(
        child: Constants.responsiveGlassBlock(
          widthRatio: 0.9,
          heightRatio: 0.8,
          context: context,
          content: block(),
        ),
      ),
    );
  }
}
