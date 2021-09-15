import 'package:billing_app/db/bills_database.dart';
import 'package:billing_app/models/bill.dart';
import 'package:get/get.dart';

class BillsController extends GetxController {
  var bills = [].obs;
  @override
  void onInit() {
    super.onInit();
    fetchBillsFromDatabase();
  }

  Future fetchBillsFromDatabase() async {
    await Future.delayed(Duration(seconds: 2));
    bills.value = await BillsDatabase.instance.readAllBills();
  }

  createBill(Bill bill) async {
    await BillsDatabase.instance.createBill(bill);
    bills.add(bill);
    print('new bank bill created.');
  }

  updateBill(Bill bill) async {
    await BillsDatabase.instance.updateBill(bill);
    print('bill updated');
  }

  deleteBill(id) async {
    await BillsDatabase.instance.deleteBill(id);
    bills.removeWhere((element) => element.id == id);
    print('bank account id=$id removed.');
  }
}
