import 'package:get/get.dart';

import '../model/MyOrderDetails_Model.dart';
import '../repositories/MyOrderDetails_Repo.dart';

class MyOrderDetailsController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<MyOrdersDetailsModel> model = MyOrdersDetailsModel().obs;
  RxString id = "".obs;

  getMyOrderDetails() {
    isDataLoading.value = false;
    myOrderDetailsRepo(id: id).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getMyOrderDetails();
  }
}
