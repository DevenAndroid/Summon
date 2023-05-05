import 'package:get/get.dart';


import '../model/VarientSize_Model.dart';

import '../repositories/VarientSizeData_Repo.dart';

class VarientSizeController extends GetxController {
  RxBool isDataLoading = false.obs;
  //RxString keyword = "".obs;

  Rx<SizeData_Model> model = SizeData_Model().obs;

  Future getSizeData() async {
    isDataLoading.value = false;
    await sizeDataRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
