import 'package:get/get.dart';
import '../model/Addons_Model.dart';
import '../model/ViewAllRecommended_Model.dart';
import '../repositories/Addons_Repogitory.dart';
import '../repositories/ViewAll_recommeded_Repo.dart';

class ViewALlRecommendedController extends GetxController {
  RxBool isDataLoading = false.obs;
  //RxString keyword = "".obs;

  Rx<ViewAllRecommendedModel> model = ViewAllRecommendedModel().obs;

  Future getViewAllRecommendedData() async {
    isDataLoading.value = false;
    await viewAllRecommendedData().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
