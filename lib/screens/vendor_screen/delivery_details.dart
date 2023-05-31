import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fresh2_arrive/model/time_model.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/MyOrder_Details_Controller.dart';
import '../../controller/Vendor_Orderlist_Controller.dart';
import '../../repositories/Order_Accept.Repo.dart';
import '../../repositories/vendor_reject_variant_repo.dart';

class DeliveryOrderDetails extends StatefulWidget {
  const DeliveryOrderDetails({Key? key}) : super(key: key);
  static var deliveryOrderDetails = "/deliveryOrderDetails";

  @override
  _DeliveryOrderDetailsState createState() => _DeliveryOrderDetailsState();
}

class _DeliveryOrderDetailsState extends State<DeliveryOrderDetails>
    with SingleTickerProviderStateMixin {
  final vendorOrderListController = Get.put(MyOrderDetailsController());
  final vendorOrderController = Get.put(VendorOrderListController());
  bool value = false;
  TabController? tabController;
  bool rejectButton = false;
  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  _makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    vendorOrderListController.getMyOrderDetails();
    // if (Get.arguments != null) {
    //   vendorOrderListController.id.value = Get.arguments[0];
    // }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Obx(() {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: backAppBar(title: "Delivery Details", context: context),
          body: vendorOrderListController.isDataLoading.value
              ? NestedScrollView(
                  headerSliverBuilder: (_, __) {
                    return [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AddSize.padding16,
                              vertical: AddSize.padding10),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AddSize.padding15,
                                            vertical: AddSize.padding15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        const ImageIcon(
                                                          AssetImage(AppAssets
                                                              .orderList),
                                                          color: AppTheme
                                                              .primaryColor,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: AddSize.size15,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Order ID : ${vendorOrderListController.model.value.data!.orderId.toString()}',
                                                              //'order id',
                                                              style: TextStyle(
                                                                  color: AppTheme
                                                                      .primaryColor,
                                                                  fontSize:
                                                                      AddSize
                                                                          .font16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              vendorOrderListController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .placedAt
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: AppTheme
                                                                      .blackcolor,
                                                                  fontSize:
                                                                      AddSize
                                                                          .font12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                            SizedBox(
                                              height: height * .02,
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: vendorOrderListController
                                                  .model
                                                  .value
                                                  .data!
                                                  .orderItems!
                                                  .length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return Column(
                                                  children: [
                                                    orderList(
                                                        name: vendorOrderListController
                                                            .model
                                                            .value
                                                            .data!
                                                            .orderItems![index]
                                                            .productName
                                                            .toString(),
                                                        price: vendorOrderListController
                                                            .model
                                                            .value
                                                            .data!
                                                            .orderItems![index]
                                                            .price
                                                            .toString(),
                                                        qty: vendorOrderListController
                                                            .model
                                                            .value
                                                            .data!
                                                            .orderItems![index]
                                                            .qty
                                                            .toString(),
                                                        status1: vendorOrderListController
                                                            .model
                                                            .value
                                                            .data!
                                                            .orderItems![index]
                                                            .status
                                                            .toString(),
                                                        variantId:
                                                            vendorOrderListController
                                                                .model
                                                                .value
                                                                .data!
                                                                .orderItems![index]
                                                                .id
                                                                .toString(),
                                                        note: vendorOrderListController
                                                            .model
                                                            .value
                                                            .data!
                                                            .orderItems![index]
                                                            .note
                                                            .toString()),
                                                    SizedBox(
                                                      height: height * .005,
                                                    ),
                                                    index != 2
                                                        ? const Divider()
                                                        : const SizedBox(),
                                                    SizedBox(
                                                      height: height * .005,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      )),
                                  Positioned(
                                      top: 16,
                                      left: 15,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: AppTheme.primaryColor),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * .04,
                                                vertical: height * .005),
                                            child: Text(
                                              vendorOrderListController.model
                                                  .value.data!.deliveryStatus
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: AddSize.font14,
                                                  color: AppTheme.backgroundcolor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )))
                                ],
                              ),
                              SizedBox(
                                height: AddSize.size14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AddSize.padding15,
                            vertical: AddSize.padding15),
                        child: Column(
                          children: [
                            vendorOrderListController
                                .model
                                .value
                                .data!
                                .driver != null ?
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Delivery by",
                                        style: GoogleFonts.ibmPlexSansArabic(
                                          fontSize: 14,
                                          color: Color(0xff797F90),
                                          fontWeight: FontWeight.w700
                                        ),

                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        (vendorOrderListController
                                            .model
                                            .value
                                            .data!
                                            .driver!
                                            .name ??
                                            "")
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                            height: 1.5,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize:
                                            AddSize.font16),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        (vendorOrderListController
                                            .model
                                            .value
                                            .data!
                                            .driver!
                                            .phone ??
                                            "")
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                            height: 1.5,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize:
                                            AddSize.font16),
                                      ),
                                    ],
                                  ),
                                ]),
                                GestureDetector(
                                    onTap: () async {
                                      // _makingPhoneCall(vendorOrderListController.model.value.data!.driver!.phone.toString());
                                      Uri phoneno = Uri.parse(
                                          "tel:${vendorOrderListController.model.value.data!.driver!.phone.toString()}");
                                      if (await launchUrl(phoneno)) {
                                      } else {}
                                      },
                                    child: Image(
                                      height: 50,
                                      width: 50,
                                      image: AssetImage(AppAssets.callIcon),)
                                ),
                              ],
                            ): SizedBox(),
                            const Divider(),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Delivery To",
                                        style: GoogleFonts.ibmPlexSansArabic(
                                          fontSize: 14,
                                          color: Color(0xff797F90),
                                          fontWeight: FontWeight.w700
                                        ),

                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        (vendorOrderListController
                                            .model
                                            .value
                                            .data!
                                            .user!
                                            .name ??
                                            "")
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                            height: 1.5,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize:
                                            AddSize.font16),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        (vendorOrderListController
                                            .model
                                            .value
                                            .data!
                                            .user!
                                            .phone ??
                                            "")
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                            height: 1.5,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize:
                                            AddSize.font16),
                                      ),
                                    ],
                                  ),
                                ]),
                                GestureDetector(
                                    onTap: (){
                                      openMap(double.parse(vendorOrderListController.model.value.data!.address!.toString()),double.parse(vendorOrderListController.model.value.data!.address!.toString()));
                                    },
                                    child: Image(
                                      height: 50,
                                      width: 50,
                                      image: AssetImage(AppAssets.loctionIcon1),)
                                ),
                              ],
                            ),



                          ],
                        ),
                      )),
                  paymentDetails()
                ],
              ),
            ),

                )
              : const Center(child: CircularProgressIndicator()),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding16),
            child: vendorOrderListController.isDataLoading.value ? vendorOrderListController.model
                .value.data!.deliveryStatus != "Reject" ?
            ElevatedButton(
                onPressed: () {
                  orderAcceptRepo(vendorOrderListController
                          .model.value.data!.orderId
                          .toString())
                      .then((value) {
                    showToast(value.message.toString());
                    if (value.status == true) {
                      vendorOrderController.vendorOrderListData();
                      Get.back();
                    }
                  });
                  // Get.toNamed(MyRouter.editProfileScreen);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    minimumSize: Size(double.maxFinite, AddSize.size50),
                    primary: vendorOrderListController.model
                        .value.data!.deliveryStatus == "Accepted" ? Colors.grey: AppTheme.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: TextStyle(
                        fontSize: AddSize.font18, fontWeight: FontWeight.w600)),
                child: Text(
                  "ACCEPT ALL",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppTheme.backgroundcolor,
                      fontWeight: FontWeight.w500,
                      fontSize: AddSize.font16),
                )):
            ElevatedButton(
                onPressed: () {
                  // orderAcceptRepo(vendorOrderListController
                  //     .model.value.data!.orderId
                  //     .toString())
                  //     .then((value) {
                  //   showToast(value.message.toString());
                  //   if (value.status == true) {
                  //     vendorOrderController.vendorOrderListData();
                  //     Get.back();
                  //   }
                  // });
                  // Get.toNamed(MyRouter.editProfileScreen);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    minimumSize: Size(double.maxFinite, AddSize.size50),
                    primary: Colors.grey,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: TextStyle(
                        fontSize: AddSize.font18, fontWeight: FontWeight.w600)),
                child: Text(
                  "REJECTED",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppTheme.backgroundcolor,
                      fontWeight: FontWeight.w500,
                      fontSize: AddSize.font16),
                )) :SizedBox(),
          ),
        ),
      );
    });
  }

  orderList(
      {required name,
      required price,
      required qty,
      required status1,
      required variantId,
      required note}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "x ${qty}",
                style: TextStyle(
                    fontSize: AddSize.font14,
                    color: AppTheme.lightblack,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: AddSize.font16,
                      color: AppTheme.blackcolor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                "SR",
                style: TextStyle(
                    fontSize: AddSize.font16,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 5,),
              Text(
                price,
                style: TextStyle(
                    fontSize: AddSize.font16,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: width * .01,
              ),
              status1 != "R"
                  ? ElevatedButton(
                  onPressed: () {
                    vendorRejectVariantRepo(order_variant_id: variantId)
                        .then((value) {
                      if (value.status == true) {
                        log(variantId);
                        showToast(value.message);
                        vendorOrderListController.getMyOrderDetails();
                      }
                    });
                    // Get.toNamed(MyRouter.editProfileScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding20, vertical: AddSize.size5),
                    // minimumSize: Size(double.maxFinite, AddSize.size50),
                    primary: const Color(0xffF04148),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text(
                    "REJECT".toUpperCase(),
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: AppTheme.backgroundcolor,
                        fontWeight: FontWeight.w500,
                        fontSize: AddSize.font16),
                  ))
                  : Container(
                height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(
                      child: Text(
                "REJECTED",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: AddSize.font14),
              ),
                    ),
                  ),
            ],
          ),
        ),
        Text(
          note,
          style: GoogleFonts.ibmPlexSansArabic(
              fontSize: AddSize.font14,
              color: Color(0xff6A8289),
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  paymentDetails() {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding15, vertical: AddSize.padding15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  details(
                    "Subtotal:",
                    vendorOrderListController.model.value.data!.itemTotal
                        .toString(),
                  ),
                  SizedBox(
                    height: AddSize.size5,
                  )
                ])));
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
        Text("₹" + price,
            style: TextStyle(
                color: Colors.grey,
                fontSize: AddSize.font14,
                fontWeight: FontWeight.w500))
      ],
    );
  }
}
