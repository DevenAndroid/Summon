
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/assigned_order_list_controller.dart';
import '../../controller/delivery_order_list_controller.dart';
import '../../controller/main_home_controller.dart';
import '../../repositories/accept_order_by_driver.dart';
import '../../repositories/delivery_verify_otp_repo.dart';
import '../../repositories/driver_mode_update_repo.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/dimensions.dart';
import '../Language_Change_Screen.dart';
import 'delivered_successfully.dart';

class DeliveryDashboard extends StatefulWidget {
  const DeliveryDashboard({Key? key}) : super(key: key);
  static var deliveryDashboard = "/deliveryDashboard";
  @override
  State<DeliveryDashboard> createState() => _DeliveryDashboardState();
}

class _DeliveryDashboardState extends State<DeliveryDashboard> {
  final RxBool _store = false.obs;
  final controller = Get.put(MainHomeController());
  final deliveryOrderListController = Get.put(DeliveryOrderListController());
  // final orderController = Get.put(MyOrderDetailsController());
  final assignedController = Get.put(AssignedOrderController());
  Rx<File> image = File("").obs;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.backgroundcolor,
          leadingWidth: AddSize.size20 * 2,
          title: Text(
            "Dashboard".tr,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppTheme.blackcolor),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppAssets.back,
                )),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding20,
              ),
              child: Obx(() {
                return Row(
                  children: [
                    Text(
                      "Delivery Mode".tr,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: AddSize.font14,
                          color: AppTheme.blackcolor),
                    ),
                    SizedBox(
                      width: AddSize.size10,
                    ),
                    FlutterSwitch(
                      height: AddSize.size20,
                      width: AddSize.size40,
                      activeColor: AppTheme.primaryColor,
                      toggleSize: AddSize.size5 * 2.5,
                      value: deliveryOrderListController.isDataLoading.value
                          ? (deliveryOrderListController.model.value.data!.deliveryMode ??  false)
                          : _store.value,
                      onToggle: (val) {
                        deliveryModeUpdateRepo().then((value) {
                          if (value.status == true) {
                            deliveryOrderListController.getData();
                            print(val);
                            deliveryOrderListController.model.value.data!.deliveryMode = val;
                            if (deliveryOrderListController.model.value.data!.deliveryMode == true)
                            {
                              showToast("Delivery mode on");
                            }
                            else{
                              showToast("Delivery mode off");
                            }
                          }
                        });
                      },
                    ),
                  ],
                );
              }),
            )
          ],
          bottom: !controller.internetConnection.value
              ? PreferredSize(
                  preferredSize: const Size(double.maxFinite, 22),
                  child: Container(
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: const Text(
                        "No Internet Action",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                )
              : null,
        ),
        body: Obx(() {
          return deliveryOrderListController.isDataLoading.value
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, ${deliveryOrderListController.model.value.data!.username.toString()}!",
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AddSize.font20,
                              color: AppTheme.blackcolor),
                        ),
                        SizedBox(
                          height: AddSize.size15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: AddSize.size80 * 2.1,
                                width: AddSize.size80 * 2.1,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(AppAssets.driverimage2),
                                        fit: BoxFit.cover)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: AddSize.size80,
                                      ),
                                      Text(
                                        deliveryOrderListController
                                            .model.value.data!.deliveredOrders
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                color: AppTheme.primaryColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 30),
                                      ),
                                      Text(
                                        "Delivered".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                color: AppTheme.blackcolor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: AddSize.font14),
                                      ),
                                      SizedBox(
                                        height: AddSize.size10,
                                      ),
                                    ],
                                  ),
                                )),
                            Stack(
                              children: [
                                Container(
                                    height: AddSize.size80 * 2.1,
                                    width: AddSize.size80 * 2.1,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                AppAssets.driverimage1),
                                            fit: BoxFit.cover)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: AddSize.size80,
                                          ),
                                          Text(
                                            deliveryOrderListController
                                                .model.value.data!.earningBalance
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    color:
                                                        const Color(0xffFF980E),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 30),
                                          ),
                                          Text(
                                            "Balance".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    color: AppTheme.blackcolor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AddSize.font14),
                                          ),
                                          SizedBox(
                                            height: AddSize.size10,
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Text(
                          "New Delivery Request".tr,
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AddSize.font16,
                              color: AppTheme.blackcolor),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Obx(() {
                          return deliveryOrderListController
                                  .model.value.data!.list!.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: deliveryOrderListController
                                      .model.value.data!.list!.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    var item = deliveryOrderListController
                                        .model.value.data!.list![index];
                                    return GestureDetector(
                                      onTap: () {
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AddSize.padding10,
                                          ),
                                          margin: EdgeInsets.only(
                                              top: AddSize.padding10),
                                          decoration: BoxDecoration(
                                              color: AppTheme.backgroundcolor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child:
                                          Column(
                                            children: [

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  Text(
                                                    "${item.vendorLocation!.storeName.toString()}",
                                                    style: GoogleFonts.ibmPlexSansArabic(
                                                        color:Color(0xff3E525A),
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: AddSize
                                                            .font18),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: AddSize.size10,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "KM",
                                                    style: GoogleFonts.ibmPlexSansArabic(
                                                        color:Color(0xff3E525A),
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                        fontSize: AddSize
                                                            .font16),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${item.distance.toString()}",
                                                      style: GoogleFonts.ibmPlexSansArabic(
                                                          color:Color(0xff3E525A),
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                          fontSize: AddSize
                                                              .font18),
                                                    ),
                                                  ),

                                                  Text(
                                                    "${item.orderItem![0].qty.toString()} x ${item.orderItem![0].productName.toString()}",
                                                    style: GoogleFonts.ibmPlexSansArabic(
                                                        color:Color(0xff3E525A),
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                        fontSize: AddSize
                                                            .font14),
                                                  ),
                                                ],
                                              ),
                                              deliveryOrderListController
                                                  .model.value.data!.acceptedOrderDetail == null ?
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        acceptOrder(
                                                                orderId:
                                                                    item.orderId,
                                                                status: "accept",
                                                                context: context)
                                                            .then((value) {
                                                          if (value.status ==
                                                              true) {
                                                            deliveryOrderListController
                                                                .getData();
                                                            // assignedController
                                                            //     .getData();
                                                            // Get.toNamed(
                                                            //     AssignedOrder
                                                            //         .assignedOrder);
                                                          }
                                                        });
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        minimumSize: Size(
                                                            AddSize.size50,
                                                            AddSize.size20 * 1.8),
                                                        primary:
                                                            AppTheme.primaryColor,
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                      ),
                                                      child: Text(
                                                        "Accept".tr.toUpperCase(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                color: AppTheme
                                                                    .backgroundcolor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: AddSize
                                                                    .font14),
                                                      )),
                                                  SizedBox(
                                                    width: AddSize.size20,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        acceptOrder(
                                                                orderId:
                                                                    item.orderId,
                                                                status: "decline",
                                                                context: context)
                                                            .then((value) {
                                                          if (value.status ==
                                                              true) {
                                                            // assignedController
                                                            //     .getData();
                                                            // Get.offAndToNamed(
                                                            //     OrderDeclineScreen
                                                            //         .orderDeclineScreen);
                                                          }
                                                        });
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        minimumSize: Size(
                                                            AddSize.size50,
                                                            AddSize.size20 * 1.8),
                                                        primary: const Color(
                                                            0xffF04148),
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                      ),
                                                      child: Text(
                                                        "Decline".tr.toUpperCase(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                color: AppTheme
                                                                    .backgroundcolor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: AddSize
                                                                    .font14),
                                                      )),
                                                ],
                                              ):Text("Order Accepted"),

                                              SizedBox(
                                                height: AddSize.size10,
                                              ),
                                              if(deliveryOrderListController
                                                  .model.value.data!.acceptedOrderDetail != null)
                                                Text("hello vendor"),
                                            ],
                                          )),
                                    );
                                  },
                                )
                              : deliveryOrderListController
                              .model.value.data!.acceptedOrderDetail == null ?
                          Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding20 * 2.8,
                                      vertical: AddSize.padding20),
                                  child: SizedBox(
                                      height: AddSize.size20,
                                      child: Text(
                                        "Delivery Request Not Available".tr,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                color: AppTheme.blackcolor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: AddSize.font16),
                                      )),
                                ): SizedBox();
                        }),
                        //after accepting the order data
                        if(deliveryOrderListController
                            .model.value.data!.acceptedOrderDetail != null)
                          Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AddSize.padding10,
                              ),
                              margin: EdgeInsets.only(
                                  top: AddSize.padding10),
                              decoration: BoxDecoration(
                                  color: AppTheme.backgroundcolor,
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              child:
                              Column(
                                children: [
                                  SizedBox(height: 5,),

                                  Row(

                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${deliveryOrderListController
                                              .model.value.data!.acceptedOrderDetail!.placedAt.toString()}",
                                          style: GoogleFonts.ibmPlexSansArabic(
                                              color:Color(0xff303C5E),
                                              fontWeight:
                                              FontWeight
                                                  .w400,
                                              fontSize: AddSize
                                                  .font12),
                                        ),
                                      ),

                                      Text(
                                        "#${deliveryOrderListController
                                            .model.value.data!.acceptedOrderDetail!.orderId.toString()}",
                                        style: GoogleFonts.ibmPlexSansArabic(
                                            color:AppTheme.primaryColor,
                                            fontWeight:
                                            FontWeight
                                                .w500,
                                            fontSize: AddSize
                                                .font18),
                                      ),
                                      SizedBox(
                                        width: AddSize.size15,
                                      ),
                                      ImageIcon(
                                        AssetImage(
                                            AppAssets.orderList),
                                        color: AppTheme.primaryColor,
                                        size: 20,
                                      ),




                                    ],
                                  ),
                                  SizedBox(
                                    height: AddSize.size10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                      Text(
                                        "${deliveryOrderListController
                                            .model.value.data!.acceptedOrderDetail!.orderItems![0].qty.toString()} x ${deliveryOrderListController
                                            .model.value.data!.acceptedOrderDetail!.orderItems![0].productName.toString()}",
                                        style: GoogleFonts.ibmPlexSansArabic(
                                            color:Color(0xff8B8B8B),
                                            fontWeight:
                                            FontWeight
                                                .w500,
                                            fontSize: AddSize
                                                .font14),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: 40,
                                            width: 40,

                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,

                                            ),
                                            child: Image(image: AssetImage(
                                                AppAssets.DeliverdIcon),)
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${deliveryOrderListController.model.value.data!.acceptedOrderDetail!.vendor!.storeName.toString()}",
                                              style: GoogleFonts.ibmPlexSansArabic(
                                                  color:Color(0xff303C5E),
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  fontSize: AddSize
                                                      .font16),
                                            ),
                                            Text(
                                              "${deliveryOrderListController.model.value.data!.acceptedOrderDetail!.vendor!.phone.toString()}",
                                              style: GoogleFonts.ibmPlexSansArabic(
                                                  color:Color(0xff3E525A),
                                                  fontWeight:
                                                  FontWeight
                                                      .w400,
                                                  fontSize: AddSize
                                                      .font14),
                                            ),
                                          ],
                                        ),
                                      ],
                                      ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 40,
                                          width: 40,

                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,

                                          ),
                                          child: Image(image: AssetImage(
                                              AppAssets.DeliverdIcon),)
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${deliveryOrderListController.model.value.data!.acceptedOrderDetail!.user!.name.toString()}",
                                            style: GoogleFonts.ibmPlexSansArabic(
                                                color:Color(0xff303C5E),
                                                fontWeight:
                                                FontWeight
                                                    .w500,
                                                fontSize: AddSize
                                                    .font16),
                                          ),
                                          Text(
                                            "${deliveryOrderListController.model.value.data!.acceptedOrderDetail!.address?.note.toString()}",
                                            style: GoogleFonts.ibmPlexSansArabic(
                                                color:Color(0xff3E525A),
                                                fontWeight:
                                                FontWeight
                                                    .w400,
                                                fontSize: AddSize
                                                    .font14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Obx(() {
                                    return image.value.path == ""
                                        ? Stack(
                                      children: [
                                        SizedBox(
                                          height: AddSize.size125,
                                          width: AddSize.screenWidth,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(2),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              deliveryOrderListController
                                                  .model
                                                  .value
                                                  .data!
                                                  .acceptedOrderDetail!.address!.image
                                                  .toString(),
                                              errorWidget: (_, __, ___) =>
                                              const SizedBox(),
                                              placeholder: (_, __) =>
                                              const SizedBox(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                        : Container(
                                      width: double.maxFinite,
                                      height: AddSize.size100,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AddSize.padding16,
                                          vertical: AddSize.padding16),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: SizedBox(
                                        height: AddSize.size125,
                                        width: AddSize.screenWidth,
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            child: Image.file(image.value)),
                                      ),
                                    );
                                  }),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        orderDeliveryRepo(
                                            orderId: deliveryOrderListController.model.value.data!.acceptedOrderDetail!.orderId.toString(),
                                            status: "delivered",
                                            context: context)
                                            .then((value) {
                                          showToast(value.message.toString());
                                          if (value.status == true) {
                                            Get.offAndToNamed(DeliveredSuccessfullyScreen
                                                .deliveredSuccessfullyScreen);
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: AppTheme.primaryColor,
                                          minimumSize: const Size(double.maxFinite, 60),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)),
                                          textStyle: GoogleFonts.ibmPlexSansArabic(
                                              fontSize: 18, fontWeight: FontWeight.w600)),
                                      child:  Text(
                                        "Mark Completed".tr,
                                      )),

                                  SizedBox(
                                    height: AddSize.size10,
                                  ),
                                ],
                              )),
                      ],
                    ),
                  ))
              : const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
