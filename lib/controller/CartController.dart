import 'package:get/get.dart';
import '../model/Cart_Related_product_Model.dart';
import '../model/MyCartDataListModel.dart';
import '../model/My_Cart_Model.dart';
import '../model/model_common_ressponse.dart';
import '../repositories/Cart_Related_Product.Repo.dart';
import '../repositories/My_Cart_Repo.dart';

class MyCartController extends GetxController {
  Rx<MyCartDataModel1> model = MyCartDataModel1().obs;
  RxBool isDataLoaded = false.obs;

  //RxBool isRelatedProductDataLoaded = false.obs;
  RxInt sum = 0.obs;

  getCartData() {
    myCartDataRepo().then((value) {
      isDataLoaded.value = true;
      model.value = value;
      sum.value = 0;
      for (int i = 0; i < value.data!.cartItems!.length; i++) {
        sum.value = sum.value +
            int.parse(value.data!.cartItems![i].cartItemQty.toString());
        print("sum of cart value is ..${sum.value}");
      }
    });
  }

}
