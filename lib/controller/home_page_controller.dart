import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/home_page_model.dart';
import 'package:get/get.dart';
import '../model/Home_Search_Model.dart';
import '../repositories/Homepage_search_Repo.dart';
import '../repositories/home_page_repository.dart';

class HomePageController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<HomePageModel> model = HomePageModel().obs;
  Rx<HomeSerachModel> searchDataModel = HomeSerachModel().obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future getData() async {
    isDataLoading.value = false;
    await homeData().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }

   getSearchData() async {
    homeSearchRepo(searchController.text.trim()).then((value) {
      searchDataModel.value = value;
    });
  }
}
