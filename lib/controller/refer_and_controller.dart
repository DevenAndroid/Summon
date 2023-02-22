import 'package:fresh2_arrive/repositories/myAddress_repo.dart';
import 'package:fresh2_arrive/repositories/refer_and_earn_repo.dart';
import 'package:get/get.dart';
import '../model/MyAddressModel.dart';
import '../model/refer_and_earn_model.dart';

class ReferAndEarnController extends GetxController {
  RxBool isLoadingData = false.obs;
  Rx<ReferAndEarnModel> referAndEarnModel = ReferAndEarnModel().obs;
  RxString id = "".obs;

  getReferAndEarn() {
    referAndEarnRepo().then((value) {
      isLoadingData.value = true;
      referAndEarnModel.value = value;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getReferAndEarn();
  }
}
