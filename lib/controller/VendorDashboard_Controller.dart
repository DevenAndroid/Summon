import 'package:get/get.dart';
import '../model/Vendor_Dashboard_Model.dart';
import '../repositories/Vendor_Dashboard_Repo.dart';

class VendorDashboardController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorDashboardModel> model = VendorDashboardModel().obs;

  getVendorDashboardData() {
    vendorDashboardRepo().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
