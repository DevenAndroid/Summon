// import 'package:fresh2_arrive/model/coupon_mpdel.dart';
// import 'package:fresh2_arrive/model/delivery_mode_update.dart';
// import 'package:fresh2_arrive/repositories/coupons_repository.dart';
// import 'package:get/get.dart';
//
// import '../repositories/driver_mode_update_repo.dart';
//
// class DeliveryModeUpdateController extends GetxController {
//   RxBool isDataLoading = false.obs;
//   Rx<DeliveryModeUpdateModel> model = DeliveryModeUpdateModel().obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     getData();
//   }
//
//   getData() async {
//     isDataLoading.value = false;
//     deliveryModeUpdateRepo().then((value) {
//       isDataLoading.value = true;
//       model.value = value;
//     });
//   }
// }