import 'package:fresh2_arrive/model/coupon_mpdel.dart';
import 'package:fresh2_arrive/model/home_page_model.dart';
import 'package:fresh2_arrive/repositories/coupons_repository.dart';
import 'package:get/get.dart';
import '../repositories/home_page_repository.dart';


class HomePageController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<HomePageModel> model = HomePageModel().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }
  getData() async {
    isDataLoading.value = false;
    homeData().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
