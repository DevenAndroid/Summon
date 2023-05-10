import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/near_store_model.dart';
import 'package:get/get.dart';
import '../model/Store_Details_model.dart';
import '../repositories/Store_Details_Repo.dart';
import '../repositories/near_store_repository.dart';

extension Anjali on StoreDetailsModel {
  Variants getVariant({required int index}) {
    return this.data!.latestProducts![index].variants!.firstWhere(
            (element) =>
        element.size.toString() ==
            this.data!.latestProducts![index].varientIndex!.value.toString() || element.size.toString().isEmpty,
        orElse: () => Variants());
  }
}

class SingleStoreController extends GetxController {
  RxBool isPaginationLoading = true.obs;
  RxBool isDataLoading = false.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 20.obs;
  RxString storeId = "".obs;
  TextEditingController searchController = TextEditingController();
  Rx<NearStoreModel> model = NearStoreModel().obs;
  Rx<StoreDetailsModel> storeDetailsModel = StoreDetailsModel().obs;
Future<dynamic> getStoreDetails({bool? isFirstTime = false, context}) async {
  if (isFirstTime!) {
    page.value = 1;
    isPaginationLoading.value = true;
    isDataLoading.value = true;
    if(storeDetailsModel.value.data != null){
      storeDetailsModel.value = StoreDetailsModel();
    }
    // storeDetailsModel.value.data!.latestProducts!.clear();
  }
  if ((isPaginationLoading.value && loadMore.value) || isFirstTime) {
    //log("Anjali");
    isPaginationLoading.value = false;
    isDataLoading.value = false;
    await storeDetailsRepo1(
        page: page.value,
        pagination: pagination.value,
        context: context,
        id: storeId.value,
        search: searchController.text
    )
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
        loadMore.value = value.link?.next ?? false;
      }
    });
  }
}
  @override
  void onInit() {
    super.onInit();
    getStoreDetails(isFirstTime: true);
  }
}

