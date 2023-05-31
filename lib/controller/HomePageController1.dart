
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/HomePageModel1.dart';
import '../model/HomeSearchModel1.dart';

import '../repositories/HomePage_repository.dart';
import '../repositories/Homepage_Search_Repo1.dart';


class HomePageController1 extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<HomePageModel1> model = HomePageModel1().obs;
 // for homepage search data
  RxBool isPaginationLoading = true.obs;
  RxBool isSearchDataLoad = false.obs;
  RxBool loadMore = true.obs;
  RxInt page = 1.obs;
  RxInt pagination = 10.obs;
  RxString storeId = "".obs;
  RxString keyword = "".obs;
  Rx<HomePageSearchModel1> searchModel = HomePageSearchModel1().obs;



  final TextEditingController searchController=TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getHomePageData();
    //getData(isFirstTime:true);
  }

  Future getHomePageData() async {
    isDataLoading.value = false;
    await homePageData().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
  // getData1() {
  //   if (loading.value == false) {
  //     loading.value = true;
  //     getCourseCategoryForPagination(url: currentId, page: page).then((value) {
  //       isDataLoading.value = true;
  //       model2.value = modelAllCoursesFromJson(value.toString());
  //       model.addAll(model2);
  //       model2.clear();
  //       // loading.value = false;
  //       // model.addAll(modelForPagination.value);
  //       // modelForPagination.value.clear();
  //       if (model.value != null) {
  //         statusOf.value = RxStatus.success();
  //         print(statusOf.value);
  //       } else {
  //         statusOf.value = RxStatus.error();
  //         print(statusOf.value);
  //       }
  //       loading.value = false;
  //       print("one");
  //     });
  //   }
  // }

  // Future getData({isFirstTime = false, context}) async {
  //
  //   if(isFirstTime){
  //     page.value = 1;
  //   }
  //   if (isPaginationLoading.value && loadMore.value) {
  //     isPaginationLoading.value = false;
  //     isSearchDataLoad.value = false;
  //     await
  //     searchHomeDataPagination(
  //         page: page.value,
  //         pagination: pagination.value,
  //         keyword: searchController.text.trim())
  //         .then((value) {
  //       if (isFirstTime) {
  //         searchModel.value = value;
  //       }
  //       isPaginationLoading.value = true;
  //       isSearchDataLoad.value = true;
  //       if (value.status!) {
  //         isSearchDataLoad.value = true;
  //         page.value++;
  //         if (!isFirstTime) {
  //           searchModel.value.data!.addAll(value.data!);
  //         }
  //         loadMore.value = value.link!.next ?? false;
  //       }
  //     });
  //   }
  // }

  RxBool load = false.obs;

  RxList<SearchModelData> searchModel2 = <SearchModelData>[].obs;
 void  searchingData({bool? allowClear, BuildContext? context  }) async {
   if(allowClear == true){
     //searchModel2.clear();
     load.value = false;
     page.value = 1;
   }
    if(load.value == false){
      load.value = true;
       searchHomeDataPagination(context: context, keyword: searchController.text.trim(),page: page.value,pagination: pagination.value,).then((value) {
        searchModel.value = value;
        isDataLoading.value = true;
        if(value.status == true){
          if(allowClear == true){
            searchModel2.clear();
          }
          searchModel2.addAll(searchModel.value.data!);
          isDataLoading.value = true;
        }else{
          isDataLoading.value = false;
        }
        load.value = false;
         searchModel.value.data!.clear();
      });
    }
   }


}
