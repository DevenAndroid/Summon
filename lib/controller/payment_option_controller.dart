import 'package:fresh2_arrive/model/coupon_mpdel.dart';
import 'package:fresh2_arrive/model/delivery_mode_update.dart';
import 'package:fresh2_arrive/model/payment_option_model.dart';
import 'package:fresh2_arrive/repositories/coupons_repository.dart';
import 'package:get/get.dart';
import '../repositories/driver_mode_update_repo.dart';
import '../repositories/payment_option_repo.dart';

class PaymentOptionController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<PaymentOptionModel> model = PaymentOptionModel().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isDataLoading.value = false;
    paymentOptionRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}