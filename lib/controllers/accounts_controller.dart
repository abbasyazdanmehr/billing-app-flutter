import 'package:billing_app/models/bank_account.dart';
import 'package:get/get.dart';

class AccountsController extends GetxController {
  var accounts = [].obs;
  @override
  void onInit() {
    super.onInit();
  }

  addAccount(BankAccount account) {
    accounts.add(account);
  }
}
