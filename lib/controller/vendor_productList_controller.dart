import 'package:get/get.dart';

import '../model/VendorProductList_Model.dart';
import '../repositories/VendorProductList_Repo.dart';

class VendorProductListController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorProductListModel> model = VendorProductListModel().obs;

  getVendorProductList() {
    vendorProductListRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
