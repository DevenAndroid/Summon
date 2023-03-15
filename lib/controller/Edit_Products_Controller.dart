import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/user_profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../model/ListModel.dart';
import '../model/VendorEditProduct_model.dart';
import '../repositories/VendorEditProduct_repo.dart';
import '../repositories/user_profile_repository.dart';

class EditProductsController extends GetxController {
  RxBool isDataLoading = false.obs;
  RxString id = "".obs;
  Rx<VendorEditProductModel> editModel = VendorEditProductModel().obs;
  bool initialSelect = false;
  RxList<ListModel> listModelData = <ListModel>[].obs;

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController qtyTypeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController minQtyController = TextEditingController();
  final TextEditingController maxQtyController = TextEditingController();
  final TextEditingController marketPriceController = TextEditingController();

  getEditProductData() async {
    isDataLoading.value = false;
    vendorEditProductRepo(id: id).then((value) {
      isDataLoading.value = true;
      editModel.value = value;
      listModelData.clear();
      for (var element in editModel.value.data!.productsVariant!) {
        listModelData.add(ListModel(
            marketPrice: element.marketPrice.toString().obs,
            qty: element.variantQty.toString().obs,
            price: element.price.toString().obs,
            minQty: element.minQty.toString().obs,
            maxQty: element.maxQty.toString().obs,
            qtyType: element.variantQtyType.toString().obs,
            varientId: element.id.toString().obs));
      }
    });
  }
}
