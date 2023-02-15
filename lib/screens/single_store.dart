import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/My_cart_controller.dart';
import '../controller/category_controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/store_controller.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../repositories/Remove_CartItem_Repo.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);
  static var singleStoreScreen = "/singleStoreScreen";

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final singleStoreController = Get.put(StoreController());
  final myCartController = Get.put(MyCartDataListController());
  final controller = Get.put(MainHomeController());
  final categoryController = Get.put(CategoryController());
  String? selectedCAt;

  @override
  void initState() {
    super.initState();
    singleStoreController.getStoreDetails();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: "Store", context: context),
        body:
            singleStoreController.isDataLoading.value &&
                    categoryController.isDataLoading.value &&
                    myCartController.isDataLoaded.value &&
                    singleStoreController.storeDetailsModel.value.data != null
                ? CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        excludeHeaderSemantics: false,
                        snap: false,
                        floating: false,
                        expandedHeight: height * .285,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        leadingWidth: 0,
                        // toolbarHeight: 150,
                        // title: ,
                        bottom: PreferredSize(
                            preferredSize: Size(width, AddSize.size40 * 1.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * .03),
                                  child: Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AddSize.padding16,
                                          vertical: AddSize.padding16),
                                      // height: 100,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  singleStoreController
                                                      .storeDetailsModel
                                                      .value
                                                      .data!
                                                      .storeDetails!
                                                      .storeName
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Expanded(
                                                child: Text(
                                                  "",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w100),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * .01,
                                )
                              ],
                            )),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Padding(
                            padding: EdgeInsets.only(bottom: AddSize.size45),
                            child: CachedNetworkImage(
                              imageUrl: singleStoreController.storeDetailsModel
                                  .value.data!.storeDetails!.storeImage
                                  .toString(),
                              errorWidget: (_, __, ___) => const SizedBox(),
                              placeholder: (_, __) => const SizedBox(),
                              fit: BoxFit.cover,
                            ),
                            // Image.network(
                            //   singleStoreController.storeDetailsModel.value.data!
                            //       .storeDetails!.storeImage
                            //       .toString(),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * .03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * .012,
                                ),
                                const Text(
                                  'Categories',
                                  style: TextStyle(
                                      color: AppTheme.blackcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                SizedBox(
                                    height: height * 0.13,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: min(
                                        4,
                                        categoryController
                                            .model.value.data!.length,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                            width: AddSize.size50 * 2,
                                            margin: EdgeInsets.only(
                                                left: AddSize.padding10),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AddSize.padding10,
                                                vertical: AddSize.size5),
                                            decoration: BoxDecoration(
                                                color: index % 3 == 0
                                                    ? AppTheme
                                                        .appPrimaryPinkColor
                                                    : index % 3 == 2
                                                        ? AppTheme
                                                            .appPrimaryGreenColor
                                                        : AppTheme
                                                            .appPrimaryYellowColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  height: AddSize.size50,
                                                  width: AddSize.size50 * 1.2,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          categoryController
                                                              .model
                                                              .value
                                                              .data![index]
                                                              .image
                                                              .toString(),
                                                      errorWidget:
                                                          (_, __, ___) =>
                                                              const SizedBox(),
                                                      placeholder: (_, __) =>
                                                          const SizedBox(),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  categoryController.model.value
                                                      .data![index].name
                                                      .toString(),
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: AppTheme.subText,
                                                      fontSize: AddSize.font14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ));
                                      },
                                    )),
                                SizedBox(height: height * .015),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Latest Product",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                        controller.currentIndex.value = 0;
                                      },
                                      child: const Text(
                                        'View All',
                                        style: TextStyle(
                                            color: AppTheme.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                                ListView.builder(
                                    itemCount: singleStoreController
                                        .storeDetailsModel
                                        .value
                                        .data!
                                        .latestProducts!
                                        .length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                      top: height * .015,
                                    ),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // height: height * .23,
                                        child: Card(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: width * .02,
                                                    vertical: height * .01,
                                                  ),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              AddSize.size50 *
                                                                  1.2,
                                                          width:
                                                              AddSize.size50 *
                                                                  1.6,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: singleStoreController
                                                                  .storeDetailsModel
                                                                  .value
                                                                  .data!
                                                                  .latestProducts![
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
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * .02,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  singleStoreController
                                                                      .storeDetailsModel
                                                                      .value
                                                                      .data!
                                                                      .latestProducts![
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  style: const TextStyle(
                                                                      color: AppTheme
                                                                          .blackcolor,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500)),
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
                                                              ),
                                                              Container(
                                                                // width: width * .60,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            width *
                                                                                .02),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    color: Colors
                                                                        .grey
                                                                        .shade100),
                                                                child:
                                                                    buildDropdownButtonFormField(
                                                                        index),
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
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
                                                                        width: width *
                                                                            .02,
                                                                      ),
                                                                      Text(
                                                                        "₹${singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varints![singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].price.toString()}",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                AppTheme.primaryColor,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            .02,
                                                                      ),
                                                                      Text(
                                                                        "₹${singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varints![singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].marketPrice.toString()}",
                                                                        style: const TextStyle(
                                                                            decoration: TextDecoration
                                                                                .lineThrough,
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.grey,
                                                                            fontWeight: FontWeight.w400),
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
                                                                              .map((e) => e.productId.toString())
                                                                              .toList()
                                                                              .contains(singleStoreController.storeDetailsModel.value.data!.latestProducts![index].id.toString())
                                                                          ? Obx(() {
                                                                              return Container(
                                                                                width: width * .20,
                                                                                decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(6)),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.symmetric(
                                                                                    vertical: height * .005,
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          removeCartItemRepo(singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varints![singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].price.toString(), context);
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
                                                                                          addToCartRepo(singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varints![singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].price.toString(), "1", context).then((value) {
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
                                                                              style: OutlinedButton.styleFrom(
                                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                                                                                minimumSize: Size(AddSize.size50, AddSize.size30),
                                                                                side: const BorderSide(color: AppTheme.primaryColor, width: 1),
                                                                                backgroundColor: AppTheme.addColor,
                                                                              ),
                                                                              onPressed: () {
                                                                                int vIndex = singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value;
                                                                                addToCartRepo(singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varints![vIndex].id.toString(), '1', context).then((value) {
                                                                                  if (value.status == true) {
                                                                                    showToast(value.message);
                                                                                    myCartController.getAddToCartList();
                                                                                  } else {
                                                                                    showToast(value.message);
                                                                                  }
                                                                                });
                                                                              },
                                                                              child: Text("ADD", style: TextStyle(fontSize: AddSize.font12, color: AppTheme.primaryColor, fontWeight: FontWeight.w600)),
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
                                                            color: AppTheme
                                                                .primaryColor,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10))),
                                                        child: Center(
                                                            child: Text(
                                                          singleStoreController
                                                              .storeDetailsModel
                                                              .value
                                                              .data!
                                                              .latestProducts![
                                                                  index]
                                                              .varints![singleStoreController
                                                                  .storeDetailsModel
                                                                  .value
                                                                  .data!
                                                                  .latestProducts![
                                                                      index]
                                                                  .varientIndex!
                                                                  .value]
                                                              .discountOff
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color: AppTheme
                                                                  .backgroundcolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )))),
                                              ],
                                            )),
                                      );
                                    }),
                                SizedBox(
                                  height: height * .02,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    controller.onItemTap(1);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.maxFinite, AddSize.size30 * 2),
                      primary: AppTheme.primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${(myCartController.sum.value ?? "").toString()} Items",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.backgroundcolor,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "₹${(myCartController.model.value.data!.cartPaymentSummary!.subTotal ?? "").toString()}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.backgroundcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Text(
                              "View Cart",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.backgroundcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.arrow_right,
                              size: 30,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AddSize.size20,
              ),
            ],
          ),
        ),
      );
    });
  }

  buildDropdownButtonFormField(int index) {
    return Obx(() {
      return DropdownButtonFormField<int>(
          decoration: InputDecoration(
            fillColor: Colors.grey.shade50,
            border: InputBorder.none,
            enabled: true,
          ),
          value: singleStoreController.storeDetailsModel.value.data!
              .latestProducts![index].varientIndex!.value,
          hint: Text(
            'Select qty',
            style:
                TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
          ),
          items: List.generate(
              singleStoreController.storeDetailsModel.value.data!
                  .latestProducts![index].varints!.length,
              (index1) => DropdownMenuItem(
                    value: index1,
                    child: Text(
                      "${singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varints![index1].variantQty}${singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varints![index1].variantQtyType}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  )),
          onChanged: (newValue) {
            singleStoreController.storeDetailsModel.value.data!
                .latestProducts![index].varientIndex!.value = newValue!;
            setState(() {});
          });
    });
  }
}
