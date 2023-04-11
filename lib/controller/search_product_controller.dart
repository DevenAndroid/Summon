// import 'package:get/get.dart';
//
//
// class SearchListController extends GetxController {
//   RxBool isDataLoading = false.obs;
//   RxString search = "".obs;
//   RxList<String> searchList = <String>[].obs;
//   @override
//   void onInit() {
//     super.onInit();
//   }
//   getData() async {
//     isDataLoading.value = false;
//     searchListData(search.value).then((value) {
//       isDataLoading.value = true;
//       searchList.value = value;
//     });
//   }
// }