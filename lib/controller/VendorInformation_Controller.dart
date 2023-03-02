import 'package:get/get.dart';
import '../model/VendorInformation_Model.dart';
import '../repositories/Vendor_information_Repo.dart';

class VendorInformationController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorInformationModel> model = VendorInformationModel().obs;

  getVendorInformation() {
    vendorInformationRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
