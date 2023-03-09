import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/repositories/vendor_registration_repo.dart';
import 'package:fresh2_arrive/resources/new_helper.dart';
import 'package:fresh2_arrive/screens/vendor_screen/thank_you.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/registration_form_textField.dart';

class VendorRegistrationForm extends StatefulWidget {
  const VendorRegistrationForm({Key? key}) : super(key: key);
  static var vendorRegistrationForm = "/vendorRegistrationForm";
  @override
  State<VendorRegistrationForm> createState() => _VendorRegistrationFormState();
}

class _VendorRegistrationFormState extends State<VendorRegistrationForm> {
  final TextEditingController adharNoController = TextEditingController();
  final TextEditingController panNoController = TextEditingController();
  Rx<File> image = File("").obs;
  Rx<File> image1 = File("").obs;
  Rx<File> image2 = File("").obs;
  Rx<File> image3 = File("").obs;
  Rx<File> image4 = File("").obs;
  RxString selectedCAt = "".obs;
  final List<String> dropDownList = [
    "5",
    "10",
    "15",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
    "50"
  ];
  final _formKey = GlobalKey<FormState>();
  RxBool showValidation = false.obs;
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: "Vendor Registration", context: context),
      body: Obx(() {
        return SingleChildScrollView(
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
                                              image.value.path == "")
                                          ? Colors.grey.shade300
                                          : Colors.red,
                                    )),
                                child: image.value.path == ""
                                    ? Column(
                                        children: [
                                          Text(
                                            "Upload store image",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: AddSize.size10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              NewHelper()
                                                  .addFilePicker()
                                                  .then((value) {
                                                image.value = value;
                                              });
                                            },
                                            child: Container(
                                              height: AddSize.size45,
                                              width: AddSize.size45,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade50,
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
                                        child: Image.file(image.value)));
                          }),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          RegistrationTextField(
                            controller: adharNoController,
                            hint: "Aadhar card number",
                            keyboardType: TextInputType.number,
                            validator: validateAdhar,
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          RegistrationTextField(
                            controller: panNoController,
                            hint: "Pan card number",
                            validator: validatePan,
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 3.0),
                                  borderRadius: BorderRadius.circular(15.0)),
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
                                ? null
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
                              print(newValue);
                              showValidation.value == false;
                            },
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please select area';
                              }
                              return null;
                            },
                          ),
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
                                          SizedBox(
                                            height: AddSize.size10,
                                          ),
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
                                                  color: Colors.grey.shade50,
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
                                                  color: Colors.grey.shade50,
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
                                    fontWeight: FontWeight.w500,
                                    fontSize: AddSize.font16),
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
                                                          Colors.grey.shade50,
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
                                                          Colors.grey.shade50,
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
                                    image.value.path != "" &&
                                    image1.value.path != "" &&
                                    image2.value.path != "" &&
                                    image3.value.path != "" &&
                                    image4.value.path != "") {
                                  Map<String, String> mapData = {
                                    'aadhar_number':
                                        adharNoController.text.trim(),
                                    'pan_card_number':
                                        panNoController.text.trim(),
                                    'delivery_range': selectedCAt.value
                                  };
                                  vendorRegistrationRepo(
                                          context: context,
                                          mapData: mapData,
                                          fieldName1: "store_image",
                                          fieldName2: "bank_statement",
                                          fieldName3: "pan_card_image",
                                          fieldName4: "aadhar_card_front",
                                          fieldName5: "aadhar_card_back",
                                          file1: image.value,
                                          file2: image1.value,
                                          file3: image2.value,
                                          file4: image3.value,
                                          file5: image4.value)
                                      .then((value) {
                                    if (value.status == true) {
                                      showToast("${value.message} Wait For Admin Approval");
                                      Get.toNamed(ThankYouVendorScreen
                                          .thankYouVendorScreen);
                                    } else {
                                      showToast(value.message);
                                    }
                                  });
                                }
                                showValidation.value = true;
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.maxFinite, 60),
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
        );
      }),
    );
  }
}
