import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/near_store_model.dart';
import 'package:get/get.dart';
import '../repositories/near_store_repository.dart';

class NearStoreController extends GetxController {
  RxBool isPaginationLoading = true.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 2.obs;
  Rx<NearStoreModel> model = NearStoreModel().obs;
  RxList<NearStoreData> nearStoreData = <NearStoreData>[].obs;

  // final scrollController = ScrollController();

  getData() {
    if (isPaginationLoading.value) {
      if (loadMore.value) {
        loadWithPagination(page: page.value, pagination: pagination.value)
            .then((value) {
          isPaginationLoading.value = false;
          model.value = value;
          if (value.status!) {
            isPaginationLoading.value = true;
            nearStoreData.addAll(model.value.data!);
            loadMore.value = value.link!.next ?? false;
          } else {}
          isPaginationLoading.value = false;
          // showToast(value.message.toString());
        });
      }
    }
  }

  // void _scrollListener() {
  //   isDataLoading.value = true;
  //   if (loadMore.value) {
  //     if (scrollController.position.pixels ==
  //         scrollController.position.maxScrollExtent) {
  //       page.value = page.value + 1;
  //       getData();
  //       print(page.value);
  //     } else {
  //       print("Dont call");
  //     }
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    getData();
    // scrollController.addListener(_scrollListener);
  }
}
