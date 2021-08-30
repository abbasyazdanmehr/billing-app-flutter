import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bank_accounts_controller.dart';
import 'package:billing_app/controllers/turnovers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TurnoverDetailView extends StatelessWidget {
  final index;
  final controller = Get.put(TurnoversController());
  final accountController = Get.put(BankAccountsController());
  TurnoverDetailView({this.index});
  @override
  Widget build(BuildContext context) {
    block() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('${controller.turnovers[index].turnoverType}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Index: $index'),
              Text('Id: ${controller.turnovers[index].id}')
            ],
          ),
          Text('Mount: ${controller.turnovers[index].mount.toString()} \$'),
          // controller.turnovers[index].bankAccountId == 0
          //     ? Text('No bank account')
          //     : Text(
          //         'Bank account: ${accountController.getBankAccount(controller.turnovers[index].bankAccountId)}'), //TODO: showing bank account :/
          Text(
              'Time: ${controller.turnovers[index].time.toString().substring(0, 19)}'),
          Text('Description: ${controller.turnovers[index].description}'),
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
