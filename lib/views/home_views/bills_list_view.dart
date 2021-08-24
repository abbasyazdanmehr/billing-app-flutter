import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/views/home_views/add_bill_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillsListView extends StatelessWidget {
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
                for (var i = 0; i < controller.bills.length; i++)
                  Text('Hello World'),
                Text(controller.bills.length.toString())
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddBillView());
        },
      ),
    );
  }
}
