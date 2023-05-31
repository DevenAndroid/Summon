import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/HelpCenterModel.dart';
import '../model/PrivacyModel.dart';
import '../repositories/HelpCenter_Repo.dart';

class HelpCenterController extends GetxController {
  RxBool isDataLoading = false.obs;
  RxBool isGettingData = false.obs;
  //RxString keyword = "".obs;
  final searchController = TextEditingController();
  Rx<HelpCenterModel> model = HelpCenterModel().obs;
  Rx<PrivacyModel> privacyModel = PrivacyModel().obs;

  Future getHelpCenterData() async {
    isDataLoading = false.obs;
    await helpCenterRepo(keyword: searchController.text.trim()).then((value) {
      isDataLoading = true.obs;
      model.value = value;
    });
  }

  Future getPrivacyPolicyData() async {
    isGettingData = false.obs;
    await privacyPolicy().then((value) {
      isGettingData = true.obs;
      privacyModel.value = value;
    });
  }
}
