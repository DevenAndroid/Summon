import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/repositories/Remove_CartItem_Repo.dart';
import 'package:fresh2_arrive/repositories/apply_coupons_repository.dart';
import 'package:fresh2_arrive/repositories/order_tip_repository.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/screens/coupons_screen.dart';
import 'package:fresh2_arrive/screens/my_address.dart';
import 'package:fresh2_arrive/screens/payment_method.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:fresh2_arrive/widgets/editprofile_textfield.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controller/My_cart_controller.dart';
import '../controller/cart_related_product_controller.dart';
import '../controller/location_controller.dart';
import '../model/My_Cart_Model.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../resources/app_theme.dart';
import 'order/choose_address.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);
  static var myCartScreen = "/myCartScreen";

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final controller = Get.put(MyCartDataListController());
  final relatedCartController = Get.put(CartRelatedProductController());
  final locationController = Get.put(LocationController());
  final TextEditingController tipController = TextEditingController();
  final TextEditingController variantIdController = TextEditingController();
  final List<String> tips = ["20", "30", "40", "Custom"];
  RxString selectedCAt = "".obs;
  RxBool customTip = false.obs;
  RxString selectedChip = "".obs;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: height * .016),
            child: controller.isDataLoaded.value
                ? controller.model.value.data!.cartItems!.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                              itemCount: controller
                                      .model.value.data!.cartItems!.isEmpty
                                  ? 0
                                  : controller
                                      .model.value.data!.cartItems!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: height * .015),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Obx(() {
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
                                                horizontal: width * .04,
                                                vertical: height * .01,
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: height * .12,
                                                      width: width * .20,
                                                      child: CachedNetworkImage(
                                                        imageUrl: controller
                                                            .model
                                                            .value
                                                            .data!
                                                            .cartItems![index]
                                                            .image
                                                            .toString(),
                                                        errorWidget: (_, __,
                                                                ___) =>
                                                            const SizedBox(),
                                                        placeholder: (_, __) =>
                                                            const SizedBox(),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * .05,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              controller
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .cartItems![
                                                                      index]
                                                                  .name
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: AppTheme
                                                                      .blackcolor,
                                                                  fontSize:
                                                                      AddSize
                                                                          .font16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          SizedBox(
                                                            height:
                                                                height * .005,
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
                                                                  Text(
                                                                    "Qty: ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            AddSize
                                                                                .font12,
                                                                        color: AppTheme
                                                                            .blackcolor,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  Text(
                                                                    "${controller.model.value.data!.cartItems![index].cartItemQty.toString()} * ${controller.model.value.data!.cartItems![index].variantQty.toString()}${controller.model.value.data!.cartItems![index].variantQtyType.toString()}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            AddSize
                                                                                .font12,
                                                                        color: AppTheme
                                                                            .subText,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    right:
                                                                        width *
                                                                            .04),
                                                                child:
                                                                    Container(
                                                                  width: width *
                                                                      .18,
                                                                  decoration: BoxDecoration(
                                                                      color: AppTheme
                                                                          .primaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6)),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          width *
                                                                              .01,
                                                                      vertical:
                                                                          height *
                                                                              .005,
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            if (controller.model.value.data!.cartItems![index].cartItemQty ==
                                                                                controller.model.value.data!.cartItems![index].minQty) {
                                                                              removeCartItemRepo(controller.model.value.data!.cartItems![index].id.toString(), context).then((value) {
                                                                                if (value.status == true) {
                                                                                  showToast(value.message);
                                                                                  controller.getAddToCartList();
                                                                                } else {
                                                                                  showToast(value.message);
                                                                                }
                                                                              });
                                                                            } else {
                                                                              updateCartRepo(controller.model.value.data!.cartItems![index].id.toString(), int.parse((controller.model.value.data!.cartItems![index].cartItemQty ?? "").toString()) - 1, context).then((value) {
                                                                                showToast(value.message);
                                                                                if (value.status == true) {
                                                                                  controller.model.value.data!.cartItems![index].cartItemQty = int.parse((controller.model.value.data!.cartItems![index].cartItemQty ?? "").toString()) - 1;
                                                                                  controller.getAddToCartList();
                                                                                }
                                                                                setState(() {});
                                                                              });
                                                                            }
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.remove,
                                                                            color:
                                                                                AppTheme.backgroundcolor,
                                                                            size:
                                                                                15,
                                                                          ),
                                                                        ),
                                                                        Obx(() {
                                                                          return Text(
                                                                            (controller.model.value.data!.cartItems![index].cartItemQty ?? "").toString(),
                                                                            style: TextStyle(
                                                                                fontSize: AddSize.font12,
                                                                                color: AppTheme.backgroundcolor,
                                                                                fontWeight: FontWeight.w500),
                                                                          );
                                                                        }),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            controller.model.value.data!.cartItems![index].maxQty.toString() != controller.model.value.data!.cartItems![index].cartItemQty.toString()
                                                                                ? updateCartRepo(controller.model.value.data!.cartItems![index].id.toString(), int.parse((controller.model.value.data!.cartItems![index].cartItemQty ?? "").toString()) + 1, context).then((value) {
                                                                                    showToast(value.message);
                                                                                    if (value.status == true) {
                                                                                      controller.model.value.data!.cartItems![index].cartItemQty = int.parse((controller.model.value.data!.cartItems![index].cartItemQty ?? "").toString()) + 1;
                                                                                      controller.getAddToCartList();
                                                                                    }
                                                                                    setState(() {});
                                                                                  })
                                                                                : showToast("You can't add more then ${controller.model.value.data!.cartItems![index].maxQty} item");
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.add,
                                                                            color:
                                                                                AppTheme.backgroundcolor,
                                                                            size:
                                                                                15,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  height * .01),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  "₹${controller.model.value.data!.cartItems![index].variantPrice.toString()}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          AddSize
                                                                              .font16,
                                                                      color: AppTheme
                                                                          .blackcolor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                              Text(
                                                                "₹${controller.model.value.data!.cartItems![index].totalPrice.toString()}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        AddSize
                                                                            .font16,
                                                                    color: AppTheme
                                                                        .primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                  width: width *
                                                                      .06),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: GestureDetector(
                                                onTap: () {
                                                  removeCartItemRepo(
                                                          controller
                                                              .model
                                                              .value
                                                              .data!
                                                              .cartItems![index]
                                                              .id
                                                              .toString(),
                                                          context)
                                                      .then((value) {
                                                    if (value.status == true) {
                                                      showToast(value.message);
                                                      controller
                                                          .getAddToCartList();
                                                    } else {
                                                      showToast(value.message);
                                                    }
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.clear,
                                                  color: AppTheme.primaryColor,
                                                  size: 20,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                });
                              }),
                          SizedBox(height: height * .02),
                          Text("You may also like",
                              style: TextStyle(
                                  color: const Color(0xff423E5E),
                                  fontSize: AddSize.font10 * 1.7,
                                  fontWeight: FontWeight.w600)),
                          relatedCartController.isDataLoading.value
                              ? SizedBox(
                                  height: height * .35,
                                  child: Obx(() {
                                    return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: relatedCartController
                                            .relatedProductModel
                                            .value
                                            .data!
                                            .length,
                                        shrinkWrap: true,
                                        padding:
                                            EdgeInsets.only(top: height * .02),
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return buildObx(
                                              width, height, index, context);
                                        });
                                  }),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: height * .01,
                          ),
                          Text("Tip your delivery partner",
                              style: TextStyle(
                                  color: const Color(0xff423E5E),
                                  fontSize: AddSize.font10 * 1.7,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: height * .01,
                          ),
                          Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * .03,
                                  vertical: height * .02,
                                ),
                                child: Obx(() {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                "Thank your delivery partner by leaving them a tip 100% of the tip will go your delivery partner.",
                                                style: TextStyle(
                                                    color: AppTheme.blackcolor,
                                                    fontSize: AddSize.font14,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ),
                                          controller
                                                      .model
                                                      .value
                                                      .data!
                                                      .cartPaymentSummary!
                                                      .tipAmount !=
                                                  0
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "₹${controller.model.value.data!.cartPaymentSummary!.tipAmount}",
                                                        style: TextStyle(
                                                            color: AppTheme
                                                                .blackcolor,
                                                            fontSize:
                                                                AddSize.font14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    TextButton(
                                                        onPressed: () {
                                                          removeTip(
                                                                  context:
                                                                      context)
                                                              .then((value) {
                                                            showToast(value
                                                                .message
                                                                .toString());
                                                            if (value.status ==
                                                                true) {
                                                              controller
                                                                  .getAddToCartList();
                                                              selectedChip
                                                                  .value = "";
                                                            }
                                                          });
                                                        },
                                                        child: Text("Clear",
                                                            style: TextStyle(
                                                                color: AppTheme
                                                                    .primaryColor,
                                                                fontSize:
                                                                    AddSize
                                                                        .font14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)))
                                                  ],
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * .01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(
                                          tips.length,
                                          (index) => chipList(tips[index]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * .02,
                                      ),
                                      if (customTip.value)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: AddSize.width100 * 2.5,
                                              child: EditProfileTextFieldWidget(
                                                keyboardType:
                                                    TextInputType.number,
                                                hint: "₹ Enter tip amount",
                                                controller: tipController,
                                                suffix: IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.arrow_forward,
                                                      color:
                                                          AppTheme.primaryColor,
                                                    )),
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  orderTip(
                                                          tipAmount:
                                                              tipController
                                                                  .text,
                                                          context: context)
                                                      .then((value) {
                                                    showToast(value.message);
                                                    if (value.status == true) {
                                                      controller
                                                          .getAddToCartList();
                                                      tipController.clear();
                                                    }
                                                  });
                                                },
                                                child: Text("Add",
                                                    style: TextStyle(
                                                        color: AppTheme
                                                            .primaryColor,
                                                        fontSize:
                                                            AddSize.font16,
                                                        fontWeight:
                                                            FontWeight.w500)))
                                          ],
                                        )
                                    ],
                                  );
                                }),
                              )),
                          SizedBox(
                            height: height * .01,
                          ),
                          Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * .03,
                                  vertical: height * .02,
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                              CouponsScreen.couponsScreen);
                                        },
                                        child: Row(children: [
                                          Expanded(
                                            child: Row(children: [
                                              const Image(
                                                  height: 22,
                                                  width: 28,
                                                  image: AssetImage(
                                                      AppAssets.coupons_image)),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text("Use Coupons",
                                                  style: TextStyle(
                                                      color:
                                                          AppTheme.blackcolor,
                                                      fontSize: AddSize.font14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ]),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.black,
                                            size: AddSize.size15,
                                          ),
                                        ])),
                                    controller
                                                    .model
                                                    .value
                                                    .data!
                                                    .cartPaymentSummary!
                                                    .couponDiscount ==
                                                0 &&
                                            controller
                                                    .model
                                                    .value
                                                    .data!
                                                    .cartPaymentSummary!
                                                    .couponCode
                                                    .toString() ==
                                                ""
                                        ? const SizedBox()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration:
                                                      const ShapeDecoration(
                                                          color: AppTheme
                                                              .userActive,
                                                          shape:
                                                              CircleBorder()),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.check,
                                                    color: AppTheme
                                                        .backgroundcolor,
                                                    size: AddSize.size12,
                                                  )),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "${controller.model.value.data!.cartPaymentSummary!.couponCode.toString()} applied successfully",
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .userActive,
                                                              fontSize: AddSize
                                                                  .font14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      Text(
                                                          "You saved ₹${controller.model.value.data!.cartPaymentSummary!.couponDiscount.toString()}",
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .userActive,
                                                              fontSize: AddSize
                                                                  .font12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    removeCoupons(
                                                            context: context)
                                                        .then((value) {
                                                      showToast(value.message);
                                                      if (value.status ==
                                                          true) {
                                                        controller
                                                            .getAddToCartList();
                                                      }
                                                    });
                                                  },
                                                  style: TextButton.styleFrom(
                                                      padding: EdgeInsets.zero),
                                                  child: Text("Remove",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize:
                                                              AddSize.font12,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ]),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: height * .01,
                          ),
                          Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * .03,
                                    vertical: height * .02,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      details(
                                          "Subtotal:",
                                          ("₹${controller.model.value.data!.cartPaymentSummary!.subTotal}" ??
                                                  "")
                                              .toString()),
                                      SizedBox(
                                        height: height * .01,
                                      ),
                                      details("Surge:",
                                          "₹${controller.model.value.data!.cartPaymentSummary!.surCharge ?? ""}"),
                                      SizedBox(
                                        height: height * .01,
                                      ),
                                      controller
                                                  .model
                                                  .value
                                                  .data!
                                                  .cartPaymentSummary!
                                                  .tipAmount ==
                                              0
                                          ? SizedBox()
                                          : Column(
                                              children: [
                                                details(
                                                    "Tip for delivery partner:",
                                                    "₹${controller.model.value.data!.cartPaymentSummary!.tipAmount ?? ""}"),
                                                SizedBox(
                                                  height: height * .01,
                                                ),
                                              ],
                                            ),
                                      details("Save Coupon:",
                                          "₹${controller.model.value.data!.cartPaymentSummary!.couponDiscount ?? ""}"),
                                      SizedBox(
                                        height: height * .01,
                                      ),
                                      // details("Tax & fee:",
                                      //     "₹${controller.model.value.data!.cartPaymentSummary!.taxAndFee ?? ""}"),
                                      // SizedBox(
                                      //   height: height * .01,
                                      // ),
                                      details(
                                          "Delivery:",
                                          controller
                                                      .model
                                                      .value
                                                      .data!
                                                      .cartPaymentSummary!
                                                      .deliveryCharge ==
                                                  "-"
                                              ? "Free"
                                              : "₹${controller.model.value.data!.cartPaymentSummary!.deliveryCharge}"),
                                      SizedBox(
                                        height: height * .01,
                                      ),
                                      details("Packing fee:",
                                          "₹${controller.model.value.data!.cartPaymentSummary!.packingFee ?? ""}"),
                                      SizedBox(
                                        height: height * .02,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total:",
                                              style: TextStyle(
                                                  color: AppTheme.primaryColor,
                                                  fontSize: AddSize.font16,
                                                  fontWeight: FontWeight.w500)),
                                          Text(
                                              "₹${(controller.model.value.data!.cartPaymentSummary!.total ?? "").toString()}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: AddSize.font14,
                                                  fontWeight: FontWeight.w500))
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * .01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Delivery Address: ",
                                              style: TextStyle(
                                                  color: AppTheme.blackcolor,
                                                  fontSize: AddSize.font16,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      // _address != "" && _currentAddress != ""
                                      //     ? Column(
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         children: [
                                      //           Text(
                                      //             _address ?? "",
                                      //             style: Theme.of(context)
                                      //                 .textTheme
                                      //                 .headline5!
                                      //                 .copyWith(
                                      //                     fontWeight:
                                      //                         FontWeight.w500,
                                      //                     fontSize:
                                      //                         AddSize.font16),
                                      //           ),
                                      //           Text(
                                      //             _currentAddress ?? "",
                                      //             style: Theme.of(context)
                                      //                 .textTheme
                                      //                 .headline5!
                                      //                 .copyWith(
                                      //                     fontWeight:
                                      //                         FontWeight.w400,
                                      //                     fontSize:
                                      //                         AddSize.font14,
                                      //                     color: AppTheme
                                      //                         .lightblack),
                                      //           ),
                                      //         ],
                                      //       )
                                      //     :
                                      controller.model.value.data!
                                                  .orderAddress !=
                                              null
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      "Flat No. ${(controller.model.value.data!.orderAddress!.flatNo ?? "").toString()}, ${(controller.model.value.data!.orderAddress!.street ?? "").toString()}, ${(controller.model.value.data!.orderAddress!.location ?? "").toString()}",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: Colors.grey,
                                                          fontSize:
                                                              AddSize.font14,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Get.toNamed(MyAddress
                                                          .myAddressScreen);
                                                    },
                                                    child: Text("Change",
                                                        style: TextStyle(
                                                            color: AppTheme
                                                                .primaryColor,
                                                            fontSize:
                                                                AddSize.font16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)))
                                              ],
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: height * .01,
                                      ),
                                      controller.model.value.data!.orderAddress !=
                                              null
                                          // || (_address != "" && _currentAddress != "")
                                          ? ElevatedButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                    PaymentMethod.paymentScreen,
                                                    arguments: [
                                                      controller
                                                          .model
                                                          .value
                                                          .data!
                                                          .cartPaymentSummary!
                                                          .total
                                                    ]);
                                                log(controller.model.value.data!
                                                    .cartPaymentSummary!.total
                                                    .toString());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  minimumSize: const Size(
                                                      double.maxFinite, 50),
                                                  backgroundColor:
                                                      AppTheme.primaryColor,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              child: Text(
                                                "SELECT PAYMENT OPTION",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                        color: AppTheme
                                                            .backgroundcolor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            AddSize.font16),
                                              ))
                                          : ElevatedButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                    MyAddress.myAddressScreen);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  minimumSize: const Size(
                                                      double.maxFinite, 50),
                                                  backgroundColor:
                                                      AppTheme.primaryColor,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                                              child: Text(
                                                "SELECT ADDRESS",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                        color: AppTheme
                                                            .backgroundcolor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            AddSize.font16),
                                              )),
                                    ],
                                  ))),
                          SizedBox(
                            height: height * .04,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: AddSize.size100,
                          ),
                          Image(
                            height: height * .25,
                            width: width,
                            image: const AssetImage(AppAssets.cartEmpty),
                          ),
                          SizedBox(
                            height: AddSize.size20,
                          ),
                          Text("Add something",
                              style: TextStyle(
                                  color: AppTheme.blackcolor,
                                  fontSize: AddSize.font14,
                                  fontWeight: FontWeight.w500))
                        ],
                      )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    });
  }

  Obx buildObx(double width, double height, int index, BuildContext context) {
    return Obx(() {
      return Container(
        width: width * .5,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        // height: height * .23,
        child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .03,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * .12,
                            width: width * .35,
                            child: CachedNetworkImage(
                              imageUrl: relatedCartController
                                  .relatedProductModel.value.data![index].image
                                  .toString(),
                              errorWidget: (_, __, ___) => const SizedBox(),
                              placeholder: (_, __) => const SizedBox(),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  relatedCartController.relatedProductModel
                                      .value.data![index].name
                                      .toString(),
                                  style: TextStyle(
                                      color: AppTheme.blackcolor,
                                      fontSize: AddSize.font14,
                                      fontWeight: FontWeight.w500)),
                              buildDropdownButtonFormField(index),
                              SizedBox(
                                height: height * .01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(
                                  //   "₹${(relatedCartController.relatedProductModel.value.data![index].varints![relatedCartController.relatedProductModel.value.data![index].varientIndex!.value].price ?? "").toString()}",
                                  //   style: TextStyle(
                                  //       fontSize: AddSize.font14,
                                  //       color: AppTheme.primaryColor,
                                  //       fontWeight: FontWeight.w500),
                                  // ),
                                  // Text(
                                  //   "Qty: ${controller.relatedProductModel.value.data![index].varints![controller.relatedProductModel.value.data![index].varientIndex!.value].maxQty.toString()}",
                                  //   style:  TextStyle(
                                  //       fontSize:
                                  //       AddSize
                                  //           .font14,
                                  //       color:AppTheme.primaryColor,
                                  //       fontWeight: FontWeight.w500),
                                  // ),
                                  controller.isDataLoaded.value
                                      ? controller.model.value.data!.cartItems!
                                              .map(
                                                  (e) => e.variantId.toString())
                                              .toList()
                                              .contains(relatedCartController
                                                  .relatedProductModel
                                                  .value
                                                  .data![index]
                                                  .varints![
                                                      relatedCartController
                                                          .relatedProductModel
                                                          .value
                                                          .data![index]
                                                          .varientIndex!
                                                          .value]
                                                  .id
                                                  .toString())
                                          ? Container(
                                              width: width * .18,
                                              decoration: BoxDecoration(
                                                  color: AppTheme.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: height * .005,
                                                  horizontal: width * .01,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        // removeCartItemRepo(singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varints![singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].price.toString(), context);
                                                        // if (controller.model.value.data!.cartItems![index].cartItemQty == 1) {
                                                        //   removeCartItemRepo(controller.model.value.data!.cartItems![index].id.toString(), context).then((value) {
                                                        //     if (value.status == true) {
                                                        //       showToast(value.message);
                                                        //       controller.getAddToCartList();
                                                        //     } else {
                                                        //       showToast(value.message);
                                                        //     }
                                                        //   });
                                                        // }
                                                        if ((controller
                                                                        .model
                                                                        .value
                                                                        .data!
                                                                        .cartItems!
                                                                        .firstWhere(
                                                                            (element) =>
                                                                                element.variantId.toString() ==
                                                                                relatedCartController.relatedProductModel.value.data![index].varints![relatedCartController.relatedProductModel.value.data![index].varientIndex!.value].id
                                                                                    .toString(),
                                                                            orElse: () =>
                                                                                CartItems())
                                                                        .cartItemQty ??
                                                                    "0")
                                                                .toString() ==
                                                            relatedCartController
                                                                .relatedProductModel
                                                                .value
                                                                .data![index]
                                                                .varints![relatedCartController
                                                                    .relatedProductModel
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    .varientIndex!
                                                                    .value]
                                                                .minQty
                                                                .toString()) {
                                                          removeCartItemRepo(
                                                                  (controller
                                                                              .model
                                                                              .value
                                                                              .data!
                                                                              .cartItems!
                                                                              .firstWhere((element) => element.variantId.toString() == relatedCartController.relatedProductModel.value.data![index].varints![relatedCartController.relatedProductModel.value.data![index].varientIndex!.value].id.toString(), orElse: () => CartItems())
                                                                              .id ??
                                                                          "0")
                                                                      .toString(),
                                                                  context)
                                                              .then((value) {
                                                            if (value.status ==
                                                                true) {
                                                              showToast(value
                                                                  .message);
                                                              controller
                                                                  .getAddToCartList();
                                                            } else {
                                                              showToast(value
                                                                  .message);
                                                            }
                                                          });
                                                        } else {
                                                          addToCartRepo(
                                                                  relatedCartController
                                                                      .relatedProductModel
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .varints![relatedCartController
                                                                          .relatedProductModel
                                                                          .value
                                                                          .data![
                                                                              index]
                                                                          .varientIndex!
                                                                          .value]
                                                                      .id
                                                                      .toString(),
                                                                  relatedCartController
                                                                      .relatedProductModel
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  int.parse((controller.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == relatedCartController.relatedProductModel.value.data![index].varints![relatedCartController.relatedProductModel.value.data![index].varientIndex!.value].id.toString(), orElse: () => CartItems()).cartItemQty ??
                                                                              "0")
                                                                          .toString()) -
                                                                      1,
                                                                  context)
                                                              .then((value) {
                                                            showToast(
                                                                value.message);
                                                            if (value.status ==
                                                                true) {
                                                              controller
                                                                  .getAddToCartList();
                                                            }
                                                            setState(() {});
                                                          });
                                                        }
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: AppTheme
                                                            .backgroundcolor,
                                                        size: 15,
                                                      ),
                                                    ),
                                                    Obx(() {
                                                      return Text(
                                                        (controller
                                                                    .model
                                                                    .value
                                                                    .data!
                                                                    .cartItems!
                                                                    .firstWhere(
                                                                        (element) =>
                                                                            element.variantId.toString() ==
                                                                            relatedCartController.relatedProductModel.value.data![index].varints![relatedCartController.relatedProductModel.value.data![index].varientIndex!.value].id
                                                                                .toString(),
                                                                        orElse: () =>
                                                                            CartItems())
                                                                    .cartItemQty ??
                                                                "")
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize:
                                                                AddSize.font14,
                                                            color: AppTheme
                                                                .backgroundcolor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      );
                                                    }),
                                                    InkWell(
                                                      onTap: () {
                                                        relatedCartController
                                                                    .relatedProductModel
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    .varints![relatedCartController
                                                                        .relatedProductModel
                                                                        .value
                                                                        .data![
                                                                            index]
                                                                        .varientIndex!
                                                                        .value]
                                                                    .maxQty !=
                                                                (controller
                                                                        .model
                                                                        .value
                                                                        .data!
                                                                        .cartItems!
                                                                        .firstWhere((element) => element.variantId.toString() == relatedCartController.relatedProductModel.value.data![index].varints![relatedCartController.relatedProductModel.value.data![index].varientIndex!.value].id.toString(),
                                                                            orElse: () =>
                                                                                CartItems())
                                                                        .cartItemQty ??
                                                                    "")
                                                            ? addToCartRepo(
                                                                    relatedCartController
                                                                        .relatedProductModel
                                                                        .value
                                                                        .data![
                                                                            index]
                                                                        .varints![relatedCartController.relatedProductModel.value.data![index].varientIndex!.value]
                                                                        .id
                                                                        .toString(),
                                                                    relatedCartController.relatedProductModel.value.data![index].id.toString(),
                                                                    int.parse((controller.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == relatedCartController.relatedProductModel.value.data![index].varints![relatedCartController.relatedProductModel.value.data![index].varientIndex!.value].id.toString(), orElse: () => CartItems()).cartItemQty ?? "0").toString()) + 1,
                                                                    context)
                                                                .then((value) {
                                                                showToast(value
                                                                    .message);
                                                                if (value
                                                                        .status ==
                                                                    true) {
                                                                  controller
                                                                      .getAddToCartList();
                                                                } else {
                                                                  showToast(value
                                                                      .message);
                                                                }
                                                              })
                                                            : showToast("You can't add more then ${relatedCartController.relatedProductModel.value.data![index].varints![relatedCartController.relatedProductModel.value.data![index].varientIndex!.value].maxQty.toString()}");
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: AppTheme
                                                            .backgroundcolor,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6))),
                                                minimumSize: Size(
                                                    AddSize.size50,
                                                    AddSize.size30),
                                                side: const BorderSide(
                                                    color:
                                                        AppTheme.primaryColor,
                                                    width: 1),
                                                backgroundColor:
                                                    AppTheme.addColor,
                                              ),
                                              onPressed: () {
                                                int vIndex =
                                                    relatedCartController
                                                        .relatedProductModel
                                                        .value
                                                        .data![index]
                                                        .varientIndex!
                                                        .value;
                                                addToCartRepo(
                                                        relatedCartController
                                                            .relatedProductModel
                                                            .value
                                                            .data![index]
                                                            .varints![vIndex]
                                                            .id
                                                            .toString(),
                                                        relatedCartController
                                                            .relatedProductModel
                                                            .value
                                                            .data![index]
                                                            .id
                                                            .toString(),
                                                        relatedCartController
                                                            .relatedProductModel
                                                            .value
                                                            .data![index]
                                                            .varints![relatedCartController
                                                                .relatedProductModel
                                                                .value
                                                                .data![index]
                                                                .varientIndex!
                                                                .value]
                                                            .minQty
                                                            .toString(),
                                                        context)
                                                    .then((value) {
                                                  if (value.status == true) {
                                                    showToast(value.message);
                                                    controller
                                                        .getAddToCartList();
                                                  } else {
                                                    showToast(value.message);
                                                  }
                                                });
                                              },
                                              child: Text("ADD",
                                                  style: TextStyle(
                                                      fontSize: AddSize.font12,
                                                      color:
                                                          AppTheme.primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            )
                                      : const SizedBox()
                                ],
                              ),
                              // OutlinedButton(
                              //   style: OutlinedButton.styleFrom(
                              //     shape: const RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.all(
                              //             Radius.circular(10))),
                              //     side: const BorderSide(
                              //         color: AppTheme.primaryColor,
                              //         width: 1),
                              //     backgroundColor: AppTheme.addColor,
                              //   ),
                              //   onPressed: () {},
                              //   child: const Text('ADD',
                              //       style: TextStyle(
                              //           color: AppTheme.primaryColor,
                              //           fontWeight: FontWeight.w600)),
                              // ),
                            ],
                          )
                        ])
                    // : const Center(
                    //     child:
                    //         CircularProgressIndicator()),
                    ),
              ],
            )),
      );
    });
  }

  details(title, price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                color: AppTheme.blackcolor,
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w500)),
        Text(price,
            style: TextStyle(
                color: Colors.grey,
                fontSize: AddSize.font14,
                fontWeight: FontWeight.w500))
      ],
    );
  }

  chipList(
    title,
  ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return GestureDetector(
        onTap: () {},
        child: ChoiceChip(
          padding: EdgeInsets.symmetric(
              horizontal: width * .01, vertical: height * .01),
          backgroundColor: AppTheme.backgroundcolor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: title != selectedChip.value
                      ? Colors.grey.shade300
                      : const Color(0xff4169E2))),
          label: Text(title == "Custom" ? "$title" : "₹$title",
              style: TextStyle(
                  color: title != selectedChip.value
                      ? Colors.grey.shade600
                      : const Color(0xff4169E2),
                  fontSize: AddSize.font14,
                  fontWeight: FontWeight.w500)),
          selected: title == selectedChip.value,
          selectedColor: const Color(0xff4169E2).withOpacity(.3),
          onSelected: (value) {
            selectedChip.value = title;
            if (title == "Custom") {
              customTip.value = true;
              tipController.text = "";
              print(tipController.text);
            } else {
              customTip.value = false;
              tipController.text = title;
              print(tipController.text);
            }
            tipController.text != ""
                ? orderTip(tipAmount: tipController.text, context: context)
                    .then((value) {
                    showToast(value.message);
                    if (value.status == true) {
                      controller.getAddToCartList();
                    }
                  })
                : null;
            setState(() {});
          },
        ),
      );
    });
  }

  buildDropdownButtonFormField(int index) {
    return Obx(() {
      return SizedBox(
        width: AddSize.size30 * 4,
        child: DropdownButtonFormField<int>(
            decoration: InputDecoration(
              fillColor: Colors.grey.shade50,
              border: InputBorder.none,
              enabled: true,
            ),
            value: relatedCartController
                .relatedProductModel.value.data![index].varientIndex!.value,
            items: List.generate(
                relatedCartController
                    .relatedProductModel.value.data![index].varints!.length,
                (index1) => DropdownMenuItem(
                      value: index1,
                      child: Text(
                        "${relatedCartController.relatedProductModel.value.data![index].varints![index1].variantQty}${relatedCartController.relatedProductModel.value.data![index].varints![index1].variantQtyType}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    )),
            onChanged: (newValue) {
              relatedCartController.relatedProductModel.value.data![index]
                  .varientIndex!.value = newValue!;
              setState(() {});
            }),
      );
    });
  }
}
