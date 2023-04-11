import 'package:fresh2_arrive/model/near_store_model.dart';
import 'package:get/get.dart';
import '../repositories/store_by_category.dart';

class StoreByCategoryController extends GetxController {
  RxBool isPaginationLoading = true.obs;
  RxBool isDataLoading = false.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 10.obs;
  RxString storeId = "".obs;
  Rx<NearStoreModel> model = NearStoreModel().obs;

  Future<dynamic> getData({isFirstTime = false, context}) async {
    if (isFirstTime) {
      page.value = 1;
      isDataLoading.value = false;
      isPaginationLoading.value = true;
      loadMore.value = true;
    }
    if (isPaginationLoading.value && loadMore.value) {
      isPaginationLoading.value = false;
      await loadWithPagination2(
              page: page.value,
              pagination: pagination.value,
              id: storeId.value,
              context: context)
          .then((value) {
        isPaginationLoading.value = true;
        if (value.status!) {
          isDataLoading.value = true;
          page.value++;
          if (isFirstTime) {
            model.value = value;
          } else{
            model.value.data!.addAll(value.data!);
          }
          loadMore.value = value.link!.next ?? false;
        }
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
