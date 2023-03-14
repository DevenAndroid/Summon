import 'package:get/get.dart';
import '../model/Cart_Related_product_Model.dart';
import '../model/My_Cart_Model.dart';
import '../repositories/Cart_Related_Product.Repo.dart';
import '../repositories/My_Cart_Repo.dart';

class CartRelatedProductController extends GetxController {
  Rx<MyCartData> model = MyCartData().obs;
  Rx<CartRelatedProductModel> relatedProductModel = CartRelatedProductModel().obs;
  RxBool isDataLoading = false.obs;
  RxInt sum = 0.obs;

  getAddToCartRelatedList() {
    isDataLoading.value = false;
    addToCartRelatedRepo().then((value) {
      isDataLoading.value = true;
      relatedProductModel.value = value;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAddToCartRelatedList();
  }
}
