import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/MyOrder_Details_Controller.dart';
import 'package:fresh2_arrive/routers/my_router.dart';
import 'package:fresh2_arrive/screens/order/orderDetails.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../../controller/MyOrder_Controller.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);
  static var myOrderScreen = "/myOrderScreen";

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final myOrderController = Get.put(MyOrderController());
  final controller = Get.put(MyOrderDetailsController());

  @override
  void initState() {
    super.initState();
    myOrderController.getMyOrder();
  }

  String? selectedStatus;
  String? selectedTime;
  final List<String> DropDownTimeList = [
    "This week",
    "Last week",
    "This month",
    "Last three month",
    "Custom from-to calender icon"
  ];
  final List<String> DropDownStatusList = ["Completed", "Pending"];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        // backgroundColor: CupertinoColors.white,
        appBar: backAppBar(
          title: "My Orders",
          context: context,
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16,
                vertical: AddSize.padding10,
              ),
              child: Obx(() {
                return myOrderController.isDataLoading.value
                    ? Column(
                        children: [
                          SizedBox(
                            height: AddSize.size10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Spacer(flex: 2),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: AppTheme.backgroundcolor),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select Time',
                                        style: TextStyle(
                                            color: AppTheme.lightblack,
                                            fontSize: AddSize.font12,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start,
                                      ),
                                      value: selectedTime == ""
                                          ? null
                                          : selectedTime,
                                      items: DropDownTimeList.map((value) {
                                        return DropdownMenuItem(
                                          value: value.toString(),
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: AddSize.font14,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedTime = newValue as String?;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: AddSize.size12,
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: AppTheme.backgroundcolor),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select Status',
                                        style: TextStyle(
                                            color: AppTheme.lightblack,
                                            fontSize: AddSize.font12,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start,
                                      ),
                                      value: selectedStatus == ""
                                          ? null
                                          : selectedStatus,
                                      items: DropDownStatusList.map((value) {
                                        return DropdownMenuItem(
                                          value: value.toString(),
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: AddSize.font14,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedStatus = newValue as String?;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: ImageIcon(
                                      const AssetImage(AppAssets.filterImage),
                                      color: AppTheme.primaryColor,
                                      size: AddSize.size18,
                                    )),
                              )
                            ],
                          ),
                          ListView.builder(
                              itemCount:
                                  myOrderController.model.value.data!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: AddSize.padding10),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return myOrderController.isDataLoading.value
                                    ? Obx(() {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          // height: height * .23,
                                          child: InkWell(
                                            onTap: () {
                                              controller.id.value =
                                                  myOrderController.model.value
                                                      .data![index].orderId
                                                      .toString();
                                              Get.toNamed(OrderDetails
                                                  .orderDetailsScreen);
                                            },
                                            child: Card(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            AddSize.padding10,
                                                        vertical:
                                                            AddSize.padding10,
                                                      ),
                                                      child: Expanded(
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                height: AddSize
                                                                    .size80,
                                                                width: AddSize
                                                                    .size80,
                                                                decoration: const BoxDecoration(
                                                                    color: Color(
                                                                        0xffEAEAEA),
                                                                    shape: BoxShape
                                                                        .circle),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(14),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: myOrderController
                                                                        .model
                                                                        .value
                                                                        .data![
                                                                            index]
                                                                        .image
                                                                        .toString(),
                                                                    errorWidget: (_,
                                                                            __,
                                                                            ___) =>
                                                                        const SizedBox(),
                                                                    placeholder:
                                                                        (_, __) =>
                                                                            const SizedBox(),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: AddSize
                                                                    .width15,
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height: AddSize
                                                                          .size20,
                                                                    ),
                                                                    Text(
                                                                      'Order ID : ${myOrderController.model.value.data![index].orderId.toString()}',
                                                                      style: TextStyle(
                                                                          color: const Color(
                                                                              0xff293044),
                                                                          fontSize: AddSize
                                                                              .font16,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    SizedBox(
                                                                      height: AddSize
                                                                          .size5,
                                                                    ),
                                                                    Text(
                                                                      'Total Amount - ₹${myOrderController.model.value.data![index].grandTotal.toString()}',
                                                                      style: const TextStyle(
                                                                          color: Color(
                                                                              0xff727786),
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                    Text(
                                                                      ' ${myOrderController.model.value.data![index].itemCount.toString()} Items',
                                                                      style: const TextStyle(
                                                                          color: Color(
                                                                              0xff727786),
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    SizedBox(
                                                                      height: AddSize
                                                                          .size5,
                                                                    ),
                                                                    Text(
                                                                      'Placed at: ${myOrderController.model.value.data![index].placedAt.toString()}',
                                                                      style: const TextStyle(
                                                                          color: Color(
                                                                              0xff727786),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                    SizedBox(
                                                                      height: AddSize
                                                                          .size5,
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top: 5,
                                                        right: 5,
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color: AppTheme
                                                                    .lightGreen),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          width *
                                                                              .02,
                                                                      vertical:
                                                                          height *
                                                                              .005),
                                                              child: const Text(
                                                                // myOrderController
                                                                //     .model
                                                                //     .value
                                                                //     .data![
                                                                //         index]
                                                                //     .deliveryStatus
                                                                //     .toString(),
                                                                'pending',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: AppTheme
                                                                        .userActive,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            )))
                                                  ],
                                                )),
                                          ),
                                        );
                                      })
                                    : SizedBox();
                              }),
                          SizedBox(
                            height: height * .05,
                          )
                        ],
                      )
                    : const Center(child: CircularProgressIndicator());
              }),
            )));
  }
}
