import 'package:fresh2_arrive/repositories/my_walllet_repo.dart';
import 'package:get/get.dart';

import '../model/MyWallet_model..dart';

class MyWalletController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<MyWallletModel> model = MyWallletModel().obs;
  RxString userType = "".obs;

  getWalletData() {
    isDataLoading.value = false;
    myWalletRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
