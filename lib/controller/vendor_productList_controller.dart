import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/VendorProductList_Model.dart';
import '../repositories/VendorProductList_Repo.dart';

class VendorProductListController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorProductListModel> model = VendorProductListModel().obs;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController vendorSearchProductController =
      TextEditingController();

  getVendorProductList() {
    vendorProductListRepo(
      keyword: searchController.text.trim(),
    ).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
