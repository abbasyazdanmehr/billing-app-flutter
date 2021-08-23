import 'package:billing_app/constants.dart';
import 'package:billing_app/controllers/accounts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TurnoverListView extends StatelessWidget {
  final turnoverTypeView;
  TurnoverListView(this.turnoverTypeView);
  final controller = Get.put(ListViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return Column(
              children: [
                for (var i = 0; i < controller.turnovers.length; i++)
                  if (turnoverTypeView ==
                      controller.turnovers[i].turnoverTypeView)
                    Text('Hello World'),
                Text(
                  controller.bills.length.toString(),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
