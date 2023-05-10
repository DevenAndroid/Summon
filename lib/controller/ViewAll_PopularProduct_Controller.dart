import 'package:get/get.dart';
import '../model/Addons_Model.dart';
import '../model/ViewAllRecommended_Model.dart';
import '../model/ViewAll_PopularModel.dart';
import '../repositories/Addons_Repogitory.dart';
import '../repositories/ViewAll_Popular_Repo.dart';
import '../repositories/ViewAll_recommeded_Repo.dart';

class ViewAllPopularController extends GetxController {
  RxBool isDataLoading = false.obs;
  //RxString keyword = "".obs;

  Rx<ViewAllPopularModel> model = ViewAllPopularModel().obs;

  Future getViewAllPopularData() async {
    isDataLoading.value = false;
    await viewAllPopularData().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
