import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bank_accounts_controller.dart';
import 'package:billing_app/views/home_views/list_views/turnovers_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDetailView extends StatelessWidget {
  final index;
  final controller = Get.put(BankAccountsController());
  AccountDetailView({this.index});
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
              Text('Id: ${controller.bankAccounts[index].id}')
            ],
          ),
          Text('Name: ${controller.bankAccounts[index].name}'),
          Text('Balance: ${controller.bankAccounts[index].balance}'),
          Text(
              'Created: ${controller.bankAccounts[index].created.toString().substring(0, 19)}'),
          Text('Description: ${controller.bankAccounts[index].description}'),
          TextButton(
            onPressed: () {
              Get.to(
                () => TurnoversListView(
                  bankAccountId: controller.bankAccounts[index].id,
                ),
              );
            },
            child: Text('See Turnovers'),
          ),
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
