import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fresh2_arrive/screens/driver_screen/assigned_order.dart';
import 'package:fresh2_arrive/screens/driver_screen/delivered_successfully.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_delivery_details.dart';
import 'package:fresh2_arrive/screens/driver_screen/order_decline_screen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/MyOrder_Details_Controller.dart';
import '../../controller/assigned_order_list_controller.dart';
import '../../controller/delivery_order_list_controller.dart';
import '../../controller/main_home_controller.dart';
import '../../repositories/accept_order_by_driver.dart';
import '../../repositories/driver_mode_update_repo.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/dimensions.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.backgroundcolor,
        leadingWidth: AddSize.size20 * 1.6,
        title: Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: AppTheme.blackcolor),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: AddSize.padding10),
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
                    "Delivery Mode",
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
                        ? deliveryOrderListController.model.value.data!.deliveryMode
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
                      Text(DateFormat("EEEE, dd MMM, yyyy").format(DateTime.now()).toString(),
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: AddSize.font14,
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
                                      "Delivered",
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
                                              .model.value.data!.pendingOrders
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
                                          "Pending",
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
                        "New Delivery Request",
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
                                      // orderController.id.value =
                                      //     item.orderId.toString();
                                      // Get.toNamed(DriverDeliveryOrderDetails
                                      //     .driverDeliveryOrderDetails);
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
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      // Get.toNamed(MyRouter.editProfileScreen);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize: Size(
                                                          AddSize.size50,
                                                          AddSize.size25),
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
                                                      item.paymentMethod
                                                          .toString(),
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
                                                                  .font12),
                                                    )),
                                                SizedBox(
                                                  width: AddSize.size10,
                                                ),
                                                Text(
                                                  "\$${item.orderTotal.toString()}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                          color: AppTheme
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              AddSize.font14),
                                                )
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.date_range,
                                                  color: AppTheme.primaryColor,
                                                ),
                                                SizedBox(
                                                  width: AddSize.size15,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Date and time:",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              color: AppTheme
                                                                  .blackcolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: AddSize
                                                                  .font14),
                                                    ),
                                                    Text(
                                                      item.date.toString(),
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
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: AddSize.size10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image(
                                                  image: const AssetImage(
                                                      AppAssets.orderList),
                                                  height: AddSize.size20,
                                                  width: AddSize.size20,
                                                ),
                                                SizedBox(
                                                  width: AddSize.size15,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Order ID:",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              color: AppTheme
                                                                  .blackcolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: AddSize
                                                                  .font14),
                                                    ),
                                                    Text(
                                                      "#${item.orderId.toString()}",
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
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: AddSize.size10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.location_on_outlined,
                                                  color: AppTheme.primaryColor,
                                                ),
                                                SizedBox(
                                                  width: AddSize.size15,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Location:",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                color: AppTheme
                                                                    .blackcolor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: AddSize
                                                                    .font14),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              // "",
                                                              "${item.location!.location??""}, ${item.location!.flatNo??""}, ${item.location!.street??""},",
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
                                                                      fontSize:
                                                                          AddSize
                                                                              .font14),
                                                            ),
                                                          ),
                                                          Container(
                                                            height:
                                                                AddSize.size40,
                                                            width:
                                                                AddSize.size40,
                                                            decoration: const ShapeDecoration(
                                                                color: AppTheme
                                                                    .newprimaryColor,
                                                                shape:
                                                                    CircleBorder()),
                                                            child: Icon(
                                                              Icons
                                                                  .gps_fixed_outlined,
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              size: AddSize
                                                                  .size20,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: AddSize.size10,
                                            ),
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
                                                          assignedController
                                                              .getData();
                                                          Get.toNamed(
                                                              AssignedOrder
                                                                  .assignedOrder);
                                                        }
                                                      });
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize: Size(
                                                          AddSize.size50,
                                                          AddSize.size20 * 1.8),
                                                      primary:
                                                          AppTheme.userActive,
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                    ),
                                                    child: Text(
                                                      "Accept".toUpperCase(),
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
                                                          assignedController
                                                              .getData();
                                                          Get.offAndToNamed(
                                                              OrderDeclineScreen
                                                                  .orderDeclineScreen);
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
                                                      "Decline".toUpperCase(),
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
                                            ),
                                            SizedBox(
                                              height: AddSize.size10,
                                            )
                                          ],
                                        )),
                                  );
                                },
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding20 * 2.8,
                                    vertical: AddSize.padding20),
                                child: SizedBox(
                                    height: AddSize.size20,
                                    child: Text(
                                      "Delivery Request Not Available",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              color: AppTheme.blackcolor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font16),
                                    )),
                              );
                      })
                    ],
                  ),
                ))
            : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
