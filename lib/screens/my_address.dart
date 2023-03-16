import 'package:flutter/material.dart';
import 'package:fresh2_arrive/repositories/add_address_repository.dart';
import 'package:fresh2_arrive/screens/order/choose_address.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../../resources/app_theme.dart';
import '../controller/MyAddress_controller.dart';
import '../controller/My_cart_controller.dart';
import '../controller/main_home_controller.dart';
import '../resources/app_assets.dart';

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

  showUploadWindow(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AddSize.size10),
                    Text("Are you sure you want to delete this address?",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: AddSize.font16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text("No",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.primaryColor,
                                  fontSize: AddSize.font18)),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: Text("Yes",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.primaryColor,
                                  fontSize: AddSize.font18)),
                          onPressed: () {
                            removeAddress(
                                    addressId: index.id.toString(),
                                    context: context)
                                .then((value) {
                              showToast(value.message.toString());
                              if (value.status == true) {
                                addressController.getAddress();
                                Get.back();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          leadingWidth: AddSize.size20 * 1.6,
          backgroundColor: AppTheme.backgroundcolor,
          title: Text(
            "My Address",
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
                  Get.back();
                },
                child: Image.asset(
                  AppAssets.back,
                  height: AddSize.size20,
                )),
          ),
        ),
        // backAppBar(title: "My Address", context: context),
        body: Obx(() {
          return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: height * .01),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(ChooseAddress.chooseAddressScreen);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: AppTheme.primaryColor,
                          ),
                          SizedBox(
                            width: width * .02,
                          ),
                          const Text(
                            "Add New Address",
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
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
                                              chooseOrderAddress(addressId: addressController.myAddressModel.value.data![index].id
                                                              .toString(),
                                                      context: context)
                                                  .then((value) {
                                                if (value.status == true) {
                                                  controller.getAddToCartList();
                                                  Get.back();
                                                  Get.back();
                                                  Get.back();
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
                                                        "Flat no - ${addressController.myAddressModel.value.data![index].flatNo.toString()}, ${addressController.myAddressModel.value.data![index].street.toString().capitalizeFirst}, ${addressController.myAddressModel.value.data![index].landmark.toString().capitalizeFirst}, ${addressController.myAddressModel.value.data![index].location.toString().capitalizeFirst},",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade600,
                                                            fontSize:
                                                                AddSize.font14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      // Text(
                                                      //   addressController
                                                      //       .myAddressModel
                                                      //       .value
                                                      //       .data![index]
                                                      //       .location
                                                      //       .toString(),
                                                      //   style: const TextStyle(
                                                      //       color: AppTheme
                                                      //           .blackcolor,
                                                      //       fontSize: 16,
                                                      //       fontWeight:
                                                      //           FontWeight
                                                      //               .w500),
                                                      // ),
                                                      Row(
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              showUploadWindow(
                                                                  addressController
                                                                      .myAddressModel
                                                                      .value
                                                                      .data![index]);
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
                                  // ElevatedButton(
                                  //     onPressed: () {
                                  //       Get.toNamed(
                                  //           ChooseAddress.chooseAddressScreen);
                                  //     },
                                  //     style: ElevatedButton.styleFrom(
                                  //       minimumSize:
                                  //           const Size(double.maxFinite, 60),
                                  //       primary: AppTheme.primaryColor,
                                  //       elevation: 0,
                                  //       shape: RoundedRectangleBorder(
                                  //           borderRadius:
                                  //               BorderRadius.circular(10)),
                                  //     ),
                                  //     child: Text(
                                  //       "ADD NEW",
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .headline5!
                                  //           .copyWith(
                                  //               color: AppTheme.backgroundcolor,
                                  //               fontWeight: FontWeight.w500,
                                  //               fontSize: 18),
                                  //     )),
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
