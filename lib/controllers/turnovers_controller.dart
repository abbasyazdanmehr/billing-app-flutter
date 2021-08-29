import 'package:billing_app/db/turnovers_database.dart';
import 'package:billing_app/models/turnover.dart';
import 'package:get/get.dart';

class TurnoversController extends GetxController {
  var turnovers = [].obs;
  @override
  void onInit() {
    super.onInit();
    fetchTurnoversFromDatabase();
  }

  Future fetchTurnoversFromDatabase() async {
    await Future.delayed(Duration(seconds: 2));
    turnovers.value = await TurnoversDatabase.instance.readAllTurnovers();
  }

  createTurnover(Turnover turnover) async {
    await TurnoversDatabase.instance.createTurnover(turnover);
    turnovers.add(turnover);
    print('new turnover created.');
  }

  deleteTurnover(id) async {
    await TurnoversDatabase.instance.deleteTurnover(id);
    turnovers.removeWhere((element) => element.id == id);
    print('turnover id=$id removed.');
  }
}
