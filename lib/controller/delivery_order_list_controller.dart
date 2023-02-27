import 'package:fresh2_arrive/model/coupon_mpdel.dart';
import 'package:fresh2_arrive/model/driver_delivery_order_list.dart';
import 'package:fresh2_arrive/repositories/coupons_repository.dart';
import 'package:fresh2_arrive/repositories/delivery_order_request_list.dart';
import 'package:get/get.dart';

class DeliveryOrderListController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<DriverDeliveryOrderList> model = DriverDeliveryOrderList().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isDataLoading.value = false;
    driverDeliveryOrderListRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
