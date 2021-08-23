import 'package:billing_app/enums/turnover_type.dart';
import 'package:get/get.dart';

class SmallObjectController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    turnoverType.add(TurnoverType.All);
  }

  var turnoverType = <TurnoverType>[].obs;
  setTurnOver(TurnoverType type) {
    turnoverType[0] = type;
  }
}
