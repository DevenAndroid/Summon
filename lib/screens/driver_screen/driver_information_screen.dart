import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/new_helper.dart';
import 'package:fresh2_arrive/screens/vendor_screen/thank_you.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:fresh2_arrive/widgets/editprofile_textfield.dart';
import 'package:get/get.dart';
import '../../controller/driver_information_controller.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/registration_form_textField.dart';

class DriverInformation extends StatefulWidget {
  const DriverInformation({Key? key}) : super(key: key);
  static var driverInformation = "/driverInformation";

  @override
  State<DriverInformation> createState() => _DriverInformationState();
}

class _DriverInformationState extends State<DriverInformation> {
  final controller = Get.put(DriverInformationController());
  Rx<File> image = File("").obs;
  Rx<File> image1 = File("").obs;
  Rx<File> image2 = File("").obs;
  Rx<File> image3 = File("").obs;
  Rx<File> image4 = File("").obs;
  RxString selectedCAt = "".obs;
  final List<String> dropDownList = ["1KM", "2KM", "3KM"];
  final _formKey = GlobalKey<FormState>();
  RxBool showValidation = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(title: "Driver Information", context: context),
        body: Obx(() {
          if (controller.isDataLoading.value &&
              controller.model.value.data != null) {
            controller.adharNoController.text =
                controller.model.value.data!.aadharNo.toString();
            controller.panNoController.text =
                controller.model.value.data!.panNo.toString();
            controller.dateOfBirth.text =
                controller.model.value.data!.dob.toString();
            controller.vehicleNumber.text =
                controller.model.value.data!.vehicleNo.toString();
            controller.licenceNumber.text =
                controller.model.value.data!.licenceNo.toString();
          }
          return controller.isDataLoading.value &&
                  controller.model.value.data != null
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
                                  RegistrationTextField(
                                    controller: controller.dateOfBirth,
                                    hint: "Date of birth",
                                    enable: false,
                                  ),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  RegistrationTextField(
                                    controller: controller.adharNoController,
                                    hint: "Aadhar card number",
                                    enable: false,
                                  ),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  RegistrationTextField(
                                    controller: controller.panNoController,
                                    hint: "Pan card number",
                                    enable: false,
                                  ),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  RegistrationTextField(
                                    controller: controller.vehicleNumber,
                                    hint: "Vehicle number",
                                    enable: false,
                                  ),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  RegistrationTextField(
                                    controller: controller.licenceNumber,
                                    hint: "Licence number",
                                    enable: false,
                                  ),
                                  SizedBox(
                                    height: AddSize.size12,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: showValidation.value == false
                                                ? Colors.grey.shade300
                                                : Colors.red,
                                          )),
                                      child: SizedBox(
                                        height: AddSize.size125,
                                        width: AddSize.size125,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: CachedNetworkImage(
                                            imageUrl: controller
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
                                    "Upload Driving Licence",
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
                                                color: showValidation.value ==
                                                        false
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
                                                imageUrl: controller.model.value
                                                    .data!.licenceFrontImage
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
                                                color: showValidation.value ==
                                                        false
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
                                                imageUrl: controller.model.value
                                                    .data!.licenceBackImage
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: showValidation.value == false
                                                ? Colors.grey.shade300
                                                : Colors.red,
                                          )),
                                      child: SizedBox(
                                        height: AddSize.size125,
                                        width: AddSize.size125,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: CachedNetworkImage(
                                            imageUrl: controller
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
                                                color: showValidation.value ==
                                                        false
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
                                                imageUrl: controller.model.value
                                                    .data!.aadharFrontImage
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
                                                color: showValidation.value ==
                                                        false
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
                                                imageUrl: controller.model.value
                                                    .data!.aadharFrontImage
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
                                  //               fontSize: 18),
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
              : const Center(
                  child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ));
        }));
  }
}
