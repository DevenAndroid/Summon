import 'package:fresh2_arrive/model/coupon_mpdel.dart';
import 'package:fresh2_arrive/repositories/coupons_repository.dart';
import 'package:fresh2_arrive/repositories/notification_repository.dart';
import 'package:get/get.dart';

import '../model/notification_model.dart';

class NotificationController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<NotificationModel> model = NotificationModel().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isDataLoading.value = false;
    notificationRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
