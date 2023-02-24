import 'package:fresh2_arrive/repositories/myAddress_repo.dart';
import 'package:get/get.dart';

import '../model/WithdrawalListModel..dart';
import '../repositories/withdrawalList_repo.dart';

class WithdrawalListController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<WithdrawalListModel> model = WithdrawalListModel().obs;

  getWithdrawalList() {
    myWithdrawalListRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
