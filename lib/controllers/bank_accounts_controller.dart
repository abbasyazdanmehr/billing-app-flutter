import 'package:billing_app/db/bank_accounts_database.dart';
import 'package:billing_app/models/bank_account.dart';
import 'package:get/get.dart';

class BankAccountsController extends GetxController {
  var bankAccounts = [].obs;
  @override
  void onInit() {
    super.onInit();
    fetchBankAccountsFromDatabase();
  }

  Future fetchBankAccountsFromDatabase() async {
    await Future.delayed(Duration(seconds: 2));
    bankAccounts.value =
        await BankAccountsDatabase.instance.readAllBankAccount();
  }

  createBankAccount(BankAccount bankAccount) async {
    await BankAccountsDatabase.instance.createBankAccount(bankAccount);
    bankAccounts.add(bankAccount);
    print('new bank account created.');
  }

  deleteBankAccount(id) async {
    await BankAccountsDatabase.instance.deleteBankAccount(id);
    bankAccounts.removeWhere((element) => element.id == id);
    print('bank account id=$id removed.');
  }
}
