import 'package:fresh2_arrive/repositories/myAddress_repo.dart';
import 'package:get/get.dart';

import '../model/MyAddressModel.dart';

class MyAddressController extends GetxController {
  RxBool isAddressLoad = false.obs;
  Rx<MyAddressModel> myAddressModel = MyAddressModel().obs;
  RxString id = "".obs;

  getAddress() {
    myAddressRepo().then((value) {
      isAddressLoad.value = true;
      myAddressModel.value = value;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAddress();
  }
}
