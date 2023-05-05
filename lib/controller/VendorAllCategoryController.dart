import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/VendorAllCategories_Model.dart';
import '../model/VendorBankDetails_Model.dart';
import '../repositories/VendorAllCategories_repo.dart';

class VendorAllCategoryController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorAllCategoriesModel> model = VendorAllCategoriesModel().obs;


  Future getVendorAllCategory() async {
    isDataLoading = false.obs;
    await vendorAllCategoryRepo().then((value) {
      isDataLoading = true.obs;
      model.value = value;
    });
  }
}
