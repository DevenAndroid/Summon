

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

class DeliveredOrderHistory extends StatefulWidget {
  const DeliveredOrderHistory({Key? key}) : super(key: key);
  static var orderDeliveryHistory = "/orderDeliveryHistory";
  @override
  State<DeliveredOrderHistory> createState() => _DeliveredOrderHistoryState();
}

class _DeliveredOrderHistoryState extends State<DeliveredOrderHistory> {
  final RxBool _store = false.obs;
  final controller = Get.put(MainHomeController());
  final orderHistoryController = Get.put(AssignedOrderController());
  Rx<File> image = File("").obs;
  @override
  void initState() {
    super.initState();
    orderHistoryController.getData();
  }
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
            "History".tr,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppTheme.blackcolor),
          ),
          leading: Padding(
            padding: EdgeInsets.all(08.0),
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
                      value: orderHistoryController.isDataLoading.value
                          ? (orderHistoryController.model.value.data!.deliveryMode ??  false)
                          : _store.value,
                      onToggle: (val) {
                        deliveryModeUpdateRepo().then((value) {
                          if (value.status == true) {
                            orderHistoryController.getData();
                            print(val);
                            orderHistoryController.model.value.data!.deliveryMode = val;
                            if (orderHistoryController.model.value.data!.deliveryMode == true)
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
          return orderHistoryController.isDataLoading.value
              ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AddSize.padding16,
                    vertical: AddSize.padding10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Obx(() {
                      return orderHistoryController
                          .model.value.data!.orderDetails!.isNotEmpty
                          ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderHistoryController
                            .model.value.data!.orderDetails!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var item = orderHistoryController
                              .model.value.data!.orderDetails![index];
                          return GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding10,vertical: 20
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
                                        Text(
                                          "SR",
                                          style: GoogleFonts.ibmPlexSansArabic(
                                              color:AppTheme.primaryColor,
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              fontSize: AddSize
                                                  .font16),
                                        ),
                                        SizedBox(width: 5,),
                                        Expanded(
                                          child: Text(
                                            "${item.grandTotal.toString()}",
                                            style: GoogleFonts.ibmPlexSansArabic(
                                                color:AppTheme.primaryColor,
                                                fontWeight:
                                                FontWeight
                                                    .w600,
                                                fontSize: AddSize
                                                    .font16),
                                          ),
                                        ),
                                        // SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [

                                            Text(
                                              "${item.vendor!.storeName.toString()}",
                                              style: GoogleFonts.ibmPlexSansArabic(
                                                  color:Color(0xff303C5E),
                                                  fontWeight:
                                                  FontWeight
                                                      .w600,
                                                  fontSize: AddSize
                                                      .font16),
                                            ),
                                            Row(
                                              children: [

                                                Text(
                                                  "${item.placedAt.toString()}",
                                                  style: GoogleFonts.ibmPlexSansArabic(
                                                      color:Color(0xff3E525A),
                                                      fontWeight:
                                                      FontWeight
                                                          .w400,
                                                      fontSize: AddSize
                                                          .font14),
                                                ),
                                                SizedBox(width: 5,),
                                                Text(
                                                  "#${item.orderId.toString()}",
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
                                        Expanded(
                                          child: ImageIcon(
                                            AssetImage(
                                                AppAssets.orderList),
                                            color: AppTheme.primaryColor,
                                            size: 20,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                )),
                          );
                        },
                      )

                      :SizedBox(
                          height: AddSize.size20,
                          child: Center(
                            child: Text(
                              "Order Not Available".tr,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                  color: AppTheme.blackcolor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AddSize.font16),
                            ),
                          ));
                    }),
                    //after accepting the order data
                  ],
                ),
              ))
              : const Center(child: CircularProgressIndicator(
            color: AppTheme.primaryColor,
          ));
        }),
      ),
    );
  }
}
