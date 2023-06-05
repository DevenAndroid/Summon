// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:fresh2_arrive/screens/driver_screen/verify_delivery_otp_screen.dart';
// import 'package:fresh2_arrive/widgets/add_text.dart';
// import 'package:get/get.dart';
// import '../../controller/MyOrder_Details_Controller.dart';
// import '../../controller/assigned_order_list_controller.dart';
// import '../../controller/delivery_order_list_controller.dart';
// import '../../controller/main_home_controller.dart';
// import '../../model/time_model.dart';
// import '../../repositories/driver_mode_update_repo.dart';
// import '../../repositories/driver_status_update_repo.dart';
// import '../../resources/app_assets.dart';
// import '../../resources/app_theme.dart';
// import '../../widgets/dimensions.dart';
// import 'driver_delivery_details.dart';
//
// class AssignedOrder extends StatefulWidget {
//   const AssignedOrder({Key? key}) : super(key: key);
//   static var assignedOrder = "/assignedOrder";
//
//   @override
//   State<AssignedOrder> createState() => _AssignedOrderState();
// }
//
// class _AssignedOrderState extends State<AssignedOrder> {
//   final RxBool _store = false.obs;
//   final RxBool _isValue = false.obs;
//   final orderController = Get.put(MyOrderDetailsController());
//   final controller = Get.put(MainHomeController());
//   final assignedController = Get.put(AssignedOrderController());
//   final deliveryOrderListController = Get.put(DeliveryOrderListController());
//   String? selectedTime;
//   final List<String> dropDownTimeList = ["Pending", "Completed", "Decline"];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     assignedController.getData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: AppTheme.backgroundcolor,
//           leadingWidth: AddSize.size20 * 1.6,
//           title: Text(
//             "Assigned Order",
//             style: Theme.of(context).textTheme.headline6!.copyWith(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20,
//                 color: AppTheme.blackcolor),
//           ),
//           leading: Padding(
//             padding: EdgeInsets.only(right: AddSize.padding10),
//             child: GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: Image.asset(
//                   AppAssets.back,
//                 )),
//           ),
//           actions: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: AddSize.padding20,
//               ),
//               child: Obx(() {
//                 return Row(
//                   children: [
//                     Text(
//                       "Delivery Mode",
//                       style: Theme.of(context).textTheme.headline6!.copyWith(
//                           fontWeight: FontWeight.w500,
//                           fontSize: AddSize.font14,
//                           color: AppTheme.blackcolor),
//                     ),
//                     SizedBox(width: AddSize.size10),
//                     // FlutterSwitch(
//                     //   height: AddSize.size20,
//                     //   width: AddSize.size40,
//                     //   activeColor: AppTheme.primaryColor,
//                     //   toggleSize: AddSize.size5 * 2.5,
//                     //   value: deliveryOrderListController.isDataLoading.value
//                     //       ? deliveryOrderListController
//                     //           .model.value.data!.deliveryMode
//                     //       : _store.value,
//                     //   onToggle: (val) {
//                     //     deliveryModeUpdateRepo().then((value) {
//                     //       if (value.status == true) {
//                     //         deliveryOrderListController.getData();
//                     //         print(val);
//                     //         deliveryOrderListController
//                     //             .model.value.data!.deliveryMode = val;
//                     //         if (deliveryOrderListController
//                     //                 .model.value.data!.deliveryMode ==
//                     //             true) {
//                     //           showToast("Delivery mode on");
//                     //         } else {
//                     //           showToast("Delivery mode off");
//                     //         }
//                     //       }
//                     //     });
//                     //   },
//                     // )
//                   ],
//                 );
//               }),
//             )
//           ],
//           bottom: !controller.internetConnection.value
//               ? PreferredSize(
//                   preferredSize: const Size(double.maxFinite, 22),
//                   child: Container(
//                       color: Colors.red,
//                       alignment: Alignment.center,
//                       child: const Text(
//                         "No Internet Action",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       )),
//                 )
//               : null,
//         ),
//         body: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: AddSize.padding16, vertical: AddSize.padding10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Assigned Delivery",
//                         style: Theme.of(context).textTheme.headline6!.copyWith(
//                             fontWeight: FontWeight.w500,
//                             fontSize: AddSize.font16,
//                             color: AppTheme.blackcolor),
//                       ),
//                       const Spacer(),
//                       Expanded(
//                         child: Directionality(
//                           textDirection: TextDirection.ltr,
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: AddSize.padding10,
//                             ),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(0.0),
//                                 border: Border.all(color: Colors.grey.shade300),
//                                 color: AppTheme.backgroundcolor),
//                             child: DropdownButtonFormField(
//                               decoration: const InputDecoration(
//                                   enabled: true, border: InputBorder.none),
//                               isExpanded: true,
//                               hint: Text(
//                                 'All orders',
//                                 style: TextStyle(
//                                     color: AppTheme.lightblack,
//                                     fontSize: AddSize.font12,
//                                     fontWeight: FontWeight.w500),
//                                 textAlign: TextAlign.start,
//                               ),
//                               value: selectedTime == "" ? null : selectedTime,
//                               items: status1.map((value) {
//                                 return DropdownMenuItem(
//                                   value: value.key.toString(),
//                                   child: Text(
//                                     value.value,
//                                     style: TextStyle(
//                                       fontSize: AddSize.font14,
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   selectedTime = newValue as String?;
//                                   assignedController.status.value = newValue!;
//                                   print(assignedController.status.value);
//                                   assignedController.getData();
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: AddSize.size10,
//                   ),
//                   Obx(() {
//                     return assignedController.isDataLoading.value
//                         ? assignedController.model.value.data!.isNotEmpty
//                             ? ListView.builder(
//                                 physics: const BouncingScrollPhysics(),
//                                 itemCount:
//                                     assignedController.model.value.data!.length,
//                                 shrinkWrap: true,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       orderController.id.value =
//                                           assignedController
//                                               .model.value.data![index].orderId
//                                               .toString();
//                                       Get.toNamed(DriverDeliveryOrderDetails
//                                           .driverDeliveryOrderDetails);
//                                     },
//                                     child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: AddSize.padding10,
//                                         ),
//                                         margin: EdgeInsets.only(
//                                             top: AddSize.padding10),
//                                         decoration: BoxDecoration(
//                                             color: AppTheme.backgroundcolor,
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,
//                                               children: [
//                                                 ElevatedButton(
//                                                     onPressed: () {
//                                                       // Get.toNamed(MyRouter.editProfileScreen);
//                                                     },
//                                                     style:
//                                                         ElevatedButton.styleFrom(
//                                                       minimumSize: Size(
//                                                           AddSize.size50,
//                                                           AddSize.size25),
//                                                       primary:
//                                                           AppTheme.primaryColor,
//                                                       elevation: 0,
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           6)),
//                                                     ),
//                                                     child: Text(
//                                                       assignedController
//                                                           .model
//                                                           .value
//                                                           .data![index]
//                                                           .paymentMethod
//                                                           .toString(),
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .headline5!
//                                                           .copyWith(
//                                                               color: AppTheme
//                                                                   .backgroundcolor,
//                                                               fontWeight:
//                                                                   FontWeight.w500,
//                                                               fontSize:
//                                                                   AddSize.font12),
//                                                     )),
//                                                 SizedBox(
//                                                   width: AddSize.size10,
//                                                 ),
//                                                 Text(
//                                                   "₹${assignedController.model.value.data![index].orderTotal.toString()}",
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .headline5!
//                                                       .copyWith(
//                                                           color: AppTheme
//                                                               .primaryColor,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                           fontSize:
//                                                               AddSize.font14),
//                                                 )
//                                               ],
//                                             ),
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 const Icon(
//                                                   Icons.date_range,
//                                                   color: AppTheme.primaryColor,
//                                                 ),
//                                                 SizedBox(
//                                                   width: AddSize.size15,
//                                                 ),
//                                                 Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       "Date:",
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .headline5!
//                                                           .copyWith(
//                                                               color: AppTheme
//                                                                   .blackcolor,
//                                                               fontWeight:
//                                                                   FontWeight.w500,
//                                                               fontSize:
//                                                                   AddSize.font14),
//                                                     ),
//                                                     Text(
//                                                       assignedController.model
//                                                           .value.data![index].date
//                                                           .toString(),
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .headline5!
//                                                           .copyWith(
//                                                               color: AppTheme
//                                                                   .lightblack,
//                                                               fontWeight:
//                                                                   FontWeight.w400,
//                                                               fontSize:
//                                                                   AddSize.font14),
//                                                     ),
//                                                   ],
//                                                 )
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: AddSize.size10,
//                                             ),
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 const Icon(
//                                                   Icons.list_alt_sharp,
//                                                   color: AppTheme.primaryColor,
//                                                 ),
//                                                 SizedBox(
//                                                   width: AddSize.size15,
//                                                 ),
//                                                 Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       "Order ID:",
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .headline5!
//                                                           .copyWith(
//                                                               color: AppTheme
//                                                                   .blackcolor,
//                                                               fontWeight:
//                                                                   FontWeight.w500,
//                                                               fontSize:
//                                                                   AddSize.font14),
//                                                     ),
//                                                     Text(
//                                                       "#${assignedController.model.value.data![index].orderId.toString()}",
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .headline5!
//                                                           .copyWith(
//                                                               color: AppTheme
//                                                                   .lightblack,
//                                                               fontWeight:
//                                                                   FontWeight.w400,
//                                                               fontSize:
//                                                                   AddSize.font14),
//                                                     ),
//                                                   ],
//                                                 )
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: AddSize.size10,
//                                             ),
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 const Icon(
//                                                   Icons.location_on_outlined,
//                                                   color: AppTheme.primaryColor,
//                                                 ),
//                                                 SizedBox(
//                                                   width: AddSize.size15,
//                                                 ),
//                                                 Expanded(
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment.start,
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Text(
//                                                         "Customer Location:",
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .headline5!
//                                                             .copyWith(
//                                                                 color: AppTheme
//                                                                     .blackcolor,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 fontSize: AddSize
//                                                                     .font14),
//                                                       ),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Expanded(
//                                                               child: Text(
//                                                             assignedController
//                                                                     .model
//                                                                     .value
//                                                                     .data![index]
//                                                                     .location!
//                                                                     .location
//                                                                     .toString() +
//                                                                 assignedController
//                                                                     .model
//                                                                     .value
//                                                                     .data![index]
//                                                                     .location!
//                                                                     .flatNo
//                                                                     .toString() +
//                                                                 assignedController
//                                                                     .model
//                                                                     .value
//                                                                     .data![index]
//                                                                     .location!
//                                                                     .street
//                                                                     .toString(),
//                                                             style: Theme.of(
//                                                                     context)
//                                                                 .textTheme
//                                                                 .headline5!
//                                                                 .copyWith(
//                                                                     color: AppTheme
//                                                                         .lightblack,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                     fontSize: AddSize
//                                                                         .font14),
//                                                           )),
//                                                         ],
//                                                       ),
//                                                       SizedBox(height: AddSize.size10,),
//                                                       Text(
//                                                         "Store Location:",
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .headline5!
//                                                             .copyWith(
//                                                             color: AppTheme
//                                                                 .blackcolor,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w500,
//                                                             fontSize: AddSize
//                                                                 .font14),
//                                                       ),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                         children: [
//                                                           Expanded(
//                                                               child: Text(
//                                                                 assignedController
//                                                                     .model
//                                                                     .value
//                                                                     .data![index]
//                                                                     .location!
//                                                                     .location
//                                                                     .toString() +
//                                                                     assignedController
//                                                                         .model
//                                                                         .value
//                                                                         .data![index]
//                                                                         .location!
//                                                                         .flatNo
//                                                                         .toString() +
//                                                                     assignedController
//                                                                         .model
//                                                                         .value
//                                                                         .data![index]
//                                                                         .location!
//                                                                         .street
//                                                                         .toString(),
//                                                                 style: Theme.of(
//                                                                     context)
//                                                                     .textTheme
//                                                                     .headline5!
//                                                                     .copyWith(
//                                                                     color: AppTheme
//                                                                         .lightblack,
//                                                                     fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                     fontSize: AddSize
//                                                                         .font14),
//                                                               )),
//                                                         ],
//                                                       ),
//                                                       SizedBox(
//                                                         height: AddSize.size10,
//                                                       ),
//                                                       Obx(() {
//                                                         return assignedController
//                                                                     .model
//                                                                     .value
//                                                                     .data![index]
//                                                                     .orderStatus ==
//                                                                 "Pickup"
//                                                             ? ElevatedButton(
//                                                                 onPressed: () {
//                                                                   driverUpdateOrder(
//                                                                           orderId: assignedController
//                                                                               .model
//                                                                               .value
//                                                                               .data![
//                                                                                   index]
//                                                                               .orderId,
//                                                                           status:
//                                                                               "delivered",
//                                                                           context:
//                                                                               context)
//                                                                       .then(
//                                                                           (value) {
//                                                                     if (value
//                                                                             .status ==
//                                                                         true) {
//                                                                       showToast(
//                                                                           "${value.message}"
//                                                                               .toString());
//                                                                       assignedController
//                                                                           .getData();
//                                                                       Get.toNamed(
//                                                                           VerifyOtpDeliveryScreen
//                                                                               .verifyOtpDeliveryScreen,
//                                                                           arguments: [
//                                                                             assignedController
//                                                                                 .model
//                                                                                 .value
//                                                                                 .data![index]
//                                                                                 .orderId
//                                                                           ]);
//                                                                     } else {
//                                                                       showToast(value
//                                                                           .message
//                                                                           .toString());
//                                                                     }
//                                                                   });
//                                                                 },
//                                                                 style:
//                                                                     ElevatedButton
//                                                                         .styleFrom(
//                                                                   padding: EdgeInsets
//                                                                       .symmetric(
//                                                                           horizontal:
//                                                                               AddSize.padding22),
//                                                                   minimumSize: Size(
//                                                                       AddSize
//                                                                           .size100,
//                                                                       AddSize.size20 *
//                                                                           1.8),
//                                                                   primary: AppTheme
//                                                                       .primaryColor,
//                                                                   elevation: 0,
//                                                                   shape: RoundedRectangleBorder(
//                                                                       borderRadius:
//                                                                           BorderRadius.circular(
//                                                                               6)),
//                                                                 ),
//                                                                 child: Text(
//                                                                   "Deliver"
//                                                                       .toUpperCase(),
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .headline5!
//                                                                       .copyWith(
//                                                                           color: AppTheme
//                                                                               .backgroundcolor,
//                                                                           fontWeight:
//                                                                               FontWeight
//                                                                                   .w500,
//                                                                           fontSize:
//                                                                               AddSize.font14),
//                                                                 ))
//                                                             : assignedController
//                                                                         .model
//                                                                         .value
//                                                                         .data![
//                                                                             index]
//                                                                         .orderStatus ==
//                                                                     "Accepted"
//                                                                 ? ElevatedButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       driverUpdateOrder(
//                                                                               orderId:
//                                                                                   assignedController.model.value.data![index].orderId,
//                                                                               status: "pickup",
//                                                                               context: context)
//                                                                           .then((value) {
//                                                                         showToast(
//                                                                             "${value.message}"
//                                                                                 .toString());
//                                                                         if (value
//                                                                                 .status ==
//                                                                             true) {
//                                                                           assignedController
//                                                                               .getData();
//                                                                         }
//                                                                       });
//                                                                     },
//                                                                     style: ElevatedButton
//                                                                         .styleFrom(
//                                                                       padding: EdgeInsets.symmetric(
//                                                                           horizontal:
//                                                                               AddSize.padding22),
//                                                                       minimumSize: Size(
//                                                                           AddSize
//                                                                               .size100,
//                                                                           AddSize.size20 *
//                                                                               1.8),
//                                                                       primary:
//                                                                           AppTheme
//                                                                               .userActive,
//                                                                       elevation:
//                                                                           0,
//                                                                       shape: RoundedRectangleBorder(
//                                                                           borderRadius:
//                                                                               BorderRadius.circular(6)),
//                                                                     ),
//                                                                     child: Text(
//                                                                       "Pickup"
//                                                                           .toUpperCase(),
//                                                                       style: Theme.of(
//                                                                               context)
//                                                                           .textTheme
//                                                                           .headline5!
//                                                                           .copyWith(
//                                                                               color:
//                                                                                   AppTheme.backgroundcolor,
//                                                                               fontWeight: FontWeight.w500,
//                                                                               fontSize: AddSize.font14),
//                                                                     ))
//                                                                 : ElevatedButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       null;
//                                                                     },
//                                                                     style: ElevatedButton
//                                                                         .styleFrom(
//                                                                       padding: EdgeInsets.symmetric(
//                                                                           horizontal:
//                                                                               AddSize.padding22),
//                                                                       minimumSize: Size(
//                                                                           AddSize
//                                                                               .size100,
//                                                                           AddSize.size20 *
//                                                                               1.8),
//                                                                       primary:
//                                                                           AppTheme
//                                                                               .userActive,
//                                                                       elevation:
//                                                                           0,
//                                                                       shape: RoundedRectangleBorder(
//                                                                           borderRadius:
//                                                                               BorderRadius.circular(6)),
//                                                                     ),
//                                                                     child: Text(
//                                                                       "Delivered"
//                                                                           .toUpperCase(),
//                                                                       style: Theme.of(
//                                                                               context)
//                                                                           .textTheme
//                                                                           .headline5!
//                                                                           .copyWith(
//                                                                               color:
//                                                                                   AppTheme.backgroundcolor,
//                                                                               fontWeight: FontWeight.w500,
//                                                                               fontSize: AddSize.font14),
//                                                                     ));
//                                                       }),
//                                                       SizedBox(
//                                                         height: AddSize.size10,
//                                                       )
//                                                     ],
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: AddSize.size10,
//                                             ),
//                                           ],
//                                         )),
//                                   );
//                                 },
//                               )
//                             : Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: AddSize.padding20 * 5,
//                                     vertical: AddSize.padding20),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text("Order not Available",
//                                         textAlign: TextAlign.center,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .headline5!
//                                             .copyWith(
//                                                 height: 1.5,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: AddSize.font14,
//                                                 color: AppTheme.blackcolor)),
//                                   ],
//                                 ),
//                               )
//                         : const Center(
//                             child: Padding(
//                             padding: EdgeInsets.only(top: 200),
//                             child: CircularProgressIndicator(),
//                           ));
//                   }),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }
