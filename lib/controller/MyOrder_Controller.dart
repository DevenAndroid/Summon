import 'package:get/get.dart';

import '../model/MyOrder_Model.dart';
import '../repositories/MyOrders_Repo.dart';

class MyOrderController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<MyOrdersModel> model = MyOrdersModel().obs;

  getMyOrder() {
    isDataLoading.value = false;
    myOrderRepo().then((value) {
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
