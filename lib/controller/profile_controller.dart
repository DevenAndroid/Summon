import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/user_profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../repositories/user_profile_repository.dart';

class ProfileController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<ProfileModel> model = ProfileModel().obs;
  Rx<File> image = File("").obs;
  final ImagePicker picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    userProfileData().then((value) {
      isDataLoading.value = true;
      model.value = value;
      if (isDataLoading.value &&
          model.value.data != null) {
        nameController.text =
            model.value.data!.name.toString();
        emailController.text =
            model.value.data!.email.toString();
        mobileController.text =
            model.value.data!.phone.toString();
      }
    });
  }
}
