import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/Home_Search_Model.dart';
import '../model/Vendor_orderlist_model.dart';
import '../repositories/Vendor_Orderlist_Repo.dart';

class VendorOrderListController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorOrderListModel> model = VendorOrderListModel().obs;
  Rx<HomeSerachModel> searchDataModel = HomeSerachModel().obs;
  final searchController = TextEditingController();
  RxString filter = "".obs;
  RxString status = "".obs;
  RxString selectedDate = "".obs;
  RxString selectedDate1 = "".obs;

  vendorOrderListData() {
    isDataLoading.value = false;
    vendorOrderListRepo(
      keyword: searchController.text.trim(),
      filter: filter,
      status: status,
      start_date: DateFormat("yyyy-MM-dd").format(DateTime.parse(
          selectedDate.value == ""
              ? DateTime.now().toString()
              : selectedDate.value)),
      end_date: DateFormat("yyyy-MM-dd").format(DateTime.parse(
          selectedDate1.value == ""
              ? DateTime.now().toString()
              : selectedDate1.value)),
    ).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }

  // getSearchData() async {
  //   homeSearchRepo(searchController.text.trim()).then((value) {
  //     searchDataModel.value = value;
  //   });
  // }
}
