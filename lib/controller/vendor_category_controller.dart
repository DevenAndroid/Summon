import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/vendor_category_model.dart';
import '../repositories/vendor_categories_repo.dart';

class VendorCategoryController extends GetxController{

  final TextEditingController categoryController = TextEditingController();

  Rx<CategoriesModel> model = CategoriesModel().obs;
  RxBool isDataLoaded = false.obs;
  Future getCategory() async {
    await vendorCategoryRepo().then((value1) {
      model.value = value1;
      if(value1.status == true){
        isDataLoaded.value = true;
      }
    });
  }
}