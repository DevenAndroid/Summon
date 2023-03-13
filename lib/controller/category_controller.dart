import 'package:get/get.dart';
import '../model/category_model.dart';
import '../repositories/category_repository.dart';

class CategoryController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<CategoryModel> model = CategoryModel(data: []).obs;
  RxBool isPaginationLoading = true.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 30.obs;
  RxString storeId = "".obs;

  Future<dynamic> getData({isFirstTime = false, context}) async {
    if(isFirstTime){
      page.value = 1;
    }
    if (isPaginationLoading.value && loadMore.value) {
      isPaginationLoading.value = false;
      await categoryData(
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

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
