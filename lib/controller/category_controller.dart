import 'package:get/get.dart';

import '../model/category_model.dart';
import '../repositories/category_repository.dart';

class CategoryController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<CategoryModel> model = CategoryModel().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    isDataLoading.value = false;
    categoryData(Get.context).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
