import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/MyOrder_Details_Controller.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);
  static var orderDetailsScreen = "/orderDetailsScreen";

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>
    with SingleTickerProviderStateMixin {
  final myOrderDetailsController = Get.put(MyOrderDetailsController());
  bool value = false;
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    myOrderDetailsController.getMyOrderDetails();
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
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
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: "Order Details", context: context),
        body: myOrderDetailsController.isDataLoading.value
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
                                        borderRadius: BorderRadius.circular(10)),
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
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const ImageIcon(
                                                      AssetImage(
                                                          AppAssets.orderList),
                                                      color: AppTheme.primaryColor,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: AddSize.size15,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Order ID ${myOrderDetailsController.model.value.data!.orderId.toString()}',
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              fontSize:
                                                                  AddSize.font16,
                                                              fontWeight:
                                                                  FontWeight.w500),
                                                        ),
                                                        Text(
                                                          myOrderDetailsController
                                                              .model
                                                              .value
                                                              .data!
                                                              .placedAt
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .blackcolor,
                                                              fontSize:
                                                                  AddSize.font12,
                                                              fontWeight:
                                                                  FontWeight.w400),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                          SizedBox(
                                            height: height * .02,
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: myOrderDetailsController
                                                .model
                                                .value
                                                .data!
                                                .orderItems!
                                                .length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return Column(
                                                children: [
                                                  orderList(
                                                    myOrderDetailsController
                                                        .model
                                                        .value
                                                        .data!
                                                        .orderItems![index]
                                                        .productName
                                                        .toString(),
                                                    myOrderDetailsController
                                                        .model
                                                        .value
                                                        .data!
                                                        .orderItems![index]
                                                        .price
                                                        .toString(),
                                                    myOrderDetailsController
                                                        .model
                                                        .value
                                                        .data!
                                                        .orderItems![index]
                                                        .itemQty
                                                        .toString(),
                                                    myOrderDetailsController
                                                        .model
                                                        .value
                                                        .data!
                                                        .orderItems![index]
                                                        .qty
                                                        .toString(),
                                                  ),
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
                                    right: 10,
                                    child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(
                                            8),
                                        color:
                                        AppTheme.primaryColor),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * .04,
                                          vertical: height * .005),
                                      child: Text(
                                        myOrderDetailsController
                                            .model
                                            .value
                                            .data!
                                            .deliveryStatus
                                            .toString(),
                                        style: TextStyle(
                                            fontSize:
                                            AddSize.font14,
                                            color: AppTheme
                                                .backgroundcolor,
                                            fontWeight:
                                            FontWeight.w500),
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
                                    tabs: const [
                                      Tab(
                                        child: Text(
                                          "Driver  Detail",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          "Store Information",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
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
                            if(myOrderDetailsController.model.value.data!.driver != null)
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
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Row(children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
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
                                                      (myOrderDetailsController.model.value.data!.driver!.name ?? "").toString(),
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
                                                    shape:
                                                    CircleBorder()),
                                                child: const Center(
                                                    child: Icon(
                                                      Icons.person_rounded,
                                                      color: AppTheme
                                                          .backgroundcolor,
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
                                                          FontWeight.w400,
                                                          fontSize:
                                                          AddSize.font14),
                                                    ),
                                                    Text(
                                                      (myOrderDetailsController.model.value.data!.driver!.phone ?? "").toString(),
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
                                                  _makingPhoneCall("tel:+91${myOrderDetailsController.model.value.data!.driver!.phone ?? ""}".toString());
                                                   },
                                                child: Container(
                                                    height: AddSize.size45,
                                                    width: AddSize.size45,
                                                    decoration: const ShapeDecoration(
                                                        color: AppTheme.primaryColor,
                                                        shape: CircleBorder()),
                                                    child: const Center(
                                                        child: Icon(
                                                          Icons.phone,
                                                          color: AppTheme.backgroundcolor,
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
                                                          "Delivery Address",
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
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                (myOrderDetailsController.model.value.data!.driver!.location ?? "").toString(),
                                                                maxLines: 2,
                                                                style: Theme.of(
                                                                    context)
                                                                    .textTheme
                                                                    .headline5!
                                                                    .copyWith(
                                                                    height: 1.5,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontSize: AddSize
                                                                        .font16),
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
                                                onTap: (){
                                                  openMap(double.parse(myOrderDetailsController.model.value.data!.address!.latitude.toString()),double.parse(myOrderDetailsController.model.value.data!.address!.longitude.toString()));
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
                                        ]
                                    ],
                                  ),
                                )),
                            paymentDetails(
                              subTotal: myOrderDetailsController
                                  .model.value.data!.itemTotal
                                  .toString(),
                              delivery: myOrderDetailsController
                                  .model.value.data!.deliveryCharges
                                  .toString(),
                              packing: myOrderDetailsController
                                  .model.value.data!.packingFee
                                  .toString(),
                              orderType: myOrderDetailsController
                                  .model.value.data!.orderType
                                  .toString(),
                              total: myOrderDetailsController
                                  .model.value.data!.grandTotal
                                  .toString(),
                            )
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AddSize.padding16),
                          child: Column(
                            children: [
                              Card(
                                elevation: 0,
                                color: AppTheme.backgroundcolor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding15,
                                      vertical: AddSize.padding15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Store Name",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      color:
                                                          AppTheme.lightblack,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: AddSize.font14),
                                            ),
                                            Text(
                                              (myOrderDetailsController.model
                                                  .value.data!.vendor!.name??"")
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: AddSize.font16),
                                            ),
                                          ],
                                        ),
                                      ]),
                                      Container(
                                        height: AddSize.size45,
                                        width: AddSize.size45,
                                        decoration: const ShapeDecoration(
                                            color: AppTheme.primaryColor,
                                            shape: CircleBorder()),
                                        child: Center(
                                            child: Image(
                                          image: const AssetImage(
                                              AppAssets.store1Icon),
                                          height: AddSize.size20,
                                          width: AddSize.size20,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              paymentDetails(
                                subTotal: myOrderDetailsController
                                    .model.value.data!.itemTotal
                                    .toString(),
                                delivery: myOrderDetailsController
                                    .model.value.data!.deliveryCharges
                                    .toString(),
                                packing: myOrderDetailsController
                                    .model.value.data!.packingFee
                                    .toString(),
                                orderType: myOrderDetailsController
                                    .model.value.data!.orderType
                                    .toString(),
                                total: myOrderDetailsController
                                    .model.value.data!.grandTotal
                                    .toString(),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      );
    });
  }

  orderList(name, price, qty, itemQty) {
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
                "₹$price",
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
            Text(
              itemQty,
              style: TextStyle(
                  fontSize: AddSize.font14,
                  color: AppTheme.lightblack,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  paymentDetails({
    required subTotal,
    required delivery,
    required packing,
    required total,
    required orderType,
  }) {
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
                details("Subtotal:", "₹$subTotal"),
                SizedBox(
                  height: AddSize.size5,
                ),
                details("Delivery charges:", "₹$delivery"),
                SizedBox(
                  height: AddSize.size5,
                ),
                details("Packing charges:", "₹$packing"),
                SizedBox(
                  height: AddSize.size5,
                ),
                myOrderDetailsController
                    .model.value.data!.tax1 !=null && myOrderDetailsController
                    .model.value.data!.tax1!.type != ""?
                Column(children: [
                  details("${myOrderDetailsController
                      .model.value.data!.tax1!.type ?? ""}:",
                      "₹${myOrderDetailsController
                          .model.value.data!.tax1!.amount ?? ""}"),
                  SizedBox(
                    height: AddSize.size5,
                  ),
                ],):const SizedBox(),
                myOrderDetailsController
                    .model.value.data!.tax2 !=null && myOrderDetailsController
                    .model.value.data!.tax2!.type != ""?
                Column(children: [
                  details("${myOrderDetailsController
                      .model.value.data!.tax2!.type ?? ""}:",
                      "₹${myOrderDetailsController
                          .model.value.data!.tax2!.amount ?? ""}"),
                  SizedBox(
                    height: AddSize.size10,
                  ),
                ],):const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total:",
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500)),
                    Text("₹$total",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: AddSize.font14,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                SizedBox(
                  height: AddSize.size5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          // Get.toNamed(MyRouter.editProfileScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(AddSize.size50, AddSize.size30),
                          primary: AppTheme.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Text(
                          orderType,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: AppTheme.backgroundcolor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AddSize.font14),
                        )),
                  ],
                )
              ],
            )));
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
        Text(price,
            style: TextStyle(
                color: Colors.grey,
                fontSize: AddSize.font14,
                fontWeight: FontWeight.w500))
      ],
    );
  }
}
