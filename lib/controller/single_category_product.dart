import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/near_store_model.dart';
import 'package:fresh2_arrive/model/single_category_model.dart';
import 'package:fresh2_arrive/repositories/single_category_product.dart';
import 'package:get/get.dart';
import '../model/Store_Details_model.dart';
import '../repositories/Store_Details_Repo.dart';
import '../repositories/near_store_repository.dart';

class SingleCategoryController extends GetxController {
  RxBool isPaginationLoading = true.obs;
  RxBool isDataLoading = false.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 10.obs;
  RxString storeId = "".obs;
  RxString categoryId = "".obs;
  Rx<SingleCategoryModel> singleCategoryModel = SingleCategoryModel().obs;

  Future<dynamic> getData({isFirstTime = false, context}) async {
    if(isFirstTime){
      page.value = 1;
    }
    if ((isPaginationLoading.value && loadMore.value) || isFirstTime) {
      isPaginationLoading.value = false;
      isDataLoading.value = false;
      await singleCategoryProductRepo(
          page: page.value, pagination: pagination.value, context: context, id: categoryId.value, vendor_id: storeId.value)
          .then((value) {
        if (isFirstTime) {
          singleCategoryModel.value = value;
        }
        isPaginationLoading.value = true;
        isDataLoading.value = true;
        if (value.status!) {
          isDataLoading.value = true;
          page.value++;
          if (!isFirstTime) {
            singleCategoryModel.value.data!.addAll(value.data!);
          }
          loadMore.value = value.link!.next ?? false;
        }
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData(isFirstTime: true);
  }
}
