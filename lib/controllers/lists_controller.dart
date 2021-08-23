import 'package:billing_app/models/bank_account.dart';
import 'package:billing_app/models/bill.dart';
import 'package:billing_app/models/turnover.dart';
import 'package:get/get.dart';

class ListViewController extends GetxController {
  var accounts = [].obs;
  var bills = [].obs;
  var turnovers = [].obs;
  @override
  void onInit() {
    super.onInit();
  }

  addAccount(BankAccount account) {
    accounts.add(account);
  }

  addBill(Bill bill) {
    bills.add(bill);
  }

  addTurnover(Turnover turnover) {
    turnovers.add(turnover);
  }
}
