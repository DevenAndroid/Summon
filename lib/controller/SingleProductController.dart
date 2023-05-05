
import 'dart:convert';

import 'package:get/get.dart';

import '../model/SingleProductModel.dart';

import '../repositories/SingleProduct_Repo.dart';

class SingleProductController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<SingleProductModel> model = SingleProductModel().obs;
  RxString id = "".obs;

  getSingleProductData() {
    isDataLoading.value = false;
    singleProductRepo(id: id.value).then((value) {
      isDataLoading.value = true;
      model.value = value;
      // print the model value
      ///print(jsonEncode(model.value));
    });
  }

  @override
  void onInit() {
    super.onInit();
    //getData();
  }
}
