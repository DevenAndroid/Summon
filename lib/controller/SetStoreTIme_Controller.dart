import 'package:get/get.dart';

import '../model/SetStoreTimeModel.dart';
import '../repositories/Set_storeTime_Repo.dart';

class SetStoreTimeControlller extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<SetStoreTimeModel> model = SetStoreTimeModel().obs;
  RxInt storeTimeId=0.obs;

  getSetStoreTime() {
    setStoreTimeRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
