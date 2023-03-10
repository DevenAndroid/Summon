import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/new_helper.dart';
import 'package:fresh2_arrive/screens/vendor_screen/thank_you.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../../controller/VendorInformation_Controller.dart';
import '../../resources/app_theme.dart';
import '../../widgets/registration_form_textField.dart';

class VendorInformation extends StatefulWidget {
  const VendorInformation({Key? key}) : super(key: key);
  static var vendorInformation = "/vendorInformation";

  @override
  State<VendorInformation> createState() => _VendorInformationState();
}

class _VendorInformationState extends State<VendorInformation> {
  final vendorInformationController = Get.put(VendorInformationController());
  final TextEditingController adharNoController = TextEditingController();
  final TextEditingController panNoController = TextEditingController();
  Rx<File> image = File("").obs;
  Rx<File> image1 = File("").obs;
  Rx<File> image2 = File("").obs;
  Rx<File> image3 = File("").obs;
  Rx<File> image4 = File("").obs;
  RxString selectedCAt = "".obs;
  final List<String> dropDownList = ["5",
    "10",
    "15",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
    "50"];
  final _formKey = GlobalKey<FormState>();
  RxBool showValidation = false.obs;

  @override
  void initState() {
    super.initState();
    vendorInformationController.getVendorInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: "Vendor Information", context: context),
      body: Obx(() {
        return vendorInformationController.isDataLoading.value
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AddSize.padding16,
                      vertical: AddSize.padding10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AddSize.padding16,
                                vertical: AddSize.padding10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return image.value.path == ""
                                      ? Stack(
                                          children: [
                                            SizedBox(
                                              height: AddSize.size125,
                                              width: AddSize.screenWidth,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      vendorInformationController
                                                          .model
                                                          .value
                                                          .data!
                                                          .storeImage
                                                          .toString(),
                                                  errorWidget: (_, __, ___) =>
                                                      const SizedBox(),
                                                  placeholder: (_, __) =>
                                                      const SizedBox(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            // Positioned(
                                            //   right: AddSize.padding10,
                                            //   top: AddSize.padding10,
                                            //   child: GestureDetector(
                                            //     onTap: () {
                                            //       NewHelper()
                                            //           .addFilePicker()
                                            //           .then((value) {
                                            //         image.value = value;
                                            //       });
                                            //     },
                                            //     child: Container(
                                            //       height: AddSize.size30,
                                            //       width: AddSize.size30,
                                            //       decoration: BoxDecoration(
                                            //           border: Border.all(
                                            //               width: 1,
                                            //               color: AppTheme
                                            //                   .backgroundcolor),
                                            //           color:
                                            //               AppTheme.primaryColor,
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   50)),
                                            //       child: const Center(
                                            //           child: Icon(
                                            //         Icons.edit,
                                            //         color: AppTheme
                                            //             .backgroundcolor,
                                            //         size: 20,
                                            //       )),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        )
                                      : Container(
                                          width: double.maxFinite,
                                          height: AddSize.size100,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: AddSize.padding16,
                                              vertical: AddSize.padding16),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: showValidation.value ==
                                                        false
                                                    ? Colors.grey.shade300
                                                    : Colors.red,
                                              )),
                                          child: SizedBox(
                                            height: AddSize.size125,
                                            width: AddSize.screenWidth,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.file(image.value)),
                                          ),
                                        );
                                }),
                                SizedBox(
                                  height: AddSize.size12,
                                ),
                                RegistrationTextField(
                                  controller: adharNoController,
                                  hint: vendorInformationController
                                      .model.value.data!.aadharNo
                                      .toString(),
                                  enable: false,
                                ),
                                SizedBox(
                                  height: AddSize.size12,
                                ),
                                RegistrationTextField(
                                  controller: panNoController,
                                  hint: vendorInformationController
                                      .model.value.data!.panNo
                                      .toString(),
                                  enable: false,
                                ),
                                SizedBox(
                                  height: AddSize.size12,
                                ),
                                Obx(() {
                                  return DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.shade50,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                      // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade300),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 3.0),
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      enabled: true,
                                    ),
                                    isExpanded: true,
                                    hint: Text(
                                      'Select Areas',
                                      style: TextStyle(
                                          color: AppTheme.userText,
                                          fontSize: AddSize.font14),
                                    ),
                                    value: selectedCAt.value == ""
                                        ? vendorInformationController
                                        .model.value.data!.deliveryRange
                                        .toString()
                                        : selectedCAt.value,
                                    items: dropDownList.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          "${value}KM",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      selectedCAt.value = newValue.toString();
                                      showValidation.value == false;
                                    },
                                    validator: (String? value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'Please select area';
                                      }
                                      return null;
                                    },
                                  );
                                }),
                                SizedBox(
                                  height: AddSize.padding12,
                                ),
                                Text(
                                  "Upload Bank account statement and cancel cheque",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: AddSize.font16),
                                ),
                                SizedBox(
                                  height: AddSize.padding12,
                                ),
                                Obx(() {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding16,
                                        vertical: AddSize.padding16),
                                    width: AddSize.screenWidth,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: showValidation.value == false
                                              ? Colors.grey.shade300
                                              : Colors.red,
                                        )),
                                    child: SizedBox(
                                      height: AddSize.size125,
                                      width: AddSize.size125,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CachedNetworkImage(
                                          imageUrl: vendorInformationController
                                              .model.value.data!.bankStatement
                                              .toString(),
                                          errorWidget: (_, __, ___) =>
                                              const SizedBox(),
                                          placeholder: (_, __) =>
                                              const SizedBox(),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                SizedBox(
                                  height: AddSize.padding12,
                                ),
                                Text(
                                  "Upload Pan Card",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: AddSize.font16),
                                ),
                                SizedBox(
                                  height: AddSize.padding12,
                                ),
                                Obx(() {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding16,
                                        vertical: AddSize.padding16),
                                    width: AddSize.screenWidth,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: showValidation.value == false
                                              ? Colors.grey.shade300
                                              : Colors.red,
                                        )),
                                    child: SizedBox(
                                      height: AddSize.size125,
                                      width: AddSize.size125,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CachedNetworkImage(
                                          imageUrl: vendorInformationController
                                              .model.value.data!.panCardImage
                                              .toString(),
                                          errorWidget: (_, __, ___) =>
                                              const SizedBox(),
                                          placeholder: (_, __) =>
                                              const SizedBox(),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                SizedBox(
                                  height: AddSize.padding12,
                                ),
                                Text(
                                  "Upload Adhar Card",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: AddSize.font16),
                                ),
                                SizedBox(
                                  height: AddSize.padding12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AddSize.padding16,
                                            vertical: AddSize.padding16),
                                        width: AddSize.size50 * 3,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color:
                                                  showValidation.value == false
                                                      ? Colors.grey.shade300
                                                      : Colors.red,
                                            )),
                                        child: SizedBox(
                                          height: AddSize.size125,
                                          width: AddSize.size100,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  vendorInformationController
                                                      .model
                                                      .value
                                                      .data!
                                                      .aadharFrontImage
                                                      .toString(),
                                              errorWidget: (_, __, ___) =>
                                                  const SizedBox(),
                                              placeholder: (_, __) =>
                                                  const SizedBox(),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    Obx(() {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AddSize.padding16,
                                            vertical: AddSize.padding16),
                                        width: AddSize.size50 * 3,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color:
                                                  showValidation.value == false
                                                      ? Colors.grey.shade300
                                                      : Colors.red,
                                            )),
                                        child: SizedBox(
                                          height: AddSize.size125,
                                          width: AddSize.size100,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  vendorInformationController
                                                      .model
                                                      .value
                                                      .data!
                                                      .aadharBackImage
                                                      .toString(),
                                              errorWidget: (_, __, ___) =>
                                                  const SizedBox(),
                                              placeholder: (_, __) =>
                                                  const SizedBox(),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                                SizedBox(
                                  height: AddSize.size15,
                                ),
                                // ElevatedButton(
                                //     onPressed: () {
                                //       if (_formKey.currentState!.validate()) {
                                //         Get.toNamed(ThankYouVendorScreen
                                //             .thankYouVendorScreen);
                                //       }
                                //       //         selectedCAt.value == "" &&
                                //       //         image.value == null ||
                                //       //     image1.value == null ||
                                //       //     image2.value == null ||
                                //       //     image3.value == null ||
                                //       //     image4.value == null) {
                                //       //   Get.toNamed(ThankYouVendorScreen
                                //       //       .thankYouVendorScreen);
                                //       // } else {
                                //       //   showValidation.value = true;
                                //       //   setState(() {});
                                //       // }
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
                                //       "APPLY",
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .headline5!
                                //           .copyWith(
                                //               color: AppTheme.backgroundcolor,
                                //               fontWeight: FontWeight.w500,
                                //               fontSize: AddSize.font18),
                                //     )),
                                SizedBox(
                                  height: AddSize.size15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
