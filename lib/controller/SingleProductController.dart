
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/SingleProductModel.dart';

import '../repositories/SingleProduct_Repo.dart';
import '../widgets/add_text.dart';

class SingleProductController extends GetxController {
  RxBool isDataLoading = false.obs;
  TextEditingController noteController=TextEditingController();
  Rx<SingleProductModel> model = SingleProductModel().obs;
  RxString id = "".obs;
  RxInt counter = 1.obs;


  increaseQty(){
    counter=counter++;
  }
  decreaseQty(){
    if(counter.value>1 && counter.value != 1){
      counter=counter--;
    }
    else{
      showToast("Qty should be 1");
    }


  }

  Future getSingleProductData() async {
    isDataLoading.value = false;
    await singleProductRepo(id: id.value).then((value) {
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
