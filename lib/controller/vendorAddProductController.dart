import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/ListModel.dart';
import '../model/VendorAddProduct_Model.dart';
import '../model/VendorSearchProductsModel.dart';
import '../repositories/VendorAddProduct_Repo.dart';
import '../repositories/vendor_product_search_repo..dart';

class VendorAddProductController extends GetxController {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController qtyTypeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController minQtyController = TextEditingController();
  final TextEditingController maxQtyController = TextEditingController();
  final TextEditingController marketPriceController = TextEditingController();
  RxString productId = "".obs;
  RxString qtyType = "".obs;
  RxBool isDataLoading = false.obs;
  RxList<ListModel> listModelData = <ListModel>[].obs;
  Rx<VendorSearchProductModel> model = VendorSearchProductModel().obs;
  Rx<VendorAddProductModel> vendorAddProductModel = VendorAddProductModel().obs;
  final TextEditingController vendorSearchProductController =
      TextEditingController();
// this method working for search the product on ADD product pages
  getVendorSearchProductList() {
    vendorSearchProductListRepo(
      keyword: vendorSearchProductController.text.trim(),
    ).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }

  bool initialSelect = false;

  getVendorAddProduct() {
    vendorAddProductRepo(id: productId.value).then((value) {
      isDataLoading.value = true;
      vendorAddProductModel.value = value;
      initialSelect = false;
    });
  }
}
