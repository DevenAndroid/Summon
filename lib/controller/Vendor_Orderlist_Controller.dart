import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/Home_Search_Model.dart';
import '../model/Vendor_orderlist_model.dart';
import '../repositories/Homepage_search_Repo.dart';
import '../repositories/Vendor_Orderlist_Repo.dart';

class VendorOrderListController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorOrderListModel> model = VendorOrderListModel().obs;
  Rx<HomeSerachModel> searchDataModel = HomeSerachModel().obs;
  final searchController = TextEditingController();
  RxString filter = "".obs;
  RxString status = "".obs;

  vendorOrderListData() {
    isDataLoading.value = false;
    vendorOrderListRepo(filter: filter, status: status).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }

  getSearchData() async {
    homeSearchRepo(searchController.text.trim()).then((value) {
      searchDataModel.value = value;
    });
  }
}
