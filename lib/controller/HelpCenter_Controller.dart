import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/HelpCenterModel.dart';
import '../repositories/HelpCenter_Repo.dart';

class HelpCenterController extends GetxController {
  RxBool isDataLoading = false.obs;
  //RxString keyword = "".obs;
  final searchController = TextEditingController();
  Rx<HelpCenterModel> model = HelpCenterModel().obs;

  Future getHelpCenterData() async {
    isDataLoading = false.obs;
    await helpCenterRepo(keyword: searchController.text.trim()).then((value) {
      isDataLoading = true.obs;
      model.value = value;
    });
  }
}
