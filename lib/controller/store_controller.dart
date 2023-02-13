import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/near_store_model.dart';
import 'package:get/get.dart';
import '../model/Store_Details_model.dart';
import '../repositories/Store_Details_Repo.dart';
import '../repositories/near_store_repository.dart';

class StoreController extends GetxController {
  RxBool isPaginationLoading = true.obs;
  RxBool isDataLoading = false.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 2.obs;
  Rx<NearStoreModel> model = NearStoreModel().obs;
  // RxList<NearStoreData> nearStoreData = <NearStoreData>[].obs;

  // final scrollController = ScrollController();
  Rx<StoreDetailsModel> storeDetailsModel = StoreDetailsModel().obs;

  Future<dynamic> getData({isFirstTime = false, context}) async {
    if (isPaginationLoading.value && loadMore.value) {
      isPaginationLoading.value = false;
      await loadWithPagination(
              page: page.value, pagination: pagination.value, context: context)
          .then((value) {
        if (isFirstTime) {
          model.value = value;
        }
        isPaginationLoading.value = true;
        if (value.status!) {
          isDataLoading.value = true;
          page.value++;
          if (!isFirstTime) {
            model.value.data!.addAll(value.data!);
          }
          loadMore.value = value.link!.next ?? false;
        }
      });
    }
  }

  getStoreDetails() {
    isDataLoading.value = true;
    storeDetailsRepo().then((value) {
      storeDetailsModel.value = value;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getData(isFirstTime: true);
  }
}
