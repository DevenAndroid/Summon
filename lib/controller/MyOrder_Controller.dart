import 'package:get/get.dart';

import '../model/MyOrder_Model.dart';
import '../repositories/MyOrders_Repo.dart';

class MyOrderController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<MyOrdersModel> model = MyOrdersModel().obs;
  RxString filter = "".obs;
  RxString status = "".obs;

  getMyOrder() {
    isDataLoading.value = false;
    myOrderRepo(filter: filter, status: status).then((value) {
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
