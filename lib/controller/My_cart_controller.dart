import 'package:get/get.dart';
import '../model/Cart_Related_product_Model.dart';
import '../model/My_Cart_Model.dart';
import '../repositories/Cart_Related_Product.Repo.dart';
import '../repositories/My_Cart_Repo.dart';

class MyCartDataListController extends GetxController {
  Rx<MyCartData> model = MyCartData().obs;
  Rx<CartRelatedProductModel> relatedProductModel =
      CartRelatedProductModel().obs;
  RxBool isDataLoaded = false.obs;

  getAddToCartList() {
    myCartRepo().then((value) {
      isDataLoaded.value = true;
      model.value = value;
    });
  }

  getAddToCartRelatedList() {
    addToCartRelatedRepo().then((value) {
      isDataLoaded.value = true;
      relatedProductModel.value = value;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAddToCartList();
    getAddToCartRelatedList();
  }
}
