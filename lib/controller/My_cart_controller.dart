import 'package:get/get.dart';
import '../model/My_Cart_Model.dart';
import '../repositories/My_Cart_Repo.dart';

class MyCartDataListController extends GetxController {
  Rx<MyCartData> model = MyCartData().obs;
  RxBool isDataLoaded = false.obs;

  getAddToCartList() {
    myCartRepo().then((value) {
      isDataLoaded.value = true;
      model.value = value;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAddToCartList();
  }
}
