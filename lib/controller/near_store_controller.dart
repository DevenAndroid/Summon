import 'package:fresh2_arrive/model/near_store_model.dart';
import 'package:get/get.dart';
import '../repositories/near_store_repository.dart';

class NearStoreController extends GetxController {
  // RxBool isDataLoading = false.obs;
  // Rx<NearStoreModel> model = NearStoreModel().obs;
  // RxList<NearStoreData> nearStoreList = <NearStoreData>[].obs;
  // Rx<RxStatus> status1 = RxStatus.empty().obs;
  // int page1 = 1;
  // RxBool isLoadingMore = false.obs;

  RxBool isDataLoading = true.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 2.obs;
  Rx<NearStoreModel> model = NearStoreModel().obs;
  RxList<NearStoreData> nearStoreData = <NearStoreData>[].obs;

  getData() {
    if(isDataLoading.value){
      if(loadMore.value){
        loadWithPagination(
            page: page.value,
            pagination: pagination.value).then((value) {
          model.value = value;
          if (value.status!) {
            nearStoreData.addAll(model.value.data!);
            loadMore.value = value.link!.next ?? false;
          } else {
          }
          isDataLoading.value = false;
          // showToast(value.message.toString());
        });
      }
    }
  }
}
