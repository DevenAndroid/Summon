import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/MyOrder_Model.dart';
import '../repositories/MyOrders_Repo.dart';

class MyOrderController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<MyOrdersModel> model = MyOrdersModel().obs;
  RxString filter = "".obs;
  RxString status = "".obs;
  RxString selectedDate = "".obs;
  RxString selectedDate1 = "".obs;
  getMyOrder() {
    isDataLoading.value = false;
    myOrderRepo(filter: filter, status: status, start_date: DateFormat("yyyy-MM-dd").format(DateTime.parse(selectedDate.value == "" ? DateTime.now().toString()
            : selectedDate.value)), end_date: DateFormat("yyyy-MM-dd").format(DateTime.parse(selectedDate1.value == "" ? DateTime.now().toString()
        : selectedDate1.value))).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   getMyOrder();
  // }
}
