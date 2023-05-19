import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/VendorInformation_Model.dart';
import '../repositories/Vendor_information_Repo.dart';

class VendorInformationController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorInformationModel> model = VendorInformationModel().obs;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController businessIdController = TextEditingController();
  final TextEditingController storeName = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future getVendorInformation() async {
    await vendorInformationRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
      if (model.value.data != null) {
    phoneController.text = model.value.data!.phone.toString();
    businessIdController.text = model.value.data!.businessId.toString();
    storeName.text = model.value.data!.storeName.toString();

      }
    });
  }
}
