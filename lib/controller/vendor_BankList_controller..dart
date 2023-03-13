import 'package:get/get.dart';

import '../model/VendorBankLIst_Model.dart';
import '../repositories/Vendor_BankList_Repo.dart';

class VendorBankListController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorBankListModel> bankListModel = VendorBankListModel().obs;

  getVendorBankListDetails() {
    isDataLoading = false.obs;
    vendorBankListRepo().then((value) {
      isDataLoading = true.obs;
      bankListModel.value = value;
    });
  }
}
