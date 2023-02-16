import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/My_cart_controller.dart';
import '../controller/home_page_controller.dart';
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
  @override
  void initState() {
    super.initState();
    controller.getSearchData();
    controller.searchDataModel.value.data != null
        ? controller.searchDataModel.value.data!.clear()
        : Container();
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
          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16,vertical: AddSize.padding10),
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
                    controller.getSearchData();
                  },
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          log("AAAAAA");
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
              // Row(
              //   children: [
              //     Container(
              //         width: 23,
              //         height: 21,
              //         decoration: BoxDecoration(
              //           color: const Color(0xff4169E2),
              //           borderRadius: BorderRadius.circular(5),
              //         ),
              //         child: IconButton(
              //           padding: EdgeInsets.zero,
              //           onPressed: () {
              //             Navigator.pop(context);
              //           },
              //           icon: const Icon(
              //             Icons.arrow_back_ios,
              //             color: Colors.white,
              //             size: 15,
              //           ),
              //         )),
              //     SizedBox(
              //       width: 20,
              //     ),
              //     const Text(
              //       "Add Product",
              //       style: TextStyle(
              //           fontSize: 20,
              //           color: Color(0xff292F45),
              //           fontWeight: FontWeight.w600),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Card(
              //   elevation: 5,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15)),
              //   child: SizedBox(
              //     height: 176,
              //     width: 336,
              //     child: TextField(
              //       //maxLines: 1,
              //       controller: controller.searchController,
              //       style: const TextStyle(fontSize: 17),
              //       textAlignVertical: TextAlignVertical.center,
              //
              //       textInputAction: TextInputAction.search,
              //       onSubmitted: (value) {
              //         controller.getSearchData();
              //       },
              //       textAlign: TextAlign.center,
              //       decoration: InputDecoration(
              //         hintText: 'search here..',
              //         hintStyle: TextStyle(),
              //         border: const UnderlineInputBorder(
              //             borderSide: BorderSide.none),
              //         // filled: true,
              //         suffixIcon: IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.search_rounded,
              //             color: Colors.black,
              //             size: 30,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Obx(() {
                return (controller.searchDataModel.value.data != null && controller.searchDataModel.value.data!.isNotEmpty) ?ListView.builder(
                        itemCount: controller.searchDataModel.value.data !=
                                null
                            ? controller.searchDataModel.value.data!.length
                            : 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            // height: height * .23,
                            child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * .02,
                                        vertical: height * .01,
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: AddSize.size50 * 1.2,
                                              width: AddSize.size50 * 1.6,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  imageUrl: controller
                                                      .searchDataModel
                                                      .value
                                                      .data![index]
                                                      .image
                                                      .toString(),
                                                  errorWidget: (_, __, ___) =>
                                                      const SizedBox(),
                                                  placeholder: (_, __) =>
                                                      const SizedBox(),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * .02,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      controller
                                                          .searchDataModel
                                                          .value
                                                          .data![index]
                                                          .name
                                                          .toString(),
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          color: AppTheme
                                                              .blackcolor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500)),
                                                  SizedBox(
                                                    height: height * .01,
                                                  ),
                                                  Container(
                                                    // width: width * .60,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * .02),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    8.0),
                                                        color: Colors
                                                            .grey.shade100),
                                                    child:
                                                        buildDropdownButtonFormField(
                                                            index),
                                                  ),
                                                  SizedBox(
                                                    height: height * .01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                width * .02,
                                                          ),
                                                          Text(
                                                            "₹${controller.searchDataModel.value.data![index].varints![controller.searchDataModel.value.data![index].varientIndex!.value].price.toString()}",
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                color: AppTheme
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                width * .02,
                                                          ),
                                                          Text(
                                                            "₹${controller.searchDataModel.value.data![index].varints![controller.searchDataModel.value.data![index].varientIndex!.value].marketPrice.toString()}",
                                                            style: const TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                      myCartController
                                                              .isDataLoaded
                                                              .value
                                                          ? myCartController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .cartItems!
                                                                  .map((e) => e
                                                                      .productId
                                                                      .toString())
                                                                  .toList()
                                                                  .contains(controller
                                                                      .searchDataModel
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .id
                                                                      .toString())
                                                              ? Obx(() {
                                                                  return Container(
                                                                    width:
                                                                        width *
                                                                            .20,
                                                                    decoration: BoxDecoration(
                                                                        color: AppTheme
                                                                            .primaryColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6)),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.symmetric(
                                                                        vertical:
                                                                            height * .005,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap: () {
                                                                              removeCartItemRepo(controller.searchDataModel.value.data![index].varints![controller.searchDataModel.value.data![index].varientIndex!.value].price.toString(), context);
                                                                            },
                                                                            child: const Icon(
                                                                              Icons.remove,
                                                                              color: AppTheme.backgroundcolor,
                                                                              size: 15,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            myCartController.model.value.data!.cartItems![0].cartItemQty.toString(),
                                                                            style: TextStyle(fontSize: AddSize.font14, color: AppTheme.backgroundcolor, fontWeight: FontWeight.w500),
                                                                          ),
                                                                          InkWell(
                                                                            onTap: () {
                                                                              addToCartRepo(controller.searchDataModel.value.data![index].varints![controller.searchDataModel.value.data![index].varientIndex!.value].price.toString(), "1", context).then((value) {
                                                                                if (value.status == true) {
                                                                                  showToast(value.message);
                                                                                  myCartController.getAddToCartList();
                                                                                } else {
                                                                                  showToast(value.message);
                                                                                }
                                                                              });
                                                                            },
                                                                            child: const Icon(
                                                                              Icons.add,
                                                                              color: AppTheme.backgroundcolor,
                                                                              size: 15,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                })
                                                              : OutlinedButton(
                                                                  style: OutlinedButton
                                                                      .styleFrom(
                                                                    shape: const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(6))),
                                                                    minimumSize: Size(
                                                                        AddSize
                                                                            .size50,
                                                                        AddSize
                                                                            .size30),
                                                                    side: const BorderSide(
                                                                        color: AppTheme
                                                                            .primaryColor,
                                                                        width:
                                                                            1),
                                                                    backgroundColor:
                                                                        AppTheme
                                                                            .addColor,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    int vIndex = controller
                                                                        .searchDataModel
                                                                        .value
                                                                        .data![
                                                                            index]
                                                                        .varientIndex!
                                                                        .value;
                                                                    addToCartRepo(
                                                                            controller.searchDataModel.value.data![index].varints![vIndex].id.toString(),
                                                                            '1',
                                                                            context)
                                                                        .then((value) {
                                                                      if (value.status ==
                                                                          true) {
                                                                        showToast(
                                                                            value.message);
                                                                        myCartController
                                                                            .getAddToCartList();
                                                                      } else {
                                                                        showToast(
                                                                            value.message);
                                                                      }
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                      "ADD",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              AddSize.font12,
                                                                          color: AppTheme.primaryColor,
                                                                          fontWeight: FontWeight.w600)),
                                                                )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ]),
                                    ),
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                            height: height * .03,
                                            width: width * .18,
                                            decoration: const BoxDecoration(
                                                color: AppTheme.primaryColor,
                                                borderRadius:
                                                    BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10))),
                                            child: Center(
                                                child: Text(
                                              controller
                                                  .searchDataModel
                                                  .value
                                                  .data![index]
                                                  .varints![controller
                                                      .searchDataModel
                                                      .value
                                                      .data![index]
                                                      .varientIndex!
                                                      .value]
                                                  .discountOff
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme
                                                      .backgroundcolor,
                                                  fontWeight:
                                                      FontWeight.w400),
                                            )))),
                                  ],
                                )),
                          );
                          // return ListTile(
                          //   leading: Image.network(controller
                          //       .searchDataModel.value.data![index].image
                          //       .toString()),
                          //   title: Text(controller
                          //       .searchDataModel.value.data![index].name
                          //       .toString()),
                          //   // leading: Image.network(homeSearchController
                          //   //     .searchModel.value.data![index].image
                          //   //     .toString()),
                          // );
                        }):const Text("No data found");
              })
            ],
          ),
        ),
      ),
    );
  }

  buildDropdownButtonFormField(int index) {
    return Obx(() {
      return DropdownButtonFormField<int>(
          decoration: InputDecoration(
            fillColor: Colors.grey.shade50,
            border: InputBorder.none,
            enabled: true,
          ),
          value:
              controller.searchDataModel.value.data![index].varientIndex!.value,
          hint: Text(
            'Select qty',
            style:
                TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
          ),
          items: List.generate(
              controller.searchDataModel.value.data![index].varints!.length,
              (index1) => DropdownMenuItem(
                    value: index1,
                    child: Text(
                      "${controller.searchDataModel.value.data![index].varints![index1].variantQty}${controller.searchDataModel.value.data![index].varints![index1].variantQtyType}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  )),
          onChanged: (newValue) {
            controller.searchDataModel.value.data![index].varientIndex!.value =
                newValue!;
            setState(() {});
          });
    });
  }
}
