import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/coupon_mpdel.dart';
import 'package:fresh2_arrive/model/driver_delivery_order_list.dart';
import 'package:fresh2_arrive/model/driver_information_model.dart';
import 'package:fresh2_arrive/repositories/coupons_repository.dart';
import 'package:fresh2_arrive/repositories/delivery_order_request_list.dart';
import 'package:get/get.dart';

import '../repositories/driver_imformation_repo.dart';

class DriverInformationController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<DriverInformationModel> model = DriverInformationModel().obs;
  final TextEditingController adharNoController = TextEditingController();
  final TextEditingController panNoController = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController vehicleNumber = TextEditingController();
  final TextEditingController licenceNumber = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isDataLoading.value = false;
    driverInformationRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
