import 'package:fresh2_arrive/model/coupon_mpdel.dart';
import 'package:fresh2_arrive/repositories/coupons_repository.dart';
import 'package:get/get.dart';

class CouponController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<CouponModel> model = CouponModel().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isDataLoading.value = false;
    couponData(Get.context).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
