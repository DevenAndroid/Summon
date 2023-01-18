import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/main_home_controller.dart';
import 'package:fresh2_arrive/screens/vendor_screen/store_open_time_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_orderList.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
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
  final controller = Get.put(MainHomeController());
  final RxBool _store = true.obs;
  final RxBool _selfDelivery = true.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leadingWidth: AddSize.size20 * 1.6,
            backgroundColor: AppTheme.backgroundcolor,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, Demo Vendor",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w500, fontSize: AddSize.font16),
                ),
                Row(
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
                    GestureDetector(
                        onTap: () {},
                        child: Text(
                          "10am to 9pm",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: AddSize.font14,
                                  color: AppTheme.primaryColor),
                        )),
                    SizedBox(
                      width: AddSize.size5,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(SetTimeScreen.setTimeScreen);
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppTheme.primaryColor,
                          size: AddSize.size15,
                        ))
                  ],
                ),
              ],
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: AddSize.padding10),
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
                  horizontal: AddSize.padding20,
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
                            // color: Colors.brown
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv00m-RB7TtdPHzzer0T4rTkqkbEkmov0wUg&usqp=CAU',
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
                            color: AppTheme.userActive,
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
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding10),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: AddSize.padding10),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              AppAssets.vendorDashboard))),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "10%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              height: 1.5,
                                              fontWeight: FontWeight.w600,
                                              fontSize: AddSize.font14,
                                              color: Colors.green),
                                    ),
                                    Icon(
                                      Icons.arrow_upward_sharp,
                                      color: Colors.green,
                                      size: AddSize.size15,
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: AddSize.size10,
                            ),
                            Text(
                              "₹230.55",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.backgroundcolor,
                                  borderRadius: BorderRadius.circular(20)),
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
                                                fontWeight: FontWeight.w500,
                                                fontSize: AddSize.font14),
                                      ),
                                      SizedBox(
                                        width: AddSize.size20 * 1.5,
                                      ),
                                      FlutterSwitch(
                                        width: AddSize.size30 * 2.2,
                                        height: AddSize.size20 * 1.4,
                                        valueFontSize: AddSize.font12,
                                        activeTextFontWeight: FontWeight.w600,
                                        inactiveText: " OFF",
                                        activeText: "  On",
                                        inactiveTextColor:
                                            AppTheme.backgroundcolor,
                                        activeTextColor:
                                            AppTheme.backgroundcolor,
                                        inactiveTextFontWeight: FontWeight.w600,
                                        inactiveColor: Colors.grey.shade400,
                                        activeColor: AppTheme.primaryColor,
                                        value: _store.value,
                                        borderRadius: 30.0,
                                        showOnOff: true,
                                        onToggle: (val) {
                                          _store.value = val;
                                        },
                                      ),
                                    ],
                                  )),
                            ),
                            Container(
                              height: AddSize.size80,
                              decoration: BoxDecoration(
                                  color: AppTheme.backgroundcolor,
                                  borderRadius: BorderRadius.circular(20)),
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
                                                fontWeight: FontWeight.w500,
                                                fontSize: AddSize.font14),
                                      ),
                                      SizedBox(
                                        width: AddSize.size20,
                                      ),
                                      FlutterSwitch(
                                        width: AddSize.size30 * 2.2,
                                        height: AddSize.size20 * 1.4,
                                        valueFontSize: AddSize.font12,
                                        activeTextFontWeight: FontWeight.w600,
                                        activeTextColor:
                                            AppTheme.backgroundcolor,
                                        value: _selfDelivery.value,
                                        inactiveText: " OFF",
                                        activeText: "  On",
                                        inactiveColor: Colors.grey.shade400,
                                        inactiveTextFontWeight: FontWeight.w600,
                                        inactiveTextColor:
                                            AppTheme.backgroundcolor,
                                        activeColor: AppTheme.primaryColor,
                                        borderRadius: 30.0,
                                        showOnOff: true,
                                        onToggle: (val) {
                                          _selfDelivery.value = val;
                                        },
                                      ),
                                      // CupertinoSwitch(
                                      //   value: _selfDelivery.value,
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       _selfDelivery.value = value;
                                      //     });
                                      //   },
                                      // ),
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
                                        Get.toNamed(
                                            VendorOrderList.vendorOrderList);
                                      },
                                      child: Text(
                                        "See All",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                height: 1.5,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.primaryColor,
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
                                            color: const Color(0xff52AC1A)),
                                  ),
                                  Text(
                                    "Status",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                            height: 1.5,
                                            fontWeight: FontWeight.w500,
                                            fontSize: AddSize.font14,
                                            color: const Color(0xff52AC1A)),
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
                                            color: const Color(0xff52AC1A)),
                                  )
                                ],
                              ),
                              const Divider(),
                              ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: AddSize.size5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "#1234",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            AddSize.font14),
                                              ),
                                              Text(
                                                "2 June, 2021 - 11:57PM",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            AddSize.font12,
                                                        color: Colors
                                                            .grey.shade500),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Processing",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AddSize.font14,
                                                    color:
                                                        Colors.orange.shade200),
                                          ),
                                          Text(
                                            "\$7,969.00",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AddSize.font14,
                                                    color: AppTheme.blackcolor),
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
    });
  }
}
