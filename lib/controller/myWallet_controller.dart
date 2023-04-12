import 'dart:developer';

import 'package:fresh2_arrive/repositories/my_walllet_repo.dart';
import 'package:get/get.dart';

import '../model/MyWallet_model..dart';

class MyWalletController extends GetxController {


  //
  // RxBool isDataLoading = false.obs;
  // Rx<MyWalletModel> model = MyWalletModel().obs;
  // RxString userType = "".obs;
  //
  // getWalletData() {
  //   isDataLoading.value = false;
  //   myWalletRepo(user_type: userType).then((value) {
  //     isDataLoading.value = true;
  //     model.value = value;
  //   });
  // }


  RxBool isPaginationLoading = true.obs;
  RxBool isDataLoading = false.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 20.obs;
  RxString userType = "".obs;
  Rx<MyWalletModel> model = MyWalletModel().obs;
  Future<dynamic> getWalletData({bool? isFirstTime = false, context}) async {
    if (isFirstTime!) {
      page.value = 1;
      isPaginationLoading.value = true;
      isDataLoading.value = true;
      if(model.value.data != null){
        model.value = MyWalletModel();
      }
    }
    if ((isPaginationLoading.value && loadMore.value) || isFirstTime) {
      log("Anjali");
      isPaginationLoading.value = false;
      isDataLoading.value = false;
      await myWalletRepo(
          page: page.value,
          pagination: pagination.value,
          context: context,
          user_type: userType
      )
          .then((value) {
        if (isFirstTime) {
          model.value = value;
        }
        isPaginationLoading.value = true;
        isDataLoading.value = true;
        if (value.status!) {
          isDataLoading.value = true;
          page.value++;
          if (!isFirstTime) {
            model.value.data!.walletTransactions!.addAll(
                value.data!.walletTransactions!);
          }
          loadMore.value = value.link!.next ?? false;
        }
      });
    }
  }
  @override
  void onInit() {
    super.onInit();
    getWalletData(isFirstTime: true);
  }
}
