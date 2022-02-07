import 'package:billing_app/controllers/bank_accounts_controller.dart';
import 'package:billing_app/models/bank_account.dart';
import 'package:get/get.dart';

String getTurnoverType(int index) {
  if (index == 0) {
    return "Income";
  } else if (index == 1) {
    return "Cost";
  } else if (index == 2) {
    return "FutureCost";
  } else {
    return "All";
  }
}

BankAccount getBankAccount(int id) {
  final controller = Get.put(BankAccountsController());
  for (var i = 0; i < controller.bankAccounts.length; i++) {
    if (controller.bankAccounts[i].id == id) {
      return controller.bankAccounts[i];
    }
  }
  return null;
}
