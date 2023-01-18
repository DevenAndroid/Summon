import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/routers/my_router.dart';
import 'package:fresh2_arrive/screens/order/orderDetails.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);
  static var myOrderScreen = "/myOrderScreen";
  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
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
        appBar: backAppBar(title: "My Orders", context: context),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16,
                vertical: AddSize.padding10,
              ),
              child: Column(
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
                              value: selectedTime == "" ? null : selectedTime,
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
                              value:
                                  selectedStatus == "" ? null : selectedStatus,
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
                      itemCount: 5,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: AddSize.padding10),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          // height: height * .23,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(OrderDetails.orderDetailsScreen);
                            },
                            child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding10,
                                        vertical: AddSize.padding10,
                                      ),
                                      child: Expanded(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: AddSize.size80,
                                                width: AddSize.size80,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "https://media.istockphoto.com/id/673162168/photo/green-cabbage-isolated-on-white.jpg?s=612x612&w=0&k=20&c=mCc4mXATvCcfp2E9taRJBp-QPYQ_LCj6nE1D7geaqVk=",
                                                  errorWidget: (_, __, ___) =>
                                                      const SizedBox(),
                                                  placeholder: (_, __) =>
                                                      const SizedBox(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width: AddSize.width15,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: AddSize.size20,
                                                    ),
                                                    Text(
                                                      "Coriander Leaves And Greens",
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .blackcolor,
                                                          fontSize:
                                                              AddSize.font16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    SizedBox(
                                                      height: AddSize.size5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Order ID",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: AddSize
                                                                  .font12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        Text(
                                                          " #12546",
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              fontSize: AddSize
                                                                  .font12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: AddSize.size5,
                                                    ),
                                                    Text(
                                                      "Placed at: Monday, 2 June, 2021",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize:
                                                              AddSize.font12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      height: AddSize.size5,
                                                    ),
                                                    Text(
                                                      "₹10.00",
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .primaryColor,
                                                          fontSize:
                                                              AddSize.font14,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                    BorderRadius.circular(8),
                                                color: AppTheme.lightGreen),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * .02,
                                                  vertical: height * .005),
                                              child: const Text(
                                                "Delivered",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppTheme.userActive,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            )))
                                  ],
                                )),
                          ),
                        );
                      }),
                  SizedBox(
                    height: height * .05,
                  )
                ],
              ),
            )));
  }
}
