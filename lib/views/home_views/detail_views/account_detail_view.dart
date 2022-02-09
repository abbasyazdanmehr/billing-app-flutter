import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bank_accounts_controller.dart';
import 'package:billing_app/views/home_views/list_views/turnovers_list_view.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class AccountDetailView extends StatelessWidget {
  final index;
  final controller = Get.put(BankAccountsController());
  AccountDetailView({this.index});
  @override
  Widget build(BuildContext context) {
    block() {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${controller.bankAccounts[index].name}',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontFamily: "serief",
                ),
              ),
              Text(
                'Balance: ${controller.bankAccounts[index].balance}' + ' \$',
                style: TextStyle(fontSize: 22.sp, fontFamily: "serief"),
              ),
              Text(
                'Created: ${controller.bankAccounts[index].created.toString().substring(0, 19)}',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              Text(
                  'Description: ${controller.bankAccounts[index].description}'),
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => TurnoversListView(
                        bankAccountId: controller.bankAccounts[index].id,
                      ),
                    );
                  },
                  child: Text(
                    'See Turnovers',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontFamily: "serief",
                        color: Colors.purple),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: Constants.customAppBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/5390239.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Constants.responsiveGlassBlock(
              widthRatio: 0.9,
              heightRatio: 0.8,
              context: context,
              content: block(),
            ),
          ),
        ],
      ),
    );
  }
}
