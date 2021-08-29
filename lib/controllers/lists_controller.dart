import 'package:billing_app/db/bank_accounts_database.dart';
import 'package:billing_app/models/bank_account.dart';
import 'package:billing_app/models/bill.dart';
import 'package:billing_app/models/turnover.dart';
import 'package:get/get.dart';

class ListViewController extends GetxController {
  var bankAccounts = [].obs;
  var bills = [].obs;
  var turnovers = [].obs;
  @override
  void onInit() {
    super.onInit();
    fetchListFromDatabase();
  }

  Future fetchListFromDatabase() async {
    await Future.delayed(Duration(seconds: 2));
    bankAccounts.value =
        await BankAccountsDatabase.instance.readAllBankAccount();
  }

  addBankAccount(BankAccount bankAccount) async {
    await BankAccountsDatabase.instance.createBankAccount(bankAccount);
    bankAccounts.add(bankAccount);
    print('new bank account created.');
  }

  deleteBankAccount(id) async {
    await BankAccountsDatabase.instance.deleteBankAccount(id);
    bankAccounts.removeWhere((element) => element.id == id);
    print('bank account id=$id removed.');
  }

  addBill(Bill bill) {
    bills.add(bill);
  }

  addTurnover(Turnover turnover) {
    turnovers.add(turnover);
  }
}
