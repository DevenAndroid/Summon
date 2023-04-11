// import 'package:fresh2_arrive/model/check_out_model.dart';
// import 'package:fresh2_arrive/model/coupon_mpdel.dart';
// import 'package:fresh2_arrive/repositories/check_out_repository.dart';
// import 'package:fresh2_arrive/repositories/coupons_repository.dart';
// import 'package:get/get.dart';
//
// class CheckOutController extends GetxController {
//   RxBool isDataLoading = false.obs;
//   Rx<CheckOutDataModel> model = CheckOutDataModel().obs;
//   RxString type = "".obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     getData();
//   }
//
//   getData() async {
//     isDataLoading.value = false;
//     checkOut(context: Get.context).then((value) {
//       isDataLoading.value = true;
//       model.value = value;
//     });
//   }
// }
