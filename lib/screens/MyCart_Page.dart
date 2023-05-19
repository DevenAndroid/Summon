import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:fresh2_arrive/model/time_model.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/screens/thankyou_screen.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/CartController.dart';
import '../controller/SingleProductController.dart';
import '../controller/main_home_controller.dart';
import '../controller/notification_controller.dart';

import '../repositories/Add_To_Cart_Repo.dart';
import '../repositories/CheckOut1_Repo.dart';
import '../repositories/My_Cart_Repo.dart';
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
  final singleProductController = Get.put(SingleProductController());

  String deliveryType = "pickup";
  RxString selectedValue = "cod".obs;
  RxString selectedValue1 = "pickup".obs;


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
                // Get.back();
                controller.onItemTap(2);
                // Navigator.pop(context);
              },
              child: Image.asset(
                AppAssets.BACKICON,
                height: AddSize.size30,
                //opacity: AlwaysStoppedAnimation(.80)
              ),

            ),
          ),
          centerTitle: true,
          title: const Text(
            "Cart",
            style: TextStyle(
                fontSize: 23,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 12),
          //     child: IconButton(
          //
          //       icon:
          //       Badge(
          //         badgeStyle: const BadgeStyle(
          //             badgeColor: Color(0xffFFC529)),
          //         badgeContent: Obx(() {
          //           return Text(
          //             myCartDataController.isDataLoaded.value
          //                 ? myCartDataController.sum.value.toString()
          //                 : "0",
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: AddSize.font12),
          //           );
          //         }),
          //         child: Image.asset(
          //           height: 50,
          //           width: 50,
          //           AppAssets.cartIcon,
          //           //opacity: AlwaysStoppedAnimation(.80)
          //         ),
          //
          //
          //       ), onPressed: () {},),
          //   ),
          //
          //
          // ],
        ),
        //backgroundColor: Color(0xffF2F2F2),
        body:
        Obx(() {
          return myCartDataController.isDataLoaded.value
              ? SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: [
                  Card(
                    color: Color(0xffFFFFFF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: myCartDataController.model.value.data!
                          .cartItems!.length,
                      itemBuilder: (BuildContext context, int index1) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  //color: AppTheme.backgroundcolor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 5,
                                  ),
                                  child: Row(

                                    children: [
                                      Container(
                                        height: 90,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                          child: CachedNetworkImage(
                                            imageUrl: myCartDataController.model
                                                .value.data!.cartItems![index1]
                                                .image
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
                                        width: AddSize.size10,
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
                                                  myCartDataController.model
                                                      .value
                                                      .data!.cartItems![index1]
                                                      .name
                                                      .toString(),
                                                  style: GoogleFonts
                                                      .ibmPlexSansArabic(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      color: Color(
                                                          0xff000000)),),

                                                InkWell(
                                                    onTap: () {
                                                      removeCartItemRepo(
                                                          myCartDataController
                                                              .model.value.data!
                                                              .cartItems![index1]
                                                              .id.toString(),
                                                          context).then((
                                                          value) {
                                                        if (value.status ==
                                                            true) {
                                                          showToast(
                                                              value.message);
                                                          myCartDataController
                                                              .getCartData();
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.clear, size: 20,
                                                      color: Color(
                                                          0xff000000),))
                                              ],
                                            ),

                                            Text(
                                              myCartDataController.model.value
                                                  .data!.cartItems![index1]
                                                  .note.toString(),
                                              style: GoogleFonts
                                                  .ibmPlexSansArabic(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff333333)),),


                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  "${myCartDataController.model
                                                      .value
                                                      .data!.cartItems![index1]
                                                      .variantPrice
                                                      .toString()}SR",
                                                  style: GoogleFonts
                                                      .ibmPlexSansArabic(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .w500,
                                                      color: Color(
                                                          0xff333333)),),
                                                Container(
                                                  height: height * .04,
                                                  width: width * .25,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(12),
                                                      border: Border.all(
                                                          color: Color(
                                                              0xffC4C4C4))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          updateCartRepo(
                                                              myCartDataController
                                                                  .model.value
                                                                  .data!
                                                                  .cartItems![index1]
                                                                  .id
                                                                  .toString(),
                                                              int.parse(
                                                                  (myCartDataController
                                                                      .model
                                                                      .value
                                                                      .data!
                                                                      .cartItems![index1]
                                                                      .cartItemQty ??
                                                                      "")
                                                                      .toString()) -
                                                                  1, context)
                                                              .then((value) {
                                                            if (value.status ==
                                                                true) {
                                                              showToast(value
                                                                  .message);
                                                              myCartDataController
                                                                  .getCartData();
                                                            }
                                                          });
                                                          setState(() {

                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: AppTheme
                                                              .primaryColor,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 9,
                                                      ),
                                                      Text(
                                                        myCartDataController
                                                            .model.value.data!
                                                            .cartItems![index1]
                                                            .cartItemQty
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .ibmPlexSansArabic(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight
                                                                .w700,
                                                            color: Color(
                                                                0xff000000)),
                                                      ),
                                                      SizedBox(
                                                        width: 9,
                                                      ),
                                                      InkWell(

                                                        onTap: () {
                                                          myCartDataController
                                                              .model.value.data!
                                                              .cartItems![index1]
                                                              .maxQty !=
                                                              myCartDataController
                                                                  .model.value
                                                                  .data!
                                                                  .cartItems![index1]
                                                                  .cartItemQty
                                                                  .toString() ?
                                                          updateCartRepo(
                                                              myCartDataController
                                                                  .model.value
                                                                  .data!
                                                                  .cartItems![index1]
                                                                  .id
                                                                  .toString(),
                                                              int.parse(
                                                                  (myCartDataController
                                                                      .model
                                                                      .value
                                                                      .data!
                                                                      .cartItems![index1]
                                                                      .cartItemQty ??
                                                                      "")
                                                                      .toString()) +
                                                                  1, context)
                                                              .then((value) {
                                                            if (value.status ==
                                                                true) {
                                                              showToast(value
                                                                  .message);
                                                              myCartDataController
                                                                  .getCartData();
                                                            }
                                                          }) : showToast(
                                                              "can add more than ${myCartDataController
                                                                  .model.value
                                                                  .data!
                                                                  .cartItems![index1]
                                                                  .maxQty} item ");
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: AppTheme
                                                              .primaryColor,
                                                          size: 22,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                            // SizedBox(height: height * .1,),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if(myCartDataController.model.value
                                        .data!.cartItems![index1]
                                        .addons != null &&
                                        myCartDataController.model.value
                                            .data!.cartItems![index1]
                                            .addons!.isNotEmpty)
                                      Text(
                                        "Addons",
                                        style: GoogleFonts.ibmPlexSansArabic(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000)),),
                                  ],
                                ),
                              ),

                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: myCartDataController.model.value
                                      .data!.cartItems![index1].addons!.length,
                                  itemBuilder: (BuildContext context,
                                      int index2) {
                                    return
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            if(myCartDataController.model.value
                                                .data!.cartItems![index1]
                                                .addons != null &&
                                                myCartDataController.model.value
                                                    .data!.cartItems![index1]
                                                    .addons!.isNotEmpty)
                                              Text(
                                                "${myCartDataController.model
                                                    .value
                                                    .data!.cartItems![index1]
                                                    .addons![index2].name
                                                    .toString()}",
                                                style: GoogleFonts
                                                    .ibmPlexSansArabic(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff333333)),),
                                            SizedBox(width: 10,),
                                            Text(
                                              "x",
                                              style: GoogleFonts
                                                  .ibmPlexSansArabic(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff333333)),),

                                            Text(
                                              " ${myCartDataController.model
                                                  .value.data!
                                                  .cartItems![index1]
                                                  .cartItemQty.toString()} ",
                                              style: GoogleFonts
                                                  .ibmPlexSansArabic(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff333333)),),

                                            Flexible(child: Container()),

                                            if(myCartDataController.model.value
                                                .data!.cartItems![index1]
                                                .addons != null &&
                                                myCartDataController.model.value
                                                    .data!.cartItems![index1]
                                                    .addons!.isNotEmpty)
                                              Text(
                                                "SR",
                                                style: GoogleFonts
                                                    .ibmPlexSansArabic(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff333333)),),
                                            SizedBox(width: 3,),
                                            if(myCartDataController.model.value
                                                .data!.cartItems![index1]
                                                .addons != null &&
                                                myCartDataController.model.value
                                                    .data!.cartItems![index1]
                                                    .addons!.isNotEmpty)
                                              Text(
                                                "${myCartDataController.model
                                                    .value
                                                    .data!.cartItems![index1]
                                                    .addons![index2].price
                                                    .toString()}",
                                                style: GoogleFonts
                                                    .ibmPlexSansArabic(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff333333)),),
                                            SizedBox(width: 20,),


                                          ],
                                        ),
                                      );
                                  }),

                              SizedBox(height: height * .01),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: height * .01),
                  if(myCartDataController.model.value.data!
                      .cartItems != null &&
                      myCartDataController.model.value.data!
                          .cartItems!.isNotEmpty)
                    Obx(() {
                      return Card(
                        child: Container(
                          // height: height * .06,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child:
                            Column(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          CouponsScreen.couponsScreen);
                                    },
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Expanded(
                                            child: Row(children: [
                                              const Image(
                                                  color: AppTheme.primaryColor,
                                                  height: 22,
                                                  width: 28,
                                                  image: AssetImage(AppAssets
                                                      .coupons_image,)),
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
                                Obx(() {
                                  return Row(
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
                                                      ?.couponDiscount
                                                      .toString()}",
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
                                                myCartDataController
                                                    .getCartData();
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
                                      ]);
                                }),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10)
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 5,
                  //       vertical: 3
                  //     ),
                  //     child: Container(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //
                  //             Image(
                  //                 height: 50,
                  //                 width: 40,
                  //                 image: AssetImage(
                  //               AppAssets.promoIcon
                  //             )),
                  //             Text("Promo Code",style:  GoogleFonts.ibmPlexSansArabic(fontSize: 18,
                  //                 fontWeight: FontWeight.w700,
                  //                 color: Color(0xff7C7C7C)),),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: height * .01,),

                  if(myCartDataController.model.value.data!
                      .cartItems != null &&
                      myCartDataController.model.value.data!
                          .cartItems!.isNotEmpty)
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 3
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height: 40,
                                        width: 40,

                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,

                                        ),
                                        child: Image(image: AssetImage(
                                            AppAssets.loctionIcon1),)
                                    ),
                                    SizedBox(width: 10,),
                                    Text("Free",
                                      style: GoogleFonts.ibmPlexSansArabic(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000)),),
                                    Flexible(child: Container()),
                                    Text("PickUp",
                                      style: GoogleFonts.ibmPlexSansArabic(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000)),),
                                    Radio<String>(
                                        value: "pickup",
                                        groupValue: selectedValue1.value,
                                        onChanged: (value) {
                                          selectedValue1.value = value!;
                                          orderTypeRepo(
                                              orderType: selectedValue1.value
                                                  .toString());
                                          setState(() {

                                          });
                                          print(selectedValue1.value);
                                        }),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height: 40,
                                        width: 40,

                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.primaryColor,
                                        ),
                                        child: Image(image: AssetImage(
                                            AppAssets.loctionIcon1),)),
                                    SizedBox(width: 10,),
                                    Text("15 SR",
                                      style: GoogleFonts.ibmPlexSansArabic(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000)),),
                                    Flexible(child: Container()),
                                    Text("..",
                                      style: GoogleFonts.ibmPlexSansArabic(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.primaryColor),),
                                    Text("Deliver to Home",
                                      style: GoogleFonts.ibmPlexSansArabic(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000)),),
                                    Radio<String>(
                                        value: "delivery",
                                        groupValue: selectedValue1.value,
                                        onChanged: (value) {
                                          selectedValue1.value = value!;
                                          orderTypeRepo(
                                              orderType: selectedValue1
                                                  .toString());
                                          setState(() {

                                          });
                                          print(selectedValue1.value);
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 20,),
                  // if(myCartDataController.model.value.data!.cartPaymentSummary != null)
                  if(myCartDataController.model.value.data!
                      .cartItems != null &&
                      myCartDataController.model.value.data!
                          .cartItems!.isNotEmpty)
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          if(myCartDataController.model.value.data!
                              .cartPaymentSummary != null)
                            details("Subtotal (includes VAT)",
                                ("${myCartDataController.model.value.data!
                                    .cartPaymentSummary!.subTotal ?? ""}"),
                                "SR"),
                          Divider(
                            height: 5,
                            color: Color(0xffC0CCD4),
                            // color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                          SizedBox(height: 5,),
                          details("Delivery",
                              myCartDataController.model.value.data!
                                  .cartPaymentSummary!.deliveryCharge
                                  .toString(), "SR"),
                          Divider(
                            height: 10,
                            color: Color(0xffC0CCD4),
                            // color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                          SizedBox(height: 5,),
                          details("Savings",
                              myCartDataController.model.value.data!
                                  .cartPaymentSummary!.couponDiscount
                                  .toString(), "SR"),
                          Divider(
                            height: 10,
                            color: Color(0xffC0CCD4),
                            // color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                          details("Wallet balance",
                              myCartDataController.model.value.data!
                                  .cartPaymentSummary!.walletSaving.toString(),
                              "SR"),
                          Divider(
                            height: 10,
                            color: Color(0xffC0CCD4),
                            // color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                          details("Total",
                              myCartDataController.model.value.data!
                                  .cartPaymentSummary!.total.toString(), "SR"),


                        ],
                      ),
                    ),
                  SizedBox(height: height * .02,),
                  if(myCartDataController.model.value.data!
                      .cartItems != null &&
                      myCartDataController.model.value.data!
                          .cartItems!.isNotEmpty)
                    SizedBox(
                      height: height * .2,
                      width: width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Payment Method",
                                      style: GoogleFonts.ibmPlexSansArabic(
                                          color: Color(0xff000000),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                  Text("..",
                                      style: GoogleFonts.ibmPlexSansArabic(
                                          color: AppTheme.primaryColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                              Row(
                                children: [

                                  Radio<String>(
                                      value: "cod",
                                      groupValue: selectedValue.value,
                                      onChanged: (value) {
                                        selectedValue.value = value!;
                                        // orderTypeRepo(orderType: paymentType);
                                        setState(() {

                                        });
                                        print(selectedValue.value);
                                      }),
                                  Text("COD",
                                      style: GoogleFonts.ibmPlexSansArabic(
                                          color: Color(0xff000000),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                              Row(
                                children: [

                                  Radio<String>(
                                      value: "Prepaid",
                                      groupValue: selectedValue.value,
                                      onChanged: (value) {
                                        selectedValue.value = value!;
                                        // orderTypeRepo(orderType: paymentType);
                                        setState(() {

                                        });
                                        print(selectedValue.value);
                                      }),
                                  Text("Prepaid",
                                      style: GoogleFonts.ibmPlexSansArabic(
                                          color: Color(0xff000000),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 60,),
                  myCartDataController.model.value.data!
                      .cartItems != null &&
                      myCartDataController.model.value.data!
                          .cartItems!.isNotEmpty ?
                  ElevatedButton(
                      onPressed: () async {
                        checkOutRepo1(
                            type: selectedValue1.toString(),
                            payment_type: selectedValue.toString(),
                            context: context).then((value) {
                          if (value.status == true) {
                            showToast(value.message);
                            Get.toNamed(ThankYouScreen.thankYouScreen,
                                arguments: [
                                  value.data!.orderType,
                                  value.data!.orderId,
                                  value.data!.placedAt,
                                  value.data!.paymentType,
                                  value.data!.itemTotal,
                                  value.data!.deliveryCharges,
                                  value.data!.grandTotal,


                                ]
                            );
                          }
                        });
                      },
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
                      )) : Center(child: Text("Cart is Empty")),
                  SizedBox(height: 80,),
                ],
              ),
            ),
          )
              : Center(child: CircularProgressIndicator());
        }),


      ),
    );
  }

  details(title, price, content) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.ibmPlexSansArabic(
                  color: Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          Flexible(child: Container()),
          Text(price,
              style: GoogleFonts.ibmPlexSansArabic(
                  color: Color(0xff333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w700)),
          SizedBox(width: 5,),
          Text(content,
              style: GoogleFonts.ibmPlexSansArabic(
                  color: Color(0xffADADB8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

}
