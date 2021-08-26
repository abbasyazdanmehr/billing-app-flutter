import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/db/bills_database.dart';
import 'package:billing_app/models/bill.dart';
import 'package:billing_app/views/home_views/add_views/add_bill_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BillsListView extends StatefulWidget {
  @override
  _BillsListViewState createState() => _BillsListViewState();
}

class _BillsListViewState extends State<BillsListView> {
  final controller = Get.put(ListViewController());
  List<Bill> bills = [];

  String showDateTime(DateTime dateTime) {
    return dateTime.year.toString() +
        '/' +
        dateTime.month.toString() +
        '/' +
        dateTime.day.toString();
  }

  @override
  Widget build(BuildContext context) {
    refreshBills() async {
      setState(() {});
      bills = await BillsDatabase.instance.readAllBills();
    }

    Widget billContent(index) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bills[index].mount.toString() + ' \$',
                style: TextStyle(
                  fontSize: 22.sp,
                ),
              ),
              Text(
                showDateTime(bills[index].deadLine),
                style: TextStyle(fontSize: 15.sp, color: Constants.themeColor),
              ),
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
          content: billContent(index));
    }

    return Scaffold(
      appBar: Constants.customAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await refreshBills();
        },
        child: ListView(
          children: [
            for (var i = 0; i < bills.length; i++) block(i),
            Text(bills.length.toString())
          ],
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
