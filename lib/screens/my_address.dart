import 'package:flutter/material.dart';
import 'package:fresh2_arrive/repositories/add_address_repository.dart';
import 'package:fresh2_arrive/screens/my_cart_screen.dart';
import 'package:fresh2_arrive/screens/order/choose_address.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../../resources/app_theme.dart';
import '../controller/MyAddress_controller.dart';
import '../controller/My_cart_controller.dart';
import '../controller/main_home_controller.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key}) : super(key: key);
  static var myAddressScreen = "/myAddressScreen";

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  final addressController = Get.put(MyAddressController());
  final controller = Get.put(MyCartDataListController());
  final mainController = Get.put(MainHomeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: backAppBar(title: "My Address", context: context),
        body: Obx(() {
          return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: height * .01),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .01,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(ChooseAddress.chooseAddressScreen);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.gps_fixed,
                            color: AppTheme.primaryColor,
                          ),
                          SizedBox(
                            width: width * .02,
                          ),
                          const Text(
                            "Use Current Location",
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    addressController.isAddressLoad.value
                        ? addressController
                                .myAddressModel.value.data!.isNotEmpty
                            ? Column(
                                children: [
                                  ListView.builder(
                                      itemCount: addressController
                                          .myAddressModel.value.data!.length,
                                      shrinkWrap: true,
                                      padding:
                                          EdgeInsets.only(top: height * .01),
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
                                              chooseOrderAddress(addressId: addressController
                                                  .myAddressModel
                                                  .value
                                                  .data![index]
                                                  .id
                                                  .toString(), context: context).then((value){
                                                    if(value.status == true){
                                                      controller.getAddToCartList();
                                                      Get.back();
                                                      mainController.onItemTap(1);
                                                    }
                                              });
                                            },
                                            child: Card(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width * .03,
                                                      vertical: height * .01),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        addressController
                                                            .myAddressModel
                                                            .value
                                                            .data![index]
                                                            .addressType
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: AppTheme
                                                                .blackcolor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        "${addressController.myAddressModel.value.data![index].street.toString()}, Flat no ${addressController.myAddressModel.value.data![index].flatNo.toString()}, Landmark ${addressController.myAddressModel.value.data![index].landmark.toString()}, ",
                                                        style: TextStyle(
                                                            color: AppTheme
                                                                .subText,
                                                            fontSize:
                                                                AddSize.font14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                        addressController
                                                            .myAddressModel
                                                            .value
                                                            .data![index]
                                                            .location
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: AppTheme
                                                                .blackcolor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                          height: height * .01),
                                                      Row(
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              removeAddress(
                                                                      addressId: addressController
                                                                          .myAddressModel
                                                                          .value
                                                                          .data![
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      context:
                                                                          context)
                                                                  .then(
                                                                      (value) {
                                                                showToast(value
                                                                    .message
                                                                    .toString());
                                                                if (value
                                                                        .status ==
                                                                    true) {
                                                                  addressController
                                                                      .getAddress();
                                                                }
                                                              });
                                                            },
                                                            child: const Text(
                                                              "Remove",
                                                              style: TextStyle(
                                                                  color: AppTheme
                                                                      .primaryColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  width * .02),
                                                          Container(
                                                            color: AppTheme
                                                                .primaryColor,
                                                            height:
                                                                height * .012,
                                                            width: width * .003,
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              addressController
                                                                      .id
                                                                      .value =
                                                                  addressController
                                                                      .myAddressModel
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .id
                                                                      .toString();
                                                              Get.toNamed(
                                                                  ChooseAddress
                                                                      .chooseAddressScreen,
                                                                  arguments: [
                                                                    addressController
                                                                        .myAddressModel
                                                                        .value
                                                                        .data![index]
                                                                  ]);
                                                            },
                                                            child: const Text(
                                                              "Edit",
                                                              style: TextStyle(
                                                                  color: AppTheme
                                                                      .primaryColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: height * .05,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(
                                            ChooseAddress.chooseAddressScreen);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize:
                                            const Size(double.maxFinite, 60),
                                        primary: AppTheme.primaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      child: Text(
                                        "ADD NEW",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                color: AppTheme.backgroundcolor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                      )),
                                ],
                              )
                            : const SizedBox()
                        : const Center(
                            child: CircularProgressIndicator(
                            color: AppTheme.primaryColor,
                          )),
                  ],
                ),
              ));
        }));
  }
}
