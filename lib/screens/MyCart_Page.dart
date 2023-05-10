import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/CartController.dart';
import '../controller/main_home_controller.dart';
import '../controller/notification_controller.dart';

import '../repositories/Remove_CartItem_Repo.dart';
import '../repositories/apply_coupons_repository.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import 'coupons_screen.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);
  static var myCartPage = "/myCartPage";

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final notificationController = Get.put(NotificationController());
  final controller = Get.put(MainHomeController());
  final myCartDataController = Get.put(MyCartController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      myCartDataController.getCartData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Directionality(

      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          backgroundColor: Color(0xffF2F2F2),
          toolbarHeight: 80,
          elevation: 0,
          leadingWidth: AddSize.size80,
          leading: Padding(
            padding: EdgeInsets.only(left: 25, right: 20),
            child: GestureDetector(
              onTap: () {
                //Get.back();
                controller.onItemTap(2);
              },
              child: Image.asset(
                AppAssets.BACKICON,
                height: AddSize.size30,
                //opacity: AlwaysStoppedAnimation(.80)
              ),

            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  //Get.toNamed(ChooseAddress.chooseAddressScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Cart",
                      style: TextStyle(
                          fontSize: 23,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                  ],
                ),
              ),

            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: IconButton(

                icon:
                Badge(
                  badgeStyle: const BadgeStyle(
                      badgeColor: Color(0xffFFC529)),
                  badgeContent: Obx(() {
                    return Text(
                      myCartDataController.isDataLoaded.value
                          ? myCartDataController.sum.value.toString()
                          : "0",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: AddSize.font12),
                    );
                  }),
                  child: Image.asset(
                    height: 50,
                    width: 50,
                    AppAssets.cartIcon,
                    //opacity: AlwaysStoppedAnimation(.80)
                  ),


                ), onPressed: () {},),
            ),


          ],
        ),
        //backgroundColor: Color(0xffF2F2F2),
        body: Obx(() {
          return myCartDataController.isDataLoaded.value
              ? SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: myCartDataController.model.value.data!
                        .cartItems!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: AddSize.size5),
                        child: Container(
                          decoration: BoxDecoration(
                            //color: AppTheme.backgroundcolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AddSize.padding16,
                              vertical: AddSize.padding16,
                            ),
                            child: Row(

                              children: [
                                Container(
                                  height: 120,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: myCartDataController.model
                                          .value.data!.cartItems![index].image
                                          .toString(),
                                      errorWidget: (_, __, ___) =>
                                      const SizedBox(),
                                      placeholder: (_, __) =>
                                      const SizedBox(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: AddSize.size30,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            myCartDataController.model.value
                                                .data!.cartItems![index]
                                                .name
                                                .toString(),
                                            style: TextStyle(fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff000000)),),
                                          GestureDetector(
                                            onTap: () {
                                              removeCartItemRepo(
                                                  myCartDataController.model
                                                      .value.data!
                                                      .cartItems![index].id
                                                      .toString(),
                                                  context
                                              ).then((value) {
                                                if (value.status == true) {
                                                  showToast(value.message);
                                                  myCartDataController
                                                      .getCartData();
                                                }
                                              });
                                            },
                                            child: Icon(Icons.clear,
                                              color: Color(0xff000000),
                                              size: 20,),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Text("Cake",
                                        style: TextStyle(fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff3F3B3B)),),
                                      SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            "${myCartDataController.model.value
                                                .data!.cartItems![index]
                                                .variantPrice.toString()}SR",
                                            style: TextStyle(fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff333333)),),
                                          Row(
                                            children: [
                                              Container(
                                                height: 32,
                                                width: 32,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppTheme
                                                        .primaryColor
                                                        .withOpacity(.80)
                                                ),
                                                child: Icon(Icons.add,
                                                  color: Colors.white,),
                                              ),
                                              SizedBox(width: 9,),
                                              Text("2",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight
                                                        .w500,
                                                    color: Color(
                                                        0xff000000)),),
                                              SizedBox(width: 9,),
                                              Image.asset(
                                                AppAssets.removeIcon,
                                                height: 30, width: 30,),
                                            ],
                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // SizedBox(height: 40,),
                  // Container(
                  //   height: 65,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(17),
                  //       border: Border.all(color: Colors.grey.shade300)
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //
                  //       SizedBox(
                  //         height: 40,
                  //         width: 110,
                  //         child: ElevatedButton(
                  //           onPressed: () {},
                  //           style: ElevatedButton.styleFrom(
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(10)
                  //               ),
                  //               primary: AppTheme.primaryColor.withOpacity(
                  //                   .80)
                  //           ),
                  //           child: Text("Apply",
                  //             style: TextStyle(fontSize: 16,
                  //                 fontWeight: FontWeight.w500,
                  //                 color: Colors.white),),),
                  //       ),
                  //       SizedBox(width: 120,),
                  //       Text("Promo Code",
                  //         style: TextStyle(fontSize: 17,
                  //             fontWeight: FontWeight.w400,
                  //             color: Color(0xff7C7C7C)),),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: height * .02),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .03,
                      vertical: height * .02,
                    ),
                    child: Obx(() {
                      return Container(
                        //height: height * .12,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffC0CCD4)),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                            image: AssetImage(AppAssets
                                                .coupons_image)),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text("Use Coupons",
                                            style: TextStyle(
                                                color:
                                                AppTheme.blackcolor,
                                                fontSize:
                                                AddSize.font14,
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
                              myCartDataController.model.value.data!
                                  .cartPaymentSummary!.couponCode == 0 ||
                                  myCartDataController
                                      .model
                                      .value
                                      .data!
                                      .cartPaymentSummary
                                  !.couponCode
                                      .toString() ==
                                      ""
                                  ? const SizedBox()
                                  :
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
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
                                              "${myCartDataController.model
                                                  .value.data!
                                                  .cartPaymentSummary
                                                  ?.couponCode
                                                  .toString()} applied successfully",
                                              style: TextStyle(
                                                  color: AppTheme
                                                      .userActive,
                                                  fontSize:
                                                  AddSize
                                                      .font14,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500)),
                                          Text(
                                              "You saved ₹${myCartDataController
                                                  .model.value.data!
                                                  .cartPaymentSummary
                                                  ?.couponDiscount.toString()}",
                                              style: TextStyle(
                                                  color: AppTheme
                                                      .userActive,
                                                  fontSize:
                                                  AddSize
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
                                          print("hello offer");
                                          if (value.status == true) {
                                            showToast(value.message);
                                            myCartDataController.getCartData();
                                            setState(() {});
                                          }
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                          padding:
                                          EdgeInsets.zero),
                                      child: Text("Remove",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize:
                                              AddSize.font12,
                                              fontWeight:
                                              FontWeight
                                                  .w500)),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  // Container(
                  //     height: 110,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(17),
                  //         border: Border.all(color: Colors.grey.shade300)
                  //     ),
                  //     child: Padding(
                  //       padding: EdgeInsets.symmetric(
                  //         horizontal: width * .03,
                  //         vertical: height * .02,
                  //       ),
                  //       child: Column(
                  //         children: [
                  //           InkWell(
                  //             onTap: () {
                  //               Get.toNamed(
                  //                   CouponsScreen.couponsScreen);
                  //             },
                  //             child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment
                  //                     .spaceBetween,
                  //                 children: [
                  //                   Icon(
                  //                     Icons.arrow_back_ios,
                  //                     color: Colors.black,
                  //                     size: AddSize.size15,
                  //                   ),
                  //                   Row(
                  //                     children: [
                  //                       Text("Use Coupons",
                  //                           style: TextStyle(
                  //                               color:
                  //                               Color(0xff293044),
                  //                               fontSize: 15,
                  //                               fontWeight:
                  //                               FontWeight.w600)),
                  //                       SizedBox(width: 10,),
                  //
                  //                       const Image(
                  //                           opacity: AlwaysStoppedAnimation(
                  //                               .80),
                  //                           height: 22,
                  //                           width: 28,
                  //                           image: AssetImage(AppAssets
                  //                               .couponIcon,)),
                  //                     ],
                  //                   ),
                  //
                  //                 ]),
                  //           ),
                  //           Row(
                  //               mainAxisAlignment:
                  //               MainAxisAlignment
                  //                   .spaceBetween,
                  //               children: [
                  //                 Container(
                  //                   height: 20,
                  //                   width: 20,
                  //                   decoration:
                  //                   const ShapeDecoration(
                  //                       color: AppTheme
                  //                           .userActive,
                  //                       shape:
                  //                       CircleBorder()),
                  //                   child: Center(
                  //                       child: Icon(
                  //                         Icons.check,
                  //                         color: AppTheme
                  //                             .backgroundcolor,
                  //                         size: AddSize.size12,
                  //                       )),
                  //                 ),
                  //                 const SizedBox(
                  //                   width: 16,
                  //                 ),
                  //                 Expanded(
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                     CrossAxisAlignment
                  //                         .start,
                  //                     children: [
                  //                       Text(
                  //                           "",
                  //                           style: TextStyle(
                  //                               color: AppTheme
                  //                                   .userActive,
                  //                               fontSize:
                  //                               AddSize
                  //                                   .font14,
                  //                               fontWeight:
                  //                               FontWeight
                  //                                   .w500)),
                  //                       Text(
                  //                           "",
                  //                           style: TextStyle(
                  //                               color: AppTheme
                  //                                   .userActive,
                  //                               fontSize:
                  //                               AddSize
                  //                                   .font12,
                  //                               fontWeight:
                  //                               FontWeight
                  //                                   .w500)),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 TextButton(
                  //                   onPressed: () {
                  //
                  //                   },
                  //                   style: TextButton.styleFrom(
                  //                       padding:
                  //                       EdgeInsets.zero),
                  //                   child: Text("Remove",
                  //                       style: TextStyle(
                  //                           color: AppTheme.primaryColor
                  //                               .withOpacity(.80),
                  //                           fontSize:
                  //                           AddSize.font12,
                  //                           fontWeight:
                  //                           FontWeight
                  //                               .w500)),
                  //                 ),
                  //               ]),
                  //         ],
                  //       ),
                  //     )),
                  SizedBox(height: 20,),
                  if(myCartDataController.model.value.data!.cartPaymentSummary != null)
                  details("Subtotal (includes VAT)", ("${myCartDataController.model.value.data!.cartPaymentSummary!.subTotal ?? ""}"),"SR"),
                  Divider(
                    height: 10,
                    color: Color(0xffC0CCD4),
                    // color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                  SizedBox(height: 5,),
                  details("Delivery", myCartDataController.model.value.data!.cartPaymentSummary!.deliveryCharge.toString(), "SR"),
                  Divider(
                    height: 10,
                    color: Color(0xffC0CCD4),
                    // color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                  SizedBox(height: 5,),
                  details("Savings", myCartDataController.model.value.data!.cartPaymentSummary!.couponDiscount.toString(), "SR"),
                  Divider(
                    height: 10,
                    color: Color(0xffC0CCD4),
                    // color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                  details("Total", myCartDataController.model.value.data!.cartPaymentSummary!.total.toString(), "SR"),


                  SizedBox(height: 60,),
                  ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                          primary: AppTheme.primaryColor,
                          minimumSize: const Size(double.maxFinite, 60),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      child: const Text(
                        "Checkout",
                      )),
                  SizedBox(height: 80,),
                ],
              ),
            ),
          )
              : Center(child: CircularProgressIndicator());
        }),


      )
      ,
    );
  }

  details(title, price, content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
          Flexible(child: Container()),
          Text(price,
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w300)),
          SizedBox(width: 5,),
          Text(content,
              style: TextStyle(
                  color: Color(0xffADADB8),
                  fontSize: 14,
                  fontWeight: FontWeight.w400))
        ],
      ),
    );
  }

}
