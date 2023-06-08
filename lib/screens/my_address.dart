import 'package:flutter/material.dart';
import 'package:fresh2_arrive/repositories/add_address_repository.dart';
import 'package:fresh2_arrive/screens/order/choose_address.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../resources/app_theme.dart';
import '../controller/CartController.dart';
import '../controller/GetSaveAddressController.dart';
import '../controller/MyAddress_controller.dart';
import '../controller/main_home_controller.dart';
import '../resources/app_assets.dart';
import 'Language_Change_Screen.dart';
import 'Update_Address_Screen.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key}) : super(key: key);
  static var myAddressScreen = "/myAddressScreen";

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  final addressController = Get.put(MyAddressController());
  final getSaveAddressController = Get.put(GetSaveAddressController());
  final myCartDataController = Get.put(MyCartController());
  // final controller = Get.put(MyCartDataListController());
  final mainController = Get.put(MainHomeController());
  bool isTitle=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressController.getAddress();

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
    return Directionality(
      textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffF9F9F9),
          appBar: AppBar(
            toolbarHeight: 60,
            elevation: 0,
            leadingWidth: 45,
            backgroundColor: Color(0xffF9F9F9),
            title: Text(
              "My Address".tr,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: AppTheme.blackcolor),
            ),
            leading: Padding(
              padding: locale==Locale('en','US') ? EdgeInsets.only(left: 20,):EdgeInsets.only(right: 20,),
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

                      addressController.isAddressLoad.value
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
                                                myCartDataController.model.value.data!.cartItems!.isNotEmpty ?
                                                chooseOrderAddress(addressId: addressController.myAddressModel.value.data![index].id
                                                                .toString(),
                                                        context: context)
                                                    .then((value) {
                                                  if (value.status == true) {
                                                    myCartDataController.getCartData();
                                                    Get.back();
                                                    Get.back();
                                                    Get.back();
                                                    Get.back();
                                                    mainController.onItemTap(1);
                                                  }
                                                }):null;
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
                                                        vertical: height * .03),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [


                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(addressController.myAddressModel.value.data![index].name.toString().capitalizeFirst!,
                                                                  style: GoogleFonts.ibmPlexSansArabic(fontSize: 16,
                                                                      fontWeight: FontWeight.w600,
                                                                      color:Color(0xff000000))
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                showUploadWindow(
                                                                    addressController
                                                                        .myAddressModel
                                                                        .value
                                                                        .data![index]);
                                                              },
                                                              child:
                                                              Image(
                                                                  height: 18,
                                                                  width: 18,
                                                                  image: AssetImage(
                                                                      AppAssets.deleteIcon)),
                                                            ),
                                                            SizedBox(width: 20,),
                                                            InkWell(
                                                                onTap: () {
                                                                  getSaveAddressController.addressId.value =
                                                                      addressController
                                                                          .myAddressModel
                                                                          .value
                                                                          .data![
                                                                      index]
                                                                          .id
                                                                          .toString();
                                                                  print(getSaveAddressController.addressId.value);
                                                                  Get.toNamed(
                                                                      UpdateAddressScreen
                                                                          .updateAddressScreen,
                                                                      arguments: [
                                                                        addressController
                                                                            .myAddressModel
                                                                            .value
                                                                            .data![index]
                                                                      ]);
                                                                },
                                                                child:  Image(
                                                                    height: 18,
                                                                    width: 18,
                                                                    image: AssetImage(
                                                                        AppAssets.editIcon)),
                                                            ),




                                                          ],
                                                        ),


                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          );
                                        }),
                                    SizedBox(
                                      height: height * .05,
                                    ),

                                  ],
                                )
                              : const Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.primaryColor,
                          )),

                    ],
                  ),
                ));
          }),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Get.toNamed(ChooseAddress.chooseAddressScreen);
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: AppTheme.primaryColor.withOpacity(.80),
                  minimumSize:
                  const Size(double.maxFinite, 50),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10)),
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              child: Text(
                "ADD NEW".tr,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(
                    color: AppTheme.backgroundcolor,
                    fontWeight: FontWeight.w500,
                    fontSize: AddSize.font16),
              )),
        ),
      ),

    );
  }
}
