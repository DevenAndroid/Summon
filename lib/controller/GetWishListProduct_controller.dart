import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/Addons_Model.dart';
import '../model/WishListProduct_Model.dart';
import '../repositories/Addons_Repogitory.dart';
import '../repositories/GetWishList_product.repo.dart';

class GetWishListProduct extends GetxController {
  RxBool isDataLoading = false.obs;
  //RxString keyword = "".obs;

  Rx<WishListProductModel> model = WishListProductModel().obs;

  Future getWishListProduct() async {
    isDataLoading.value = false;
    await getWishListProductRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
