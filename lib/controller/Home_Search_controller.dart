import 'dart:js';

import 'package:get/get.dart';
import '../model/Home_Search_Model.dart';
import '../repositories/Homepage_search_Repo.dart';

class HomePageController extends GetxController {
  RxBool isDataLoad = false.obs;
  Rx<HomeSerachModel> searchModel = HomeSerachModel().obs;

  get keyword => null;

  void onInit() {
    super.onInit();
    getSearchData(keyword, context)();
  }

  getSearchData(keyword, context) async {
    isDataLoad.value = false;
    homeSearchRepo(keyword, context).then((value) {
      isDataLoad.value = true;
      searchModel.value = value;
    });
  }
}
