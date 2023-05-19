import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../../controller/driver_information_controller.dart';
import '../../repositories/driver_imformation_repo.dart';
import '../../repositories/vendor_registration_repo.dart';
import '../../resources/app_theme.dart';
import '../../resources/new_helper.dart';
import '../../widgets/registration_form_textField.dart';
import '../vendor_screen/thank_you.dart';

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

  RxString selectedCAt = "".obs;
  final List<String> dropDownList = ["1KM", "2KM", "3KM"];
  final _formKey = GlobalKey<FormState>();
  RxBool showValidation = false.obs;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: backAppBar(title: "Driver Information", context: context),
          body: Obx(() {
            if (controller.isDataLoading.value &&
                controller.model.value.data != null) {
              controller.nationalId.text =
                  controller.model.value.data!.nationalId.toString();
              controller.make.text =
                  controller.model.value.data!.make.toString();
              controller.dateOfBirth.text =
                  controller.model.value.data!.dob.toString();
              controller.modelController.text =
                  controller.model.value.data!.model.toString();
              controller.colorController.text =
                  controller.model.value.data!.color.toString();
              controller.carYearController.text =
                  controller.model.value.data!.carYear.toString();
            }
            return controller.isDataLoading.value &&
                    controller.model.value.data != null
                ?
            SingleChildScrollView(
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
                                      controller: controller.nationalId,
                                      hint: "National Id is Required",
                                      enable: false,
                                    ),
                                    SizedBox(
                                      height: AddSize.size12,
                                    ),
                                    Text(
                                      "Vehicle Details",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                          fontWeight: FontWeight.w500, fontSize: 16,color: Color(0xff2F2F2F)),
                                    ),
                                    SizedBox(
                                      height: AddSize.size5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RegistrationTextField(
                                            controller: controller.carYearController,
                                            hint: "Car Year",
                                            length: 10,
                                            validator: (value) {
                                              if (value!.isEmpty || value.length < 4) {
                                                return 'Please enter 10 digit licence card number';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: AddSize.size12,
                                        ),
                                        Expanded(
                                          child: RegistrationTextField(
                                            controller: controller.make,
                                            hint: "Make",
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText: 'Vehicle number is required'),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: AddSize.size12,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RegistrationTextField(
                                            controller: controller.modelController,
                                            hint: "Model",
                                            length: 10,
                                            validator: (value) {
                                              if (value!.isEmpty || value.length < 4) {
                                                return 'Please enter 10 digit licence card number';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: AddSize.size12,
                                        ),
                                        Expanded(
                                          child: RegistrationTextField(
                                            controller: controller.colorController,
                                            hint: "Color",
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText: 'Vehicle number is required'),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: AddSize.size12,
                                    ),
                                    Text(
                                      "License plate",
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
                                                controller
                                                    .model
                                                    .value
                                                    .data!
                                                    .numberPlate
                                                    .toString(),
                                                errorWidget: (_, __, ___) =>
                                                const SizedBox(),
                                                placeholder: (_, __) =>
                                                const SizedBox(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: AddSize.padding10,
                                            top: AddSize.padding10,
                                            child: GestureDetector(
                                              onTap: () {
                                                NewHelper()
                                                    .addFilePicker()
                                                    .then((value) {
                                                  image.value = value;
                                                });
                                              },
                                              child: Container(
                                                height: AddSize.size30,
                                                width: AddSize.size30,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppTheme
                                                            .backgroundcolor),
                                                    color:
                                                    AppTheme.primaryColor,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        50)),
                                                child: const Center(
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: AppTheme
                                                          .backgroundcolor,
                                                      size: 20,
                                                    )),
                                              ),
                                            ),
                                          ),
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
                                                color: Colors.grey.shade300)),
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
                                      height: AddSize.padding12,
                                    ),
                                    Text(
                                      "Upload Driver Licence",
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
                                        Expanded(
                                          child:
                                          Obx(() {
                                            return image1.value.path == ""
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
                                                      controller
                                                          .model
                                                          .value
                                                          .data!
                                                          .licenceFrontImage
                                                          .toString(),
                                                      errorWidget: (_, __, ___) =>
                                                      const SizedBox(),
                                                      placeholder: (_, __) =>
                                                      const SizedBox(),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: AddSize.padding10,
                                                  top: AddSize.padding10,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      NewHelper()
                                                          .addFilePicker()
                                                          .then((value) {
                                                        image1.value = value;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: AddSize.size30,
                                                      width: AddSize.size30,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: AppTheme
                                                                  .backgroundcolor),
                                                          color:
                                                          AppTheme.primaryColor,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                      child: const Center(
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: AppTheme
                                                                .backgroundcolor,
                                                            size: 20,
                                                          )),
                                                    ),
                                                  ),
                                                ),
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
                                                      color: Colors.grey.shade300)),
                                              child: SizedBox(
                                                height: AddSize.size125,
                                                width: AddSize.screenWidth,
                                                child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(16),
                                                    child: Image.file(image1.value)),
                                              ),
                                            );
                                          }),
                                        ),
                                        SizedBox(width: AddSize.size10,),
                                        Expanded(
                                          child:
                                          Obx(() {
                                            return image2.value.path == ""
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
                                                      controller
                                                          .model
                                                          .value
                                                          .data!
                                                          .licenceBackImage
                                                          .toString(),
                                                      errorWidget: (_, __, ___) =>
                                                      const SizedBox(),
                                                      placeholder: (_, __) =>
                                                      const SizedBox(),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: AddSize.padding10,
                                                  top: AddSize.padding10,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      NewHelper()
                                                          .addFilePicker()
                                                          .then((value) {
                                                        image2.value = value;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: AddSize.size30,
                                                      width: AddSize.size30,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: AppTheme
                                                                  .backgroundcolor),
                                                          color:
                                                          AppTheme.primaryColor,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                      child: const Center(
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: AppTheme
                                                                .backgroundcolor,
                                                            size: 20,
                                                          )),
                                                    ),
                                                  ),
                                                ),
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
                                                      color: Colors.grey.shade300)),
                                              child: SizedBox(
                                                height: AddSize.size125,
                                                width: AddSize.screenWidth,
                                                child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(16),
                                                    child: Image.file(image2.value)),
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: AddSize.size15,
                                    ),

                                    SizedBox(
                                      height: AddSize.size15,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            Map<String, String> mapData = {
                                              'national_id': controller.nationalId.text
                                                  .trim().toString(),
                                              'car_year': controller.carYearController.text
                                                  .trim().toString(),
                                              'make':
                                              controller.make.text
                                                  .trim(),
                                              'model': controller.modelController.text
                                                  .trim(),
                                              'color': controller.colorController.text
                                                  .trim(),
                                              'dob': controller.dateOfBirth.text
                                                  .trim(),


                                            };
                                            driverUpdateInformationRepo(
                                              context: context,
                                                mapData: mapData,
                                                fieldName1: "number_plate",
                                                fieldName2: "licence_front_image",
                                                fieldName3: "licence_back_image",
                                                file1:image.value,
                                                file2: image1.value,
                                                file3: image2.value,
                                              )
                                                .then((value) {
                                              if (value.status == true) {
                                                showToast(value.message);
                                                controller.getData();
                                              } else {
                                                showToast(value.message);
                                              }
                                            });
                                          }
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
                                          "APPLY",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  color: AppTheme.backgroundcolor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                        )),
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
          })),
    );
  }
}
