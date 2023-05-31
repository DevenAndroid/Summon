
import 'package:get/get.dart';

import '../model/GetNearByStores_Model.dart';
import '../repositories/GetNearByStores_Repo.dart';

class GetStoresOnMapController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<GetNearByStoreModel> model = GetNearByStoreModel().obs;



  Future getStoresOnMap() async {
    isDataLoading.value = false;
    await getNearByStores().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
