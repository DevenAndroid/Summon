import 'package:fresh2_arrive/repositories/myAddress_repo.dart';
import 'package:get/get.dart';

import '../model/GetAddressModel.dart';
import '../model/MyAddressModel.dart';

class MyAddressController extends GetxController {
  RxBool isAddressLoad = false.obs;
  RxBool isSaveAddressLoad = false.obs;
  Rx<MyAddressModel> myAddressModel = MyAddressModel().obs;
  Rx<GetMyAddressModel> getSaveAddressModel = GetMyAddressModel().obs;
  RxString id = "".obs;

  String? latLong1;
  String? latLong2;

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
