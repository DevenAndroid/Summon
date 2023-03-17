import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/resources/new_helper.dart';
import 'package:fresh2_arrive/screens/vendor_screen/thank_you.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:fresh2_arrive/widgets/editprofile_textfield.dart';
import 'package:get/get.dart';
import '../../repositories/driver_resistration_repo.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/registration_form_textField.dart';
import 'package:intl/intl.dart';

class DriverRegistrationScreen extends StatefulWidget {
  const DriverRegistrationScreen({Key? key}) : super(key: key);
  static var driverRegistrationScreen = "/driverRegistrationScreen";
  @override
  State<DriverRegistrationScreen> createState() =>
      _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends State<DriverRegistrationScreen> {
  // final controller =
  final TextEditingController adharNoController = TextEditingController();
  final TextEditingController panNoController = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController vehicleNumber = TextEditingController();
  final TextEditingController licenceNumber = TextEditingController();
  Rx<File> image = File("").obs;
  Rx<File> image1 = File("").obs;
  Rx<File> image2 = File("").obs;
  Rx<File> image3 = File("").obs;
  Rx<File> image4 = File("").obs;
  Rx<File> image5 = File("").obs;
  Rx<File> image6 = File("").obs;
  RxString selectedCAt = "".obs;
  final _formKey = GlobalKey<FormState>();
  RxBool showValidation = false.obs;
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  ScrollController _scrollController = ScrollController();

  scrollNavigation(double offset) {
    _scrollController.animateTo(offset,
        duration: Duration(seconds: 1), curve: Curves.easeOutSine);
  }

  var selectedDate = DateTime.now().obs;
  DateTime today = DateTime.now();
  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(
            DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year - 18, DateTime.now().month,
            DateTime.now().day));
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dateOfBirth.text =
          DateFormat('yyyy-MM-dd').format(selectedDate.value).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(title: "Delivery Partner Apply", context: context),
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding10),
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
                            readOnly: true,
                            onTap: () {
                              selectDate();
                            },
                            controller: dateOfBirth,
                            hint: "Date of birth",
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Date of birth is required'),
                            ]),
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          RegistrationTextField(
                            controller: adharNoController,
                            length: 12,
                            hint: "Aadhar card number",
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 12) {
                                return 'Please enter 12 digit aadhar card number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          RegistrationTextField(
                            controller: panNoController,
                            hint: "Pan card number",
                            length: 10,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 10) {
                                return 'Please enter 10 digit licence card number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          RegistrationTextField(
                            controller: vehicleNumber,
                            hint: "Vehicle number",
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Vehicle number is required'),
                            ]),
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          RegistrationTextField(
                            controller: licenceNumber,
                            hint: "Licence number",
                            length: 14,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 14) {
                                return 'Please enter 14 digit licence card number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          Text(
                            "Upload Bank account statement and\ncancel cheque",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 16),
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
                                      color: !checkValidation(
                                              showValidation.value,
                                              image1.value.path == "")
                                          ? Colors.grey.shade300
                                          : Colors.red,
                                    )),
                                child: image1.value.path == ""
                                    ? Column(
                                        children: [
                                          const Text("Upload"),
                                          SizedBox(height: AddSize.size10),
                                          GestureDetector(
                                            onTap: () {
                                              NewHelper()
                                                  .addFilePicker()
                                                  .then((value) {
                                                image1.value = value;
                                              });
                                            },
                                            child: Container(
                                              height: AddSize.size45,
                                              width: AddSize.size45,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade300)),
                                              child: Center(
                                                  child: Image(
                                                      height: AddSize.size25,
                                                      width: AddSize.size25,
                                                      color:
                                                          Colors.grey.shade500,
                                                      image: const AssetImage(
                                                          AppAssets
                                                              .camaraImage))),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                                        width: double.maxFinite,
                                        height: AddSize.size100,
                                        child: Image.file(image1.value)));
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
                                    fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(
                            height: AddSize.padding12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding16,
                                        vertical: AddSize.padding16),
                                    width: AddSize.screenWidth * .38,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: !checkValidation(
                                                  showValidation.value,
                                                  image5.value.path == "")
                                              ? Colors.grey.shade300
                                              : Colors.red,
                                        )),
                                    child: image5.value.path == ""
                                        ? Column(
                                            children: [
                                              const Text("Front"),
                                              SizedBox(
                                                height: AddSize.size10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  NewHelper()
                                                      .addFilePicker()
                                                      .then((value) {
                                                    image5.value = value;
                                                  });
                                                },
                                                child: Container(
                                                  height: AddSize.size45,
                                                  width: AddSize.size45,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300)),
                                                  child: Center(
                                                      child: Image(
                                                          height:
                                                              AddSize.size25,
                                                          width: AddSize.size25,
                                                          color: Colors
                                                              .grey.shade500,
                                                          image: const AssetImage(
                                                              AppAssets
                                                                  .camaraImage))),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            width: double.maxFinite,
                                            height: AddSize.size100,
                                            child: Image.file(image5.value)));
                              }),
                              Obx(() {
                                return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding16,
                                        vertical: AddSize.padding16),
                                    width: AddSize.screenWidth * 0.38,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: !checkValidation(
                                                  showValidation.value,
                                                  image6.value.path == "")
                                              ? Colors.grey.shade300
                                              : Colors.red,
                                        )),
                                    child: image6.value.path == ""
                                        ? Column(
                                            children: [
                                              const Text("Back"),
                                              SizedBox(
                                                height: AddSize.size10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  NewHelper()
                                                      .addFilePicker()
                                                      .then((value) {
                                                    image6.value = value;
                                                  });
                                                },
                                                child: Container(
                                                  height: AddSize.size45,
                                                  width: AddSize.size45,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300)),
                                                  child: Center(
                                                      child: Image(
                                                          height:
                                                              AddSize.size25,
                                                          width: AddSize.size25,
                                                          color: Colors
                                                              .grey.shade500,
                                                          image: const AssetImage(
                                                              AppAssets
                                                                  .camaraImage))),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            width: double.maxFinite,
                                            height: AddSize.size100,
                                            child: Image.file(image6.value)));
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
                                    fontWeight: FontWeight.w500, fontSize: 16),
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
                                      color: !checkValidation(
                                              showValidation.value,
                                              image2.value.path == "")
                                          ? Colors.grey.shade300
                                          : Colors.red,
                                    )),
                                child: image2.value.path == ""
                                    ? Column(
                                        children: [
                                          const Text("Front"),
                                          SizedBox(
                                            height: AddSize.size10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              NewHelper()
                                                  .addFilePicker()
                                                  .then((value) {
                                                image2.value = value;
                                              });
                                            },
                                            child: Container(
                                              height: AddSize.size45,
                                              width: AddSize.size45,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade300)),
                                              child: Center(
                                                  child: Image(
                                                      height: AddSize.size25,
                                                      width: AddSize.size25,
                                                      color:
                                                          Colors.grey.shade500,
                                                      image: const AssetImage(
                                                          AppAssets
                                                              .camaraImage))),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                                        width: double.maxFinite,
                                        height: AddSize.size100,
                                        child: Image.file(image2.value)));
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
                                    fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(
                            height: AddSize.padding12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding16,
                                        vertical: AddSize.padding16),
                                    width: AddSize.screenWidth * .38,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: !checkValidation(
                                                  showValidation.value,
                                                  image3.value.path == "")
                                              ? Colors.grey.shade300
                                              : Colors.red,
                                        )),
                                    child: image3.value.path == ""
                                        ? Column(
                                            children: [
                                              const Text("Front"),
                                              SizedBox(
                                                height: AddSize.size10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  NewHelper()
                                                      .addFilePicker()
                                                      .then((value) {
                                                    image3.value = value;
                                                  });
                                                },
                                                child: Container(
                                                  height: AddSize.size45,
                                                  width: AddSize.size45,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300)),
                                                  child: Center(
                                                      child: Image(
                                                          height:
                                                              AddSize.size25,
                                                          width: AddSize.size25,
                                                          color: Colors
                                                              .grey.shade500,
                                                          image: const AssetImage(
                                                              AppAssets
                                                                  .camaraImage))),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            width: double.maxFinite,
                                            height: AddSize.size100,
                                            child: Image.file(image3.value)));
                              }),
                              Obx(() {
                                return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AddSize.padding16,
                                        vertical: AddSize.padding16),
                                    width: AddSize.screenWidth * 0.38,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: !checkValidation(
                                                  showValidation.value,
                                                  image4.value.path == "")
                                              ? Colors.grey.shade300
                                              : Colors.red,
                                        )),
                                    child: image4.value.path == ""
                                        ? Column(
                                            children: [
                                              const Text("Back"),
                                              SizedBox(
                                                height: AddSize.size10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  NewHelper()
                                                      .addFilePicker()
                                                      .then((value) {
                                                    image4.value = value;
                                                  });
                                                },
                                                child: Container(
                                                  height: AddSize.size45,
                                                  width: AddSize.size45,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300)),
                                                  child: Center(
                                                      child: Image(
                                                          height:
                                                              AddSize.size25,
                                                          width: AddSize.size25,
                                                          color: Colors
                                                              .grey.shade500,
                                                          image: const AssetImage(
                                                              AppAssets
                                                                  .camaraImage))),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            width: double.maxFinite,
                                            height: AddSize.size100,
                                            child: Image.file(image4.value)));
                              }),
                            ],
                          ),
                          SizedBox(
                            height: AddSize.size15,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    image1.value.path != "" &&
                                    image2.value.path != "" &&
                                    image3.value.path != "" &&
                                    image4.value.path != "" &&
                                    image5.value.path != "" &&
                                    image6.value.path != "") {
                                  Map<String, String> mapData = {
                                    'aadhar_number':
                                        adharNoController.text.trim(),
                                    'pan_card_number':
                                        panNoController.text.trim(),
                                    'dob': dateOfBirth.text,
                                    'vehicle_no': vehicleNumber.text,
                                    'licence_no': licenceNumber.text
                                  };
                                  driverRegistrationRepo(
                                    context: context,
                                    mapData: mapData,
                                    fieldName1: "bank_statement",
                                    fieldName2: "pan_card_image",
                                    fieldName3: "aadhar_front_image",
                                    fieldName4: "aadhar_back_image",
                                    fieldName5: "licence_front_image",
                                    fieldName6: "licence_back_image",
                                    file1: image1.value,
                                    file2: image2.value,
                                    file3: image3.value,
                                    file4: image4.value,
                                    file5: image5.value,
                                    file6: image6.value,
                                  ).then((value) {
                                    if (value.status == true) {
                                      showToast(
                                          "${value.message} Wait For Admin Approval");
                                      Get.toNamed(ThankYouVendorScreen
                                          .thankYouVendorScreen);
                                    } else {
                                      showToast(value.message);
                                    }
                                  });
                                }
                                showValidation.value = true;
                                if (dateOfBirth.text.isEmpty) {
                                  scrollNavigation(0);
                                } else if (adharNoController.text
                                        .trim()
                                        .isEmpty ||
                                    adharNoController.text.length < 12) {
                                  scrollNavigation(50);
                                } else if (panNoController.text
                                        .trim()
                                        .isEmpty ||
                                    panNoController.text.length < 10) {
                                  scrollNavigation(50);
                                } else if (vehicleNumber.text.trim().isEmpty ||
                                    vehicleNumber.text.length < 14) {
                                  scrollNavigation(50);
                                } else if (licenceNumber.text.trim().isEmpty) {
                                  scrollNavigation(50);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.maxFinite, 60),
                                primary: AppTheme.primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
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
        ));
  }
}
