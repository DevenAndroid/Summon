import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fresh2_arrive/model/time_model.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
                                      top: 10,
                                      left: 10,
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
                              Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.02,
                                        vertical: height * .005),
                                    child: TabBar(
                                      physics: const BouncingScrollPhysics(),
                                      unselectedLabelColor: AppTheme.blackcolor,
                                      labelColor: AppTheme.backgroundcolor,
                                      tabs: [
                                        Tab(
                                          child: Text(
                                            "Customer Detail",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: AddSize.font16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            "Driver Information",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: AddSize.font16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                      labelStyle: const TextStyle(
                                          color: AppTheme.blackcolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      unselectedLabelStyle: const TextStyle(
                                          color: AppTheme.blackcolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      controller: tabController,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    controller: tabController,
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AddSize.padding16,
                          ),
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
                                                    "Customer Name",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            color: AppTheme
                                                                .lightblack,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                AddSize.font14),
                                                  ),
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
                                                ],
                                              ),
                                            ]),
                                            Container(
                                              height: AddSize.size45,
                                              width: AddSize.size45,
                                              decoration: const ShapeDecoration(
                                                  color: Colors.orange,
                                                  shape: CircleBorder()),
                                              child: const Center(
                                                  child: Icon(
                                                Icons.person_rounded,
                                                color: AppTheme.backgroundcolor,
                                              )),
                                            ),
                                          ],
                                        ),
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
                                                    "Customer Number",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            color: AppTheme
                                                                .lightblack,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                AddSize.font14),
                                                  ),
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
                                              onTap: () {
                                                _makingPhoneCall(
                                                    "tel:+91${vendorOrderListController.model.value.data!.user!.phone ?? ""}"
                                                        .toString());
                                              },
                                              child: Container(
                                                  height: AddSize.size45,
                                                  width: AddSize.size45,
                                                  decoration:
                                                      const ShapeDecoration(
                                                          color: AppTheme
                                                              .primaryColor,
                                                          shape: CircleBorder()),
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.phone,
                                                    color:
                                                        AppTheme.backgroundcolor,
                                                  ))),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Customer Address",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                color: AppTheme
                                                                    .lightblack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: AddSize
                                                                    .font14),
                                                      ),
                                                      Text(
                                                        (vendorOrderListController
                                                                    .model
                                                                    .value
                                                                    .data!
                                                                    .user!
                                                                    .location ??
                                                                "")
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                height: 1.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: AddSize
                                                                    .font16),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                print("okay");
                                                openMap(
                                                    double.parse(
                                                        vendorOrderListController
                                                            .model
                                                            .value
                                                            .data!
                                                            .user!
                                                            .latitude
                                                            .toString()),
                                                    double.parse(
                                                        vendorOrderListController
                                                            .model
                                                            .value
                                                            .data!
                                                            .user!
                                                            .longitude
                                                            .toString()));
                                              },
                                              child: Container(
                                                height: AddSize.size45,
                                                width: AddSize.size45,
                                                decoration: const ShapeDecoration(
                                                    color: AppTheme.lightYellow,
                                                    shape: CircleBorder()),
                                                child: const Center(
                                                    child: Icon(
                                                  Icons.location_on,
                                                  color: AppTheme.backgroundcolor,
                                                )),
                                              ),
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
                      ),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AddSize.padding16,
                          ),
                          child: Column(
                            children: [
                              if (vendorOrderListController
                                      .model.value.data!.driver !=
                                  null)
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
                                          ...[
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
                                                        "Diver Name",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                color: AppTheme
                                                                    .lightblack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: AddSize
                                                                    .font14),
                                                      ),
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
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: AddSize
                                                                    .font16),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                                Container(
                                                  height: AddSize.size45,
                                                  width: AddSize.size45,
                                                  decoration:
                                                      const ShapeDecoration(
                                                          color: Colors.orange,
                                                          shape: CircleBorder()),
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.person_rounded,
                                                    color:
                                                        AppTheme.backgroundcolor,
                                                  )),
                                                ),
                                              ],
                                            ),
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
                                                        "Driver Number",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                color: AppTheme
                                                                    .lightblack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: AddSize
                                                                    .font14),
                                                      ),
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
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: AddSize
                                                                    .font16),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                                GestureDetector(
                                                  onTap: () {
                                                    _makingPhoneCall(
                                                        "tel:+91${vendorOrderListController.model.value.data!.driver!.phone ?? ""}"
                                                            .toString());
                                                  },
                                                  child: Container(
                                                      height: AddSize.size45,
                                                      width: AddSize.size45,
                                                      decoration:
                                                          const ShapeDecoration(
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              shape:
                                                                  CircleBorder()),
                                                      child: const Center(
                                                          child: Icon(
                                                        Icons.phone,
                                                        color: AppTheme
                                                            .backgroundcolor,
                                                      ))),
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Delivery Address",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5!
                                                                .copyWith(
                                                                    color: AppTheme
                                                                        .lightblack,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize: AddSize
                                                                        .font14),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  (vendorOrderListController
                                                                              .model
                                                                              .value
                                                                              .data!
                                                                              .driver!
                                                                              .location ??
                                                                          "")
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline5!
                                                                      .copyWith(
                                                                          height:
                                                                              1.5,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,
                                                                          fontSize:
                                                                              AddSize.font16),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    print("okay");
                                                    openMap(
                                                        double.parse(
                                                            vendorOrderListController
                                                                .model
                                                                .value
                                                                .data!
                                                                .address!
                                                                .latitude
                                                                .toString()),
                                                        double.parse(
                                                            vendorOrderListController
                                                                .model
                                                                .value
                                                                .data!
                                                                .address!
                                                                .longitude
                                                                .toString()));
                                                  },
                                                  child: Container(
                                                    height: AddSize.size45,
                                                    width: AddSize.size45,
                                                    decoration:
                                                        const ShapeDecoration(
                                                            color: AppTheme
                                                                .lightYellow,
                                                            shape:
                                                                CircleBorder()),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.location_on,
                                                      color: AppTheme
                                                          .backgroundcolor,
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]
                                        ],
                                      ),
                                    )),
                              paymentDetails()
                            ],
                          ),
                        ),
                      ),
                    ],
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
                    primary: AppTheme.primaryColor,
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
                )): ElevatedButton(
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
      required variantId}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                "₹" + price,
                style: TextStyle(
                    fontSize: AddSize.font16,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * .01,
        ),
        Row(
          children: [
            Text(
              qty,
              style: TextStyle(
                  fontSize: AddSize.font14,
                  color: AppTheme.lightblack,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: width * .01,
            ),
            const Text("*"),
            SizedBox(
              width: width * .01,
            ),
            // Text(
            //   itemQty,
            //   style: TextStyle(
            //       fontSize: AddSize.font14,
            //       color: AppTheme.lightblack,
            //       fontWeight: FontWeight.w500),
            // ),
          ],
        ),
        SizedBox(
          height: height * .01,
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
            : Text(
                "REJECTED",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: const Color(0xffF04148),
                    fontWeight: FontWeight.w500,
                    fontSize: AddSize.font16),
              )
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
