import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/HomePageController1.dart';
import '../controller/My_cart_controller.dart';
import '../controller/home_page_controller.dart';
import '../controller/store_controller.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../repositories/Homepage_Search_Repo1.dart';
import '../repositories/Remove_CartItem_Repo.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';

class SearchScreenData extends StatefulWidget {
  const SearchScreenData({Key? key}) : super(key: key);
  static var searchScreen = "/searchScreen";
  @override
  State<SearchScreenData> createState() => _SearchScreenDataState();
}

class _SearchScreenDataState extends State<SearchScreenData> {
  final controller = Get.put(HomePageController());
  final homeSearchController = Get.put(HomePageController1());
  final myCartController = Get.put(MyCartDataListController());
  final storeController = Get.put(StoreController());
  final scrollController = ScrollController();
  final TextEditingController searchController=TextEditingController();
  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      homeSearchController.page.value++;
      homeSearchController.searchingData();
      print("call");
    }else{
      print("dont call");
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeSearchController.searchingData();
      // controller.searchDataModel.value.data != null
      //     ? controller.searchDataModel.value.data!.clear()
      //     : Container();
    });
    scrollController.addListener(_scrollListener);

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
         backgroundColor: const Color(0xffF6F6F6),
        appBar: backAppBar1(title: "Search Product", context: context),
        body: SingleChildScrollView(
          controller: scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding10),
            child: Column(
              children: [
                // SizedBox(
                //   height: height * .07,
                //   child: TextField(
                //     maxLines: 3,
                //     controller:homeSearchController.searchController,
                //     style: const TextStyle(fontSize: 17),
                //     // textAlignVertical: TextAlignVertical.center,
                //     textInputAction: TextInputAction.search,
                //     onSubmitted: (value) {
                //     homeSearchController.searchingData();
                //     },
                //     decoration: InputDecoration(
                //       filled: true,
                //
                //       border: const OutlineInputBorder(
                //           borderSide: BorderSide.none,
                //           borderRadius: BorderRadius.all(
                //               Radius.circular(8))),
                //       fillColor: Colors.white,
                //       contentPadding: EdgeInsets.symmetric(
                //           horizontal: width * .02,
                //           vertical: height * .02),
                //       hintText: 'Find for food or restaurant...',
                //       hintStyle: TextStyle(
                //           fontSize: AddSize.font14,
                //           color: Color(0xff9DA4BB),
                //           fontWeight: FontWeight.w400),
                //       suffixIcon: IconButton(
                //         onPressed: () {
                //           print("hello");
                //           homeSearchController.load=false.obs;
                //           homeSearchController.searchingData();
                //         },
                //         icon: const Icon(
                //           Icons.search_rounded,
                //           color: Color(0xff8990A7),
                //           size: 30,
                //         ),
                //       ),
                //       // prefixIcon: IconButton(
                //       //   onPressed: () {
                //       //     // Get.to(const SearchScreenData());
                //       //
                //       //   },
                //       //   icon: const Icon(
                //       //     Icons.place_rounded,
                //       //     color: Color(0xffD3D1D8),
                //       //     size: 30,
                //       //   ),
                //       // ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: height * .07,
                  child: TextField(
                    maxLines: 1,
                    controller: homeSearchController.searchController,
                    style: const TextStyle(fontSize: 17),
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {

                      homeSearchController.searchingData(allowClear: true);
                    },
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            print("hello");
                            homeSearchController.searchingData(allowClear: true);

                          },
                          icon: const Icon(
                            Icons.search_rounded,
                            color: AppTheme.primaryColor,
                            size: 30,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: width * .04),
                        hintText: 'Search food or restaurant',
                        hintStyle: TextStyle(
                            fontSize: AddSize.font14,
                            color: AppTheme.blackcolor,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Obx(() {
                  return homeSearchController.isDataLoading.value ? (homeSearchController.searchModel2.isNotEmpty)
                      ?
                  GridView.builder(
                            shrinkWrap: true,
                            itemCount: homeSearchController.load.value == false ?  homeSearchController.searchModel2.length + 1  :  homeSearchController.searchModel2.length  ,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 230,
                            mainAxisSpacing: 20.0),
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {

                          if(index < homeSearchController.searchModel2.length){
                            return InkWell(
                                onTap: () {
                                  Get.toNamed(StoreScreen
                                      .singleStoreScreen);
                                  storeController
                                      .storeId.value =
                                      homeSearchController.searchModel2[index].id
                                          .toString();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: AppTheme
                                            .backgroundcolor,
                                        borderRadius:
                                        BorderRadius
                                            .circular(16)),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(
                                          horizontal: AddSize
                                              .padding10,
                                          vertical: AddSize
                                              .padding10),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                //color: Colors.grey,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(20),
                                                    topLeft: Radius.circular(20)),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                ),
                                                child:
                                                CachedNetworkImage(
                                                  imageUrl: homeSearchController.searchModel2[index].image
                                                      .toString(),
                                                  errorWidget: (_, __, ___) =>
                                                  const SizedBox(),
                                                  placeholder: (_, __) =>
                                                  const SizedBox(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                         // addHeight(10),
                                          Text(
                                            homeSearchController.searchModel2[
                                            index]
                                                .name
                                                .toString(),
                                            style: TextStyle(
                                                color: AppTheme
                                                    .blackcolor,
                                                fontSize:
                                                AddSize
                                                    .font14,
                                                fontWeight:
                                                FontWeight
                                                    .w500),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [

                                              Row(
                                                children: [

                                                  Text(
                                                    "${homeSearchController.searchModel2[index].distance.toString()} KM",
                                                    style: TextStyle(
                                                        color: AppTheme
                                                            .blackcolor,
                                                        fontSize:
                                                        AddSize
                                                            .font12,
                                                        fontWeight:
                                                        FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )));
                          }
                          else{
                       if(homeSearchController.load.value == true){
                         return Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             SizedBox(
                                 height: 30,
                                 width: 30,
                                 child: CircularProgressIndicator()),
                           ],
                         );
                       }
                          }
                          })
                      : const Text("No data found"):Center(child: CircularProgressIndicator());
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  // buildDropdownButtonFormField(int index) {
  //   return Obx(() {
  //     return DropdownButtonFormField<int>(
  //         decoration: InputDecoration(
  //           fillColor: Colors.grey.shade50,
  //           border: InputBorder.none,
  //           enabled: true,
  //         ),
  //         value:
  //             controller.searchDataModel.value.data![index].varientIndex!.value,
  //         hint: Text(
  //           'Select qty',
  //           style:
  //               TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
  //         ),
  //         items: List.generate(
  //             controller.searchDataModel.value.data![index].varints!.length,
  //             (index1) => DropdownMenuItem(
  //                   value: index1,
  //                   child: Text(
  //                     "${controller.searchDataModel.value.data![index].varints![index1].variantQty}${controller.searchDataModel.value.data![index].varints![index1].variantQtyType}",
  //                     style: const TextStyle(fontSize: 16),
  //                   ),
  //                 )),
  //         onChanged: (newValue) {
  //           controller.searchDataModel.value.data![index].varientIndex!.value =
  //               newValue!;
  //           setState(() {});
  //         });
  //   });
  // }
}
