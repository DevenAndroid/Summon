import 'package:fresh2_arrive/model/assigned_order_list.dart';
import 'package:fresh2_arrive/repositories/assigend_order_list_repo.dart';
import 'package:get/get.dart';

class AssignedOrderController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<AssignedOrderList> model = AssignedOrderList().obs;
  RxString status = "".obs;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isDataLoading.value = false;
    assignedOrderListRepo(status: status.value).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
