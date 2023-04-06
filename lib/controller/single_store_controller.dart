import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/near_store_model.dart';
import 'package:get/get.dart';
import '../model/Store_Details_model.dart';
import '../repositories/Store_Details_Repo.dart';
import '../repositories/near_store_repository.dart';

class SingleStoreController extends GetxController {
  RxBool isPaginationLoading = true.obs;
  RxBool isDataLoading = false.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 10.obs;
  RxString storeId = "".obs;
  Rx<NearStoreModel> model = NearStoreModel().obs;
  Rx<StoreDetailsModel> storeDetailsModel = StoreDetailsModel().obs;
Future<dynamic> getStoreDetails({isFirstTime = false, context}) async {
  if (isFirstTime) {
    page.value = 1;
  }
  if (isPaginationLoading.value && loadMore.value) {
    isPaginationLoading.value = false;
    isDataLoading.value = false;
    await storeDetailsRepo1(
        page: page.value,
        pagination: pagination.value,
        context: context,
        id: storeId.value)
        .then((value) {
      if (isFirstTime) {
        storeDetailsModel.value = value;
      }
      isPaginationLoading.value = true;
      isDataLoading.value = true;
      if (value.status!) {
        isDataLoading.value = true;
        page.value++;
        if (!isFirstTime) {
          storeDetailsModel.value.data!.latestProducts!.addAll(
              value.data!.latestProducts!);
        }
        loadMore.value = value.link!.next ?? false;
      }
    });
  }
}
}