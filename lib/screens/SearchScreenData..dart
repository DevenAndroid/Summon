import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/My_cart_controller.dart';
import '../controller/home_page_controller.dart';
import '../controller/store_controller.dart';
import '../repositories/Add_To_Cart_Repo.dart';
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
  final myCartController = Get.put(MyCartDataListController());
  final storeController = Get.put(StoreController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getSearchData();
      controller.searchDataModel.value.data != null
          ? controller.searchDataModel.value.data!.clear()
          : Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: const Color(0xffFFFFFF),
      appBar: backAppBar(title: "Search Product", context: context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AddSize.padding16, vertical: AddSize.padding10),
          child: Column(
            children: [
              SizedBox(
                height: height * .07,
                child: TextField(
                  maxLines: 1,
                  controller: controller.searchController,
                  style: const TextStyle(fontSize: 17),
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    controller.getSearchData().then((value) {
                      if (value.status == false) {
                        showToast("No data found");
                      }
                    });
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
                          controller.getSearchData().then((value) {
                            if (value.status == false) {
                              showToast("No data found");
                            }
                          });
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
                      hintText: 'Search Your Groceries',
                      hintStyle: TextStyle(
                          fontSize: AddSize.font14,
                          color: AppTheme.blackcolor,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              Obx(() {
                return controller.isDataLoading.value ? (controller.searchDataModel.value.data != null && controller.searchDataModel.value.data!.isNotEmpty)
                    ? ListView.builder(
                        itemCount: controller.searchDataModel.value.data != null
                            ? controller.searchDataModel.value.data!.length
                            : 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                        return InkWell(
                              onTap: () {
                                Get.toNamed(StoreScreen
                                    .singleStoreScreen);
                                storeController
                                    .storeId.value =
                                    controller.searchDataModel.value.data![index].id
                                        .toString();
                              },
                              child: Container(
                                  margin:
                                  const EdgeInsets.only(
                                      top: 10),
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
                                        SizedBox(
                                          height:
                                          height * .19,
                                          width: width,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                10),
                                            child:
                                            CachedNetworkImage(
                                              imageUrl: controller.searchDataModel.value.data![
                                              index]
                                                  .image
                                                  .toString(),
                                              errorWidget: (_,
                                                  __,
                                                  ___) =>
                                              const SizedBox(),
                                              placeholder: (_,
                                                  __) =>
                                              const SizedBox(),
                                              fit: BoxFit
                                                  .cover,
                                            ),
                                          ),
                                        ),
                                        addHeight(10),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                              controller.searchDataModel.value.data![
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
                                              children: [
                                                const Icon(
                                                  Icons
                                                      .location_on,
                                                  color: AppTheme
                                                      .primaryColor,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width:
                                                  width *
                                                      .02,
                                                ),
                                                Text(
                                                  "${controller.searchDataModel.value.data![index].distance.toString()} KM",
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
                        })
                    : const Text("No data found"):Center(child: CircularProgressIndicator());
              })
            ],
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
