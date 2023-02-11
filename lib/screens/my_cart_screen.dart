import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/screens/coupons_screen.dart';
import 'package:fresh2_arrive/screens/payment_method.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:fresh2_arrive/widgets/editprofile_textfield.dart';
import 'package:get/get.dart';
import '../controller/My_cart_controller.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../resources/app_theme.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);
  static var myCartScreen = "/myCartScreen";

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final controller = Get.put(MyCartDataListController());
  final TextEditingController tipController = TextEditingController();
  final TextEditingController variantIdController = TextEditingController();
  final List<String> tips = ["₹20", "₹30", "₹40", "Custom"];
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
            child: controller.isDataLoaded.value == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          itemCount:
                              controller.model.value.data!.cartItems!.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: height * .015),
                          physics: const NeverScrollableScrollPhysics(),
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
                                                  errorWidget: (_, __, ___) =>
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        controller
                                                            .model
                                                            .value
                                                            .data!
                                                            .cartItems![index]
                                                            .name
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: AppTheme
                                                                .blackcolor,
                                                            fontSize:
                                                                AddSize.font16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    SizedBox(
                                                      height: height * .005,
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
                                                              controller
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .cartItems![
                                                                      index]
                                                                  .variantQty
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      AddSize
                                                                          .font12,
                                                                  color: AppTheme
                                                                      .blackcolor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              controller
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .cartItems![
                                                                      index]
                                                                  .variantQtyType
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      AddSize
                                                                          .font12,
                                                                  color: AppTheme
                                                                      .lightblack,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          width: width * .20,
                                                          decoration: BoxDecoration(
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal:
                                                                  width * .02,
                                                              vertical:
                                                                  height * .005,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {},
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: AppTheme
                                                                        .backgroundcolor,
                                                                    size: 15,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  controller
                                                                      .model
                                                                      .value
                                                                      .data!
                                                                      .cartItems![
                                                                          index]
                                                                      .cartItemQty
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          AddSize
                                                                              .font14,
                                                                      color: AppTheme
                                                                          .backgroundcolor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    addToCartRepo(
                                                                            "10",
                                                                            "1",
                                                                            context)
                                                                        .then(
                                                                            (value) {
                                                                      if (value
                                                                              .status ==
                                                                          true) {
                                                                        showToast(
                                                                            value.message);
                                                                        controller
                                                                            .getAddToCartList();
                                                                      } else {
                                                                        showToast(
                                                                            value.message);
                                                                      }
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Icon(
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
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height: height * .01),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            controller
                                                                .model
                                                                .value
                                                                .data!
                                                                .cartItems![
                                                                    index]
                                                                .variantPrice
                                                                .toString(),
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
                                                          controller
                                                              .model
                                                              .value
                                                              .data!
                                                              .cartItems![index]
                                                              .totalPrice
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: AddSize
                                                                  .font16,
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                            width: width * .06),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]),
                                      ),
                                      const Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Icon(
                                          Icons.clear,
                                          color: AppTheme.primaryColor,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          }),
                      SizedBox(height: height * .02),
                      Text("You may also like",
                          style: TextStyle(
                              color: const Color(0xff423E5E),
                              fontSize: AddSize.font10 * 1.7,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: height * .35,
                        child: Obx(() {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller
                                  .relatedProductModel.value.data!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: height * .02),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: width * .5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
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
                                                horizontal: width * .03,
                                              ),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: height * .12,
                                                      width: width * .25,
                                                      child: CachedNetworkImage(
                                                        imageUrl: controller
                                                            .relatedProductModel
                                                            .value
                                                            .data![index]
                                                            .image
                                                            .toString(),
                                                        errorWidget: (_, __,
                                                                ___) =>
                                                            const SizedBox(),
                                                        placeholder: (_, __) =>
                                                            const SizedBox(),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            controller
                                                                .relatedProductModel
                                                                .value
                                                                .data![index]
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
                                                                        .w500)),
                                                        DropdownButtonFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            fillColor: Colors
                                                                .grey.shade50,
                                                            border: InputBorder
                                                                .none,
                                                            enabled: true,
                                                          ),
                                                          hint: Text(
                                                            'Select qty',
                                                            style: TextStyle(
                                                                color: AppTheme
                                                                    .userText,
                                                                fontSize: AddSize
                                                                    .font14),
                                                          ),
                                                          // value: selectedCAt.value == ""
                                                          //     ? null
                                                          //     : selectedCAt.value,
                                                          items: List.generate(
                                                              index + 2,
                                                              (index1) =>
                                                                  DropdownMenuItem(
                                                                    value: index1
                                                                        .toString(),
                                                                    child: Text(
                                                                      "${index1}Kg",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  )),
                                                          // items: dropDownList.map((value) {
                                                          //   return DropdownMenuItem(
                                                          //     value: value,
                                                          //     child: Text(
                                                          //       value,
                                                          //       style: const TextStyle(
                                                          //           fontSize: 16),
                                                          //     ),
                                                          //   );
                                                          // }).toList(),
                                                          onChanged:
                                                              (newValue) {
                                                            selectedCAt.value =
                                                                newValue
                                                                    .toString();
                                                          },
                                                          // validator: (String? value) {
                                                          //   if (value?.isEmpty ?? true) {
                                                          //     return 'Please select bank';
                                                          //   }
                                                          //   return null;
                                                          // },
                                                        ),
                                                        SizedBox(
                                                          height: height * .01,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "₹15.0",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      AddSize
                                                                          .font14,
                                                                  color: AppTheme
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            OutlinedButton(
                                                              style:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(6))),
                                                                minimumSize: Size(
                                                                    AddSize
                                                                        .size50,
                                                                    AddSize
                                                                        .size30),
                                                                side: const BorderSide(
                                                                    color: AppTheme
                                                                        .primaryColor,
                                                                    width: 1),
                                                                backgroundColor:
                                                                    AppTheme
                                                                        .addColor,
                                                              ),
                                                              onPressed: () {
                                                                addToCartRepo(
                                                                        "10",
                                                                        "1",
                                                                        context)
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .status ==
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
                                                              },
                                                              child: Text('ADD',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          AddSize
                                                                              .font12,
                                                                      color: AppTheme
                                                                          .primaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                            )
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
                        }),
                      ),
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
                                  Text(
                                      "Thank your delivery partner by leaving them a tip 100% of the tip will go your delivery partner.",
                                      style: TextStyle(
                                          color: AppTheme.blackcolor,
                                          fontSize: AddSize.font14,
                                          fontWeight: FontWeight.w300)),
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
                                    EditProfileTextFieldWidget(
                                      hint: "₹ Enter tip amount",
                                      controller: tipController,
                                      suffix: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            color: AppTheme.primaryColor,
                                          )),
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
                                      Get.toNamed(CouponsScreen.couponsScreen);
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
                                                  color: AppTheme.blackcolor,
                                                  fontSize: AddSize.font14,
                                                  fontWeight: FontWeight.w500)),
                                        ]),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                        size: AddSize.size15,
                                      ),
                                    ])),
                                SizedBox(
                                  height: AddSize.size10,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const ShapeDecoration(
                                            color: AppTheme.userActive,
                                            shape: CircleBorder()),
                                        child: Center(
                                            child: Icon(
                                          Icons.check,
                                          color: AppTheme.backgroundcolor,
                                          size: AddSize.size12,
                                        )),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "WELCOME50 applied successfully",
                                                style: TextStyle(
                                                    color: AppTheme.userActive,
                                                    fontSize: AddSize.font14,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text("You saved ₹5",
                                                style: TextStyle(
                                                    color: AppTheme.userActive,
                                                    fontSize: AddSize.font12,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero),
                                        child: Text("Remove",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: AddSize.font12,
                                                fontWeight: FontWeight.w500)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  details("Subtotal:", "₹30.30"),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  details("Surcharge:", "₹5.00"),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  details("Tax & fee:", "₹5.00"),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  details("Delivery:", "Free"),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  details("Packing fee:", "Free"),
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
                                      Text("₹40.00",
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Delivery Address: ",
                                          style: TextStyle(
                                              color: AppTheme.blackcolor,
                                              fontSize: AddSize.font16,
                                              fontWeight: FontWeight.w500)),
                                      TextButton(
                                          onPressed: () {},
                                          child: Text("Change",
                                              style: TextStyle(
                                                  color: AppTheme.primaryColor,
                                                  fontSize: AddSize.font16,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  Text("184 Main Collins Street\nVictoria 8007",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: AddSize.font14,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(
                                            PaymentMethod.paymentScreen);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(10),
                                          minimumSize:
                                              const Size(double.maxFinite, 50),
                                          backgroundColor:
                                              AppTheme.primaryColor,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                      child: Text(
                                        "SELECT PAYMENT OPTION",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                color: AppTheme.backgroundcolor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: AddSize.font16),
                                      )),
                                ],
                              ))),
                      SizedBox(
                        height: height * .04,
                      )
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
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
      return ChoiceChip(
        padding: EdgeInsets.symmetric(
            horizontal: width * .01, vertical: height * .01),
        backgroundColor: AppTheme.backgroundcolor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: title != selectedChip.value
                    ? Colors.grey.shade300
                    : const Color(0xff4169E2))),
        label: Text("$title",
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
          } else {
            customTip.value = false;
            tipController.text = title;
          }
          setState(() {});
        },
      );
    });
  }
}
