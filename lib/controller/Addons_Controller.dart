import 'package:get/get.dart';
import '../model/Addons_Model.dart';
import '../repositories/Addons_Repogitory.dart';

class AddonsController extends GetxController {
  RxBool isDataLoading = false.obs;
  //RxString keyword = "".obs;

  Rx<AddonsModel> model = AddonsModel().obs;

  Future getAddonsData() async {
    isDataLoading.value = false;
    await addOnsRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
