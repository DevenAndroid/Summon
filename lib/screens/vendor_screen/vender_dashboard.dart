import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/main_home_controller.dart';
import 'package:fresh2_arrive/repositories/selfDeliveryStatusUpdate_repo.dart';
import 'package:fresh2_arrive/screens/vendor_screen/store_open_time_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_orderList.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../controller/VendorDashboard_Controller.dart';
import '../../controller/profile_controller.dart';
import '../../repositories/storeupdate_status_repo.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import 'package:flutter_switch/flutter_switch.dart';


class VenderDashboard extends StatefulWidget {
  const VenderDashboard({Key? key}) : super(key: key);
  static var vendorDashboard = "/vendorDashboard";
  @override
  State<VenderDashboard> createState() => _VenderDashboardState();
}

class _VenderDashboardState extends State<VenderDashboard> {
  final profileController = Get.put(ProfileController());
  final vendorDashboardController = Get.put(VendorDashboardController());
  final controller = Get.put(MainHomeController());
  final RxBool _store = true.obs;
  final RxBool _selfDelivery = true.obs;

  @override
  void initState() {
    super.initState();
    vendorDashboardController.getVendorDashboardData();
  }
  DateTime? time;
  DateTime? time1;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(vendorDashboardController.isDataLoading.value){
        try {
          time = intl.DateFormat("hh:mm a").parse(vendorDashboardController.model.value.data!.startTime);
        } catch(e){
          time = intl.DateFormat("hh:mm").parse(vendorDashboardController.model.value.data!.startTime);
        }

        try {
          time1 = intl.DateFormat("hh:mm a").parse(vendorDashboardController.model.value.data!.endTime);
        } catch(e){
          time1 = intl.DateFormat("hh:mm").parse(vendorDashboardController.model.value.data!.endTime);
        }
      }
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(

              elevation: 0,
              leadingWidth: AddSize.size20 * 1.8,
              backgroundColor: AppTheme.backgroundcolor,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, ${profileController.isDataLoading.value ? (profileController.model.value.data!.name ?? "").toString() : ""}",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w500, fontSize: AddSize.font16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(SetTimeScreen.setTimeScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Store Time: ",
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AddSize.font14,
                              color: Colors.grey),
                        ),
                        vendorDashboardController.isDataLoading.value ? vendorDashboardController.model.value.data!.storeStatus == 1
                            ?
                        Text(
                                "${vendorDashboardController.isDataLoading.value ? (intl.DateFormat("hh:mm a").format(time!) ?? "").toString() : ""} to ${vendorDashboardController.isDataLoading.value ? (intl.DateFormat("hh:mm a").format(time1!) ?? "").toString() : ""}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: AddSize.font12,
                                        color: AppTheme.primaryColor),
                              )
                            : Text(
                                "Closed",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: AddSize.font12,
                                        color: AppTheme.primaryColor),
                              ):SizedBox(),
                        SizedBox(
                          width: AddSize.size5,
                        ),
                        Icon(
                          Icons.edit,
                          color: AppTheme.primaryColor,
                          size: AddSize.size15,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              leading: Padding(
                padding: EdgeInsets.only(right: AddSize.padding10),
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      AppAssets.back,
                      height: AddSize.size15,
                    )),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AddSize.padding10,
                  ),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Container(
                            height: AddSize.size45,
                            width: AddSize.size45,
                            clipBehavior: Clip.antiAlias,
                            // margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey.shade400)
                                // color: Colors.brown
                                ),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: profileController.isDataLoading.value
                                  ? profileController
                                      .model.value.data!.profileImage!
                                  : '',
                              height: AddSize.size30,
                              width: AddSize.size30,
                              errorWidget: (_, __, ___) => const SizedBox(),
                              placeholder: (_, __) => const SizedBox(),
                            )),
                      ),
                      Positioned(
                          top: 10,
                          left: 05,
                          child: Container(
                            height: 10,
                            width: 10,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: profileController.isDataLoading.value
                                  ? profileController
                                              .model.value.data!.isVendorOnline ==
                                          true
                                      ? AppTheme.userActive
                                      : Colors.red
                                  : null,
                              border: Border.all(
                                  color: AppTheme.backgroundcolor, width: 1),
                              borderRadius: BorderRadius.circular(50),
                              // color: Colors.brown
                            ),
                          ))
                    ],
                  ),
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
            body: vendorDashboardController.isDataLoading.value
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding10),
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: AddSize.padding10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "This Month Report",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: AddSize.font16),
                                )
                              ],
                            ),
                          ),
                        ),
                        SliverGrid.count(
                            crossAxisSpacing: AddSize.size12,
                            mainAxisSpacing: AddSize.size12,
                            crossAxisCount: 2,
                            childAspectRatio: AddSize.size15 / AddSize.size12,
                            children: List.generate(
                              4,
                              (index) => Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16,
                                    vertical: AddSize.padding16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppTheme.backgroundcolor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: AddSize.size40,
                                          width: AddSize.size40,
                                          decoration: ShapeDecoration(
                                              color: index == 0
                                                  ? Colors.green.shade600
                                                  : index == 1
                                                      ? Colors.orange
                                                      : index == 2
                                                          ? AppTheme.primaryColor
                                                          : Colors.cyan,
                                              shape: const CircleBorder()),
                                          child: Center(
                                              child: Image(
                                                  height: AddSize.size25,
                                                  width: AddSize.size25,
                                                  image: const AssetImage(
                                                      AppAssets
                                                          .vendorDashboard))),
                                        ),
                                        SizedBox(width: 5,),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 15),
                                                  child: Text(
                                                    index == 0
                                                        ? "${vendorDashboardController.model.value.data!.grossSalesPercent.toString()} %"
                                                        : index == 1
                                                            ? "${vendorDashboardController.model.value.data!.earningPercent.toString()} %"
                                                            : index == 2
                                                                ? "${vendorDashboardController.model.value.data!.soldItemsPercent.toString()} %"
                                                                : "${vendorDashboardController.model.value.data!.orderReceivedPercent.toString()} %",
                                                    //"10%",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            height: 1.5,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                AddSize.font14,
                                                            color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                              // vendorDashboardController
                                              //             .model
                                              //             .value
                                              //             .data!
                                              //             .grossSalesPercent!.

                                              Icon(
                                                Icons.arrow_upward_sharp,
                                                color: Colors.green,
                                                size: AddSize.size15,
                                              )
                                              // : Icon(
                                              //     Icons.arrow_downward,
                                              //     color: Colors.red,
                                              //     size: AddSize.size15,
                                              //   )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: AddSize.size10,
                                    ),
                                    Text(
                                      index == 0
                                          ? vendorDashboardController
                                              .model.value.data!.grossSales
                                              .toString()
                                          : index == 1
                                              ? vendorDashboardController
                                                  .model.value.data!.earning
                                                  .toString()
                                              : index == 2
                                                  ? vendorDashboardController
                                                      .model.value.data!.soldItems
                                                      .toString()
                                                  : vendorDashboardController
                                                      .model
                                                      .value
                                                      .data!
                                                      .orderReceived
                                                      .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              height: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font20,
                                              color: AppTheme.blackcolor),
                                    ),
                                    Text(
                                      index == 0
                                          ? "Gross Sales"
                                          : index == 1
                                              ? "Earning"
                                              : index == 2
                                                  ? "Sold items"
                                                  : "Order Received",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              height: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font12,
                                              color: AppTheme.subText),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(
                                height: AddSize.size10,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.backgroundcolor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: AddSize.padding16,
                                              vertical: AddSize.padding10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Store",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: AddSize.font14),
                                              ),
                                              SizedBox(
                                                width: AddSize.size20 * 1.5,
                                              ),
                                              FlutterSwitch(

                                                width: AddSize.size30 * 2.2,
                                                height: AddSize.size20 * 1.4,
                                                valueFontSize: AddSize.font12,
                                                activeTextFontWeight:
                                                    FontWeight.w600,
                                                inactiveText: "OFF   ",
                                                activeText: "On",
                                                inactiveTextColor:
                                                    AppTheme.backgroundcolor,
                                                activeTextColor:
                                                    AppTheme.backgroundcolor,
                                                inactiveTextFontWeight:
                                                    FontWeight.w600,
                                                inactiveColor:
                                                    Colors.grey.shade400,
                                                activeColor:
                                                    AppTheme.primaryColor,
                                                value: vendorDashboardController
                                                    .model.value.data!.store!,
                                                borderRadius: 30.0,
                                                showOnOff: true,
                                                onToggle: (val) {
                                                  setState(() {
                                                    vendorDashboardController
                                                        .model
                                                        .value
                                                        .data!
                                                        .store = val;
                                                    print(val);
                                                    storeUpdateStatusRepo()
                                                        .then((value) {
                                                      if (value.status == true) {
                                                        if (val == true) {
                                                          showToast(
                                                              "Store is ON");
                                                        } else {
                                                          showToast(
                                                              "Store is OFF");
                                                        }
                                                      }
                                                    });
                                                  });
                                                },
                                              ),
                                            ],
                                          )),
                                    ),
                                    Container(
                                      height: AddSize.size80,
                                      decoration: BoxDecoration(
                                          color: AppTheme.backgroundcolor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: AddSize.padding16,
                                              vertical: AddSize.padding10),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Self\ndelivery",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: AddSize.font14),
                                              ),
                                              SizedBox(
                                                width: AddSize.size20,
                                              ),
                                              FlutterSwitch(
                                                width: AddSize.size30 * 2.2,
                                                height: AddSize.size20 * 1.4,
                                                valueFontSize: AddSize.font12,
                                                activeTextFontWeight:
                                                    FontWeight.w600,
                                                activeTextColor:
                                                    AppTheme.backgroundcolor,
                                                value: vendorDashboardController
                                                    .model
                                                    .value
                                                    .data!
                                                    .selfDelivery!,
                                                inactiveText: " OFF",
                                                activeText: "  On",
                                                inactiveColor:
                                                    Colors.grey.shade400,
                                                inactiveTextFontWeight:
                                                    FontWeight.w600,
                                                inactiveTextColor:
                                                    AppTheme.backgroundcolor,
                                                activeColor:
                                                    AppTheme.primaryColor,
                                                borderRadius: 30.0,
                                                showOnOff: true,
                                                onToggle: (val) {
                                                  setState(() {
                                                    vendorDashboardController
                                                        .model
                                                        .value
                                                        .data!
                                                        .selfDelivery = val;
                                                    print(val);
                                                    selfDeliveryUpdateStatusRepo()
                                                        .then((value) {
                                                      if (value.status == true) {
                                                        if (val == true) {
                                                          showToast(
                                                              "self delivery is ON");
                                                        } else {
                                                          showToast(
                                                              "self delivery is OFF");
                                                        }
                                                      }
                                                    });
                                                  });
                                                },
                                              ),
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(
                                height: AddSize.size12,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppTheme.backgroundcolor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding16,
                                      vertical: AddSize.padding10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Latest Sales",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AddSize.font16),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Get.toNamed(VendorOrderList
                                                    .vendorOrderList);
                                              },
                                              child: Text(
                                                "See All",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                        decoration: TextDecoration
                                                            .underline,
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppTheme.primaryColor,
                                                        fontSize: AddSize.font16),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Order No.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AddSize.font14,
                                                    color:
                                                        const Color(0xff52AC1A)),
                                          ),
                                          Text(
                                            "                      Status",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AddSize.font14,
                                                    color:
                                                        const Color(0xff52AC1A)),
                                          ),
                                          Text(
                                            "Earning",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AddSize.font14,
                                                    color:
                                                        const Color(0xff52AC1A)),
                                          )
                                        ],
                                      ),
                                      const Divider(),
                                      vendorDashboardController.model.value.data!
                                              .orderList!.isNotEmpty
                                          ? ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: vendorDashboardController
                                                  .model
                                                  .value
                                                  .data!
                                                  .orderList!
                                                  .length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return Column(
                                                  children: [
                                                    SizedBox(
                                                      height: AddSize.size5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "#${vendorDashboardController.model.value.data!.orderList![index].id.toString()}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5!
                                                                  .copyWith(
                                                                      height: 1.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          AddSize
                                                                              .font14),
                                                            ),
                                                            Text(
                                                              vendorDashboardController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .orderList![
                                                                      index]
                                                                  .date
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5!
                                                                  .copyWith(
                                                                      height: 1.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          AddSize
                                                                              .font12,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          vendorDashboardController
                                                              .model
                                                              .value
                                                              .data!
                                                              .orderList![index]
                                                              .status
                                                              .toString(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline5!
                                                              .copyWith(
                                                                  height: 1.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      AddSize
                                                                          .font14,
                                                                  color: Colors
                                                                      .orange
                                                                      .shade200),
                                                        ),
                                                        Text(
                                                          "₹${vendorDashboardController.model.value.data!.orderList![index].amount.toString()}",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline5!
                                                              .copyWith(
                                                                  height: 1.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      AddSize
                                                                          .font14,
                                                                  color: AppTheme
                                                                      .blackcolor),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: AddSize.size5,
                                                    ),
                                                    const Divider(),
                                                  ],
                                                );
                                              },
                                            )
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      AddSize.padding20 * 3),
                                              child: Text("Order not Available",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                          height: 1.5,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              AddSize.font14,
                                                          color: AppTheme
                                                              .blackcolor)),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator())),
      );
    });
  }
}
