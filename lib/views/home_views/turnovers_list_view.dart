import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/lists_controller.dart';
import 'package:billing_app/db/turnovers_database.dart';
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
  final controller = Get.put(ListViewController());

  final box = GetStorage();

  var turnovers = [];

  @override
  Widget build(BuildContext context) {
    refreshTurnovers() async {
      setState(() {});
      turnovers = await TurnoversDatabase.instance.readAllTurnovers();
    }

    Widget turnoverContent(index) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                turnovers[index].mount.toString() + ' \$',
                style: TextStyle(
                  fontSize: 22.sp,
                ),
              ),
              turnovers[index].bankAccountId != null
                  ? Text(
                      turnovers[index].bankAccountId.toString(),
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
      body: RefreshIndicator(
        onRefresh: refreshTurnovers,
        child: ListView(
          children: [
            for (var i = 0; i < turnovers.length; i++)
              if (box.read('turnoverIndex') == turnovers[i].turnoverType)
                block(i),
          ],
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
