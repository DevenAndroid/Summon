import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/VendorInformation_Model.dart';
import '../repositories/Vendor_information_Repo.dart';

class VendorInformationController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorInformationModel> model = VendorInformationModel().obs;
  final TextEditingController adharNoController = TextEditingController();
  final TextEditingController panNoController = TextEditingController();
  final TextEditingController storeName = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  getVendorInformation() {
    vendorInformationRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
      if (model.value.data != null) {
    adharNoController.text = model.value.data!.aadharNo.toString();
    panNoController.text = model.value.data!.panNo.toString();
    storeName.text = model.value.data!.storeName.toString();
    addressController.text = model.value.data!.address.toString();
    locationController.text = model.value.data!.location.toString();
      }
    });
  }
}
