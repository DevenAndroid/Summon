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
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import '../../controller/MyOrder_Controller.dart';
import '../../model/time_model.dart';
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
  final controller1 = Get.put(MyOrderDetailsController());

  @override
  void initState() {
    super.initState();
    myOrderController.filter.value = "";
    myOrderController.getMyOrder();
  }

  String? selectedStatus;
  String? selectedTime;
  final List<String> DropDownTimeList = [
    "This week",
    "Last week",
    "This month",
    "Custom"
  ];
  final List<String> DropDownStatusList = ["Completed", "Pending"];
  final format = intl.DateFormat('dd-MM-yyyy');

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(myOrderController.selectedDate.value),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      myOrderController.selectedDate.value = pickedDate.toString();
      setState(() {});
    }
  }

  void selectDate1() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(myOrderController.selectedDate1.value),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      myOrderController.selectedDate1.value = pickedDate.toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          //backgroundColor: Colors.transparent,
          appBar: backAppBar(title: "My Orders", context: context),
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                  vertical: AddSize.padding10,
                ),
                child: Obx(() {
                  return Column(
                          children: [
                            SizedBox(
                              height: AddSize.size10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Spacer(flex: 2),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding10,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: AppTheme.backgroundcolor),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                              itemHeight: null,
                                              isExpanded: true,
                                              hint: Text(
                                                'Select Time',
                                                style: TextStyle(
                                                    color: AppTheme.lightblack,
                                                    fontSize: AddSize.font14,
                                                    fontWeight: FontWeight.w500),
                                                textAlign: TextAlign.start,
                                              ),
                                              value: selectedTime == ""
                                                  ? null
                                                  : selectedTime,
                                              items: timeData.map((value) {
                                                return DropdownMenuItem(
                                                  value: value.key.toString(),
                                                  child: Text(
                                                    value.value,
                                                    style: TextStyle(
                                                      fontSize: AddSize.font14,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedTime =
                                                      newValue as String?;
                                                  myOrderController.filter.value =
                                                      newValue!;
                                                  if (newValue != "custom") {
                                                    myOrderController
                                                        .getMyOrder();
                                                  } else {
                                                    myOrderController
                                                            .selectedDate.value =
                                                        DateTime.now()
                                                            .subtract(
                                                                const Duration(
                                                                    days: 5))
                                                            .toString();
                                                    myOrderController
                                                            .selectedDate1.value =
                                                        DateTime.now().toString();
                                                  }
                                                });
                                              }))),
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
                                        items: status.map((value) {
                                          return DropdownMenuItem(
                                            value: value.key.toString(),
                                            child: Text(
                                              value.value,
                                              style: TextStyle(
                                                fontSize: AddSize.font14,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedStatus = newValue as String?;
                                            myOrderController.status.value = newValue!;
                                            print(myOrderController.status.value);
                                            myOrderController.getMyOrder();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: IconButton(
                                      onPressed: () {
                                        myOrderController.getMyOrder();
                                      },
                                      icon: ImageIcon(
                                        const AssetImage(AppAssets.filterImage),
                                        color: Colors.white,
                                        size: AddSize.size30,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(height: AddSize.size10,),
                            if (myOrderController.filter.value == "custom")
                              Obx(() {
                                return Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                    10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: AddSize.padding20,vertical: AddSize.padding20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Start Date"),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  enabledBorder:  OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.grey.shade300),
                                                      borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                       BorderSide(color: Colors.grey.shade300, width: 3.0),
                                                      borderRadius: BorderRadius.circular(15.0)),
                                                ),
                                        readOnly: true,
                                        onTap: () {
                                              selectDate();
                                        },
                                        controller: TextEditingController(
                                                text: format.format(DateTime.parse(
                                                    myOrderController
                                                                .selectedDate.value ==
                                                            ""
                                                        ? DateTime.now().toString()
                                                        : myOrderController
                                                            .selectedDate.value))),
                                      ),
                                            ],
                                          )),
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("End Date"),
                                              TextFormField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder:  OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey.shade300),
                                            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                                        border: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey.shade300, width: 3.0),
                                            borderRadius: BorderRadius.circular(15.0)),
                                      ),
                                        onTap: () {
                                              selectDate1();
                                        },
                                        readOnly: true,
                                        controller: TextEditingController(
                                                text: format.format(DateTime.parse(
                                                    myOrderController.selectedDate1.value ==
                                                            ""
                                                        ? DateTime.now().toString()
                                                        : myOrderController
                                                            .selectedDate1.value))),
                                      ),
                                            ],
                                          )),
                                    ],
                                  ),
                                )
                                );
                              }),
                            myOrderController.isDataLoading.value
                                ? myOrderController.model.value.data!.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: myOrderController
                                            .model.value.data!.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(
                                            top: AddSize.padding10),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
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
                                                  elevation: 0,
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
                                                                decoration:  BoxDecoration(

                                                                    color: Color(0xffFE724C).withOpacity(.10),
                                                                  borderRadius: BorderRadius.circular(6),


                                                                ),
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
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: AddSize
                                                                    .width15,
                                                              ),
                                                              Expanded(
                                                                child: Column(

                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                      SizedBox(height: 5,),
                                                                    Text(
                                                                      'Order ID : ${myOrderController.model.value.data![index].orderId.toString()}',
                                                                      style: GoogleFonts.ibmPlexSansArabic(
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
                                                                      height:3,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text("SR",
                                                                          style:
                                                                          GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                                                              fontWeight: FontWeight
                                                                                  .w700,
                                                                              color: Color(
                                                                                  0xff727786)),),
                                                                        SizedBox(
                                                                          height: AddSize
                                                                              .size5,
                                                                        ),
                                                                        Text(
                                                                          '${myOrderController.model.value.data![index].grandTotal.toString()}',
                                                                          style:   GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                                                              fontWeight: FontWeight
                                                                                  .w700,
                                                                              color: Color(
                                                                                  0xff727786)),
                                                                          textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                        ),
                                                                        SizedBox(
                                                                          width: 3,
                                                                        ),
                                                                        Icon(Icons.circle,size: 5,color: Color(
                                                                            0xff2C4D61)),
                                                                        SizedBox(
                                                                          width: 3,
                                                                        ),
                                                                        Text(
                                                                          '${myOrderController.model.value.data![index].placedAt.toString()}',
                                                                          style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                                                              fontWeight: FontWeight
                                                                                  .w700,
                                                                              color: Color(
                                                                                  0xff727786)),
                                                                        ),
                                                                        SizedBox(
                                                                          height: AddSize
                                                                              .size5,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 8,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                            decoration: BoxDecoration(
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    5),
                                                                                color: Color(0xffD3FFD3).withOpacity(.30)),
                                                                            child: Padding(
                                                                              padding: EdgeInsets
                                                                                  .symmetric(
                                                                                  horizontal:
                                                                                  width *
                                                                                      .02,
                                                                                  vertical:
                                                                                  height *
                                                                                      .005),
                                                                              child: Text(
                                                                                myOrderController
                                                                                    .model
                                                                                    .value
                                                                                    .data![
                                                                                index]
                                                                                    .deliveryStatus
                                                                                    .toString(),
                                                                                // 'pending',
                                                                                style: const TextStyle(
                                                                                    fontSize:
                                                                                    12,
                                                                                    color: AppTheme
                                                                                        .userActive,
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .w400),
                                                                              ),
                                                                            )),
                                                                        Container(
                                                                            decoration: BoxDecoration(
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    5),
                                                                                color: Color(0xffFE724C)),
                                                                            child: Padding(
                                                                              padding: EdgeInsets
                                                                                  .symmetric(
                                                                                  horizontal:
                                                                                  width *
                                                                                      .02,
                                                                                  vertical:
                                                                                  height *
                                                                                      .004),
                                                                              child: Text(
                                                                               "Reorder",
                                                                                // 'pending',
                                                                                style:  GoogleFonts.ibmPlexSansArabic(
                                                                                    fontSize:
                                                                                    12,
                                                                                    color: Color(0xffFFFFFF),
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .w500),
                                                                              ),
                                                                            )),
                                                                      ],
                                                                    )
                                                                    // Text(
                                                                    //   ' ${myOrderController.model.value.data![index].itemCount.toString()} Items',
                                                                    //   style: const TextStyle(
                                                                    //       color: Color(
                                                                    //           0xff727786),
                                                                    //       fontSize:
                                                                    //           12,
                                                                    //       fontWeight:
                                                                    //           FontWeight.w400),
                                                                    // ),
                                                                    // SizedBox(
                                                                    //   height: AddSize
                                                                    //       .size5,
                                                                    // ),

                                                                  ],
                                                                ),
                                                              ),
                                                               // Icon(Icons.arrow_forward_ios,size: AddSize.size15)
                                                            ]),
                                                      ),

                                                    ],
                                                  )),
                                            ),
                                          );
                                        })
                                    : Center(
                                        child: Padding(
                                            padding: EdgeInsets.only(top: AddSize.size200),
                                            child: Text(
                                              "Order Not Available",
                                              style: TextStyle(
                                                  fontSize: AddSize.font16,
                                                  color: AppTheme.blackcolor,
                                                  fontWeight: FontWeight.w500),
                                            )))
                                :  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: AddSize.size100),
                                      child: const CircularProgressIndicator(),
                                    )),
                            SizedBox(
                              height: height * .05,
                            )
                          ],
                        );
                }),
              ))),
    );
  }
}
