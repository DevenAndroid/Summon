import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/VendorBankDetails_Model.dart';
import '../repositories/VendorBankDetails_Repo.dart';

class VendorBankDetailsController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorBankDetailsModel> bankDetailsModel = VendorBankDetailsModel().obs;

  final TextEditingController bankAccountNumber = TextEditingController();
  final TextEditingController accountHolderName = TextEditingController();
  final TextEditingController iFSCCode = TextEditingController();

  getVendorBankDetails() {
    isDataLoading = false.obs;
    vendorBankDetailsRepo().then((value) {
      isDataLoading = true.obs;
      bankDetailsModel.value = value;
    });
  }
}
