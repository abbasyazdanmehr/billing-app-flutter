import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/bank_accounts_controller.dart';
import 'package:billing_app/controllers/bills_controller.dart';
import 'package:billing_app/controllers/turnovers_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/models/bank_account.dart';
import 'package:billing_app/models/turnover.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillDetailView extends StatefulWidget {
  final index;

  BillDetailView({this.index});

  @override
  _BillDetailViewState createState() => _BillDetailViewState();
}

class _BillDetailViewState extends State<BillDetailView> {
  final billsController = Get.put(BillsController());

  final bankAccountsController = Get.put(BankAccountsController());
  final turnoversController = Get.put(TurnoversController());

  int _inputBankAccountIndex;
  String billPaymentStatus = "No Payment Yet!";

  @override
  Widget build(BuildContext context) {
    bankChoice(index) {
      return TextButton(
        onPressed: () {
          _inputBankAccountIndex = index;
          setState(() {});
          Get.back();
        },
        child: Text(bankAccountsController.bankAccounts[index].name),
      );
    }

    chosingBankAccount() {
      return ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              child: Wrap(
                children: [
                  for (var i = 0;
                      i < bankAccountsController.bankAccounts.length;
                      i++)
                    bankChoice(i),
                ],
              ),
            ),
          );
        },
        child: Text('Change bank account'),
      );
    }

    block() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Index: ${widget.index}'),
              Text('Id: ${billsController.bills[widget.index].id}')
            ],
          ),
          Text(
              'Mount: ${billsController.bills[widget.index].mount.toString()} \$'),
          Text(
              'Creditor Name: ${billsController.bills[widget.index].creditorName}'),
          Text(
              'DeadLine: ${billsController.bills[widget.index].deadLine.toString().substring(0, 10)}'),
          Text(
              'Description: ${billsController.bills[widget.index].description}'),
          billsController.bills[widget.index].isPayment
              ? Text('already Paied!')
              : Column(
                  children: [
                    _inputBankAccountIndex == null
                        ? Container()
                        : Text(bankAccountsController
                            .bankAccounts[_inputBankAccountIndex].name),
                    chosingBankAccount(),
                    ElevatedButton(
                      onPressed: () {
                        if (_inputBankAccountIndex != null) {
                          if (bankAccountsController
                                  .bankAccounts[_inputBankAccountIndex]
                                  .balance <
                              billsController.bills[widget.index].mount) {
                            billPaymentStatus = 'No enouf balance';
                            setState(() {});
                          } else {
                            bankAccountsController
                                .bankAccounts[_inputBankAccountIndex]
                                .addingBalance(
                                    -billsController.bills[widget.index].mount);
                            bankAccountsController.updateBankAccount(
                                bankAccountsController
                                        .bankAccounts[_inputBankAccountIndex]
                                    as BankAccount);
                            billsController.bills[widget.index]
                                .changeIsPayment();
                            billsController.updateBill(
                                billsController.bills[widget.index]);
                            turnoversController.createTurnover(
                              Turnover(
                                mount:
                                    billsController.bills[widget.index].mount,
                                bankAccountId: _inputBankAccountIndex == null
                                    ? 0
                                    : bankAccountsController
                                        .bankAccounts[_inputBankAccountIndex]
                                        .id,
                                time: DateTime.now(),
                                turnoverType: TurnoverType.Cost.index,
                                description: 'bill paied!',
                              ),
                            );
                            setState(() {});
                          }
                        } else
                          print('Choose bank account!');
                      },
                      child: Text('Payment!'),
                    ),
                    Text(billPaymentStatus),
                  ],
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
