import 'package:flutter/material.dart';
import 'package:fresh2_arrive/model/time_model.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/vendor_screen/delivery_details.dart';
import 'package:fresh2_arrive/screens/vendor_screen/withdraw_money.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/MyOrder_Details_Controller.dart';
import '../../controller/Vendor_Orderlist_Controller.dart';
import '../../resources/app_assets.dart';

class VendorOrderList extends StatefulWidget {
  const VendorOrderList({Key? key}) : super(key: key);
  static var vendorOrderList = "/vendorOrderList";

  @override
  State<VendorOrderList> createState() => _VendorOrderListState();
}

class _VendorOrderListState extends State<VendorOrderList> {
  final vendorOrderListController = Get.put(VendorOrderListController());
  final controller = Get.put(MyOrderDetailsController());
  final TextEditingController searchController = TextEditingController();
  RxBool isValue = false.obs;
  String? selectedStatus;
  String? selectedTime;

  final List<String> dropDownTimeList = [
    "This week",
    "Last week",
    "This month",
    "Last three month",
    "Custom"
  ];
  final List<String> dropDownStatusList = ["Completed", "Pending"];

  final format = DateFormat('dd-MM-yyyy');

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(vendorOrderListController.selectedDate.value),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      vendorOrderListController.selectedDate.value = pickedDate.toString();
      setState(() {});
    }
  }

  void selectDate1() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(vendorOrderListController.selectedDate.value),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      vendorOrderListController.selectedDate.value = pickedDate.toString();
      controller.getMyOrderDetails();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    vendorOrderListController.filter.value = "";
    vendorOrderListController.vendorOrderListData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(
            title: "Orders List",
            textColor: AppTheme.backgroundcolor,
            context: context,
            backgroundColor: AppTheme.primaryColor,
            icon: Image.asset(
              AppAssets.backwhiteicon,
              height: AddSize.size20,
            )),
        body: vendorOrderListController.isDataLoading.value
            ? SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: AddSize.screenWidth,
                      decoration:
                          const BoxDecoration(color: AppTheme.primaryColor),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AddSize.padding16,
                            vertical: AddSize.padding10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: AddSize.size10,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white24)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding16,
                                      vertical: AddSize.padding16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '₹ ${vendorOrderListController.model.value.data!.earnedBalance.toString()}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: AddSize.font24,
                                                    color: AppTheme
                                                        .backgroundcolor),
                                          ),
                                          SizedBox(
                                            height: AddSize.size5,
                                          ),
                                          Text(
                                            "Your earning this month",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: AddSize.font14,
                                                    color: AppTheme
                                                        .backgroundcolor),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // controller.id.value=vendorOrderListController.model.value.data
                                          Get.toNamed(
                                              WithDrawMoney.withDrawMoney);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AddSize.padding16,
                                                vertical: AddSize.padding10),
                                            decoration: BoxDecoration(
                                                color: AppTheme.backgroundcolor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              "Withdrawal",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: AddSize.font14,
                                                      color: AppTheme
                                                          .primaryColor),
                                            )),
                                      )
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: AddSize.size12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding10,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white10,
                                        border:
                                            Border.all(color: Colors.white24)),
                                    child: DropdownButtonFormField(
                                      iconEnabledColor:
                                          AppTheme.backgroundcolor,
                                      isExpanded: true,
                                      dropdownColor: AppTheme.primaryColor,
                                      decoration: const InputDecoration(
                                          enabled: true,
                                          border: InputBorder.none),
                                      hint: Text(
                                        'Filter',
                                        style: TextStyle(
                                            color: AppTheme.backgroundcolor,
                                            fontSize: AddSize.font14,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start,
                                      ),
                                      // style: TextStyle(
                                      //     fontSize: AddSize.font12,
                                      //     color: isValue.value == false
                                      //         ? AppTheme.blackcolor
                                      //         : AppTheme.backgroundcolor,
                                      //     fontWeight: FontWeight.w500),
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
                                                color: AppTheme.backgroundcolor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedTime = newValue as String?;
                                          vendorOrderListController
                                              .filter.value = newValue!;
                                          if (newValue != "custom") {
                                            vendorOrderListController
                                                .vendorOrderListData();
                                          } else {
                                            vendorOrderListController
                                                    .selectedDate.value =
                                                DateTime.now()
                                                    .subtract(
                                                        const Duration(days: 5))
                                                    .toString();
                                            vendorOrderListController
                                                    .selectedDate1.value =
                                                DateTime.now().toString();
                                          }
                                        });
                                      },
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white10,
                                        border:
                                            Border.all(color: Colors.white24)),
                                    child: DropdownButtonFormField(
                                      isExpanded: true,
                                      dropdownColor: AppTheme.primaryColor,
                                      iconEnabledColor:
                                          AppTheme.backgroundcolor,
                                      hint: Text(
                                        'Status',
                                        style: TextStyle(
                                            color: AppTheme.backgroundcolor,
                                            fontSize: AddSize.font14,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start,
                                      ),
                                      decoration: const InputDecoration(
                                          enabled: true,
                                          border: InputBorder.none),
                                      value: selectedStatus == ""
                                          ? null
                                          : selectedStatus,
                                      items: status.map((value) {
                                        return DropdownMenuItem(
                                          value: value.key.toString(),
                                          child: Text(
                                            value.value,
                                            style: TextStyle(
                                                color: AppTheme.backgroundcolor,
                                                fontSize: AddSize.font14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedStatus = newValue as String?;
                                          vendorOrderListController
                                              .status.value = newValue!;
                                          print(vendorOrderListController
                                              .status.value);
                                          vendorOrderListController
                                              .vendorOrderListData();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            if (vendorOrderListController.filter.value ==
                                "custom")
                              Obx(() {
                                return Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: Colors.white24)),
                                      child: TextFormField(
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: AppTheme.backgroundcolor,
                                        ),
                                        decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        AddSize.padding20,
                                                    vertical:
                                                        AddSize.padding10),
                                            hintStyle: TextStyle(
                                                fontSize: AddSize.font14,
                                                color: AppTheme.backgroundcolor,
                                                fontWeight: FontWeight.w400)),
                                        readOnly: true,
                                        onTap: () {
                                          selectDate();
                                        },
                                        controller: TextEditingController(
                                            text: format.format(DateTime.parse(
                                                vendorOrderListController
                                                            .selectedDate
                                                            .value ==
                                                        ""
                                                    ? DateTime.now().toString()
                                                    : vendorOrderListController
                                                        .selectedDate.value))),
                                      ),
                                    )),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: Colors.white24)),
                                      child: TextFormField(
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: AppTheme.backgroundcolor,
                                        ),
                                        decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        AddSize.padding20,
                                                    vertical:
                                                        AddSize.padding10),
                                            hintStyle: TextStyle(
                                                fontSize: AddSize.font14,
                                                color: AppTheme.backgroundcolor,
                                                fontWeight: FontWeight.w400)),
                                        onTap: () {
                                          selectDate1();
                                        },
                                        readOnly: true,
                                        controller: TextEditingController(
                                            text: format.format(DateTime.parse(
                                                vendorOrderListController
                                                            .selectedDate1
                                                            .value ==
                                                        ""
                                                    ? DateTime.now().toString()
                                                    : vendorOrderListController
                                                        .selectedDate1.value))),
                                      ),
                                    )),
                                    IconButton(
                                        onPressed: () {
                                          vendorOrderListController
                                              .vendorOrderListData();
                                        },
                                        icon: ImageIcon(
                                          const AssetImage(
                                              AppAssets.filterImage),
                                          color: Colors.white,
                                          size: AddSize.size20,
                                        ))
                                  ],
                                );
                              }),
                            SizedBox(
                              height: AddSize.size12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: Colors.white24)),
                              child: TextField(
                                // onTap: (){
                                //   vendorOrderListController.searchController.value=vendorOrderListController.model.value.data.orderList.length;
                                // },
                                maxLines: 1,
                                controller:
                                    vendorOrderListController.searchController,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: AppTheme.backgroundcolor,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value) {
                                  print(vendorOrderListController
                                      .searchController.text);
                                  vendorOrderListController
                                      .vendorOrderListData();

                                  // if (vendorOrderListController
                                  //         .searchController.text ==
                                  //     vendorOrderListController.model.value
                                  //         .data!.orderList!.isNotEmpty) {
                                  //   vendorOrderListController.getSearchData();
                                  // }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    // suffixIcon: IconButton(
                                    //   onPressed: () {},
                                    //   icon: const Icon(
                                    //     Icons.search,
                                    //     color: AppTheme.backgroundcolor,
                                    //     size: 25,
                                    //   ),
                                    // ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding20,
                                        vertical: AddSize.padding10),
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                        fontSize: AddSize.font14,
                                        color: AppTheme.backgroundcolor,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            SizedBox(
                              height: AddSize.size12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppTheme.backgroundcolor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AddSize.padding16,
                            vertical: AddSize.padding10),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Latest Sales",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.blackcolor,
                                        fontSize: AddSize.font16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AddSize.size5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        color: AppTheme.primaryColor),
                              ),
                              Text(
                                "                 Status",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AddSize.font14,
                                        color: AppTheme.primaryColor),
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
                                        color: AppTheme.primaryColor),
                              )
                            ],
                          ),
                          const Divider(),
                          vendorOrderListController.isDataLoading.value
                              ? vendorOrderListController
                                      .model.value.data!.orderList!.isNotEmpty
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: vendorOrderListController
                                          .model.value.data!.orderList!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.id.value =
                                                vendorOrderListController
                                                    .model
                                                    .value
                                                    .data!
                                                    .orderList![index]
                                                    .id
                                                    .toString();
                                            print(
                                                'order id ${controller.id.value}');
                                            Get.toNamed(
                                              DeliveryOrderDetails
                                                  .deliveryOrderDetails,
                                              // arguments: [
                                              //   vendorOrderListController
                                              //       .model
                                              //       .value
                                              //       .data!
                                              //       .orderList![index]
                                              //       .id
                                              //       .toString()
                                              // ]
                                            );
                                          },
                                          child: Column(
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
                                                        '# ${vendorOrderListController.model.value.data!.orderList![index].id.toString()}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                                height: 1.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: AddSize
                                                                    .font14),
                                                      ),
                                                      Text(
                                                        vendorOrderListController
                                                            .model
                                                            .value
                                                            .data!
                                                            .orderList![index]
                                                            .date
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
                                                                        .font12,
                                                                color: Colors
                                                                    .grey
                                                                    .shade500),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    vendorOrderListController
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
                                                                FontWeight.w500,
                                                            fontSize:
                                                                AddSize.font14,
                                                            color: Colors.orange
                                                                .shade200),
                                                  ),
                                                  Text(
                                                    "₹ ${vendorOrderListController.model.value.data!.orderList![index].amount.toString()}",
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
                                                                .blackcolor),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: AddSize.size5,
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.only(top: 100),
                                      child: Center(
                                          child: Text(
                                        "No Order Found",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    )
                              : const CircularProgressIndicator()
                        ]),
                      ),
                    ),
                  ],
                ))
            : const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
