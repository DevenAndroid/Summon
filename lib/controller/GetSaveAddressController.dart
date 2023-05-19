import 'package:fresh2_arrive/repositories/myAddress_repo.dart';
import 'package:get/get.dart';

import '../model/GetAddressModel.dart';
import '../model/MyAddressModel.dart';
import '../repositories/add_address_repository.dart';

class GetSaveAddressController extends GetxController {

  RxBool isSaveAddressLoad = false.obs;

  Rx<GetMyAddressModel> getSaveAddressModel = GetMyAddressModel().obs;
  RxString addressId = "".obs;



  saveAddressData() {
    getSaveAddress(address_id: addressId.value).then((value) {
      isSaveAddressLoad.value = true;
      getSaveAddressModel.value = value;
    });
  }
@override
  void onInit() {
    super.onInit();
    saveAddressData();
  }

}
