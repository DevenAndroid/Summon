import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/resources/new_helper.dart';
import 'package:fresh2_arrive/screens/vendor_screen/thank_you.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:fresh2_arrive/widgets/editprofile_textfield.dart';
import 'package:get/get.dart';
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
  RxString selectedCAt = "".obs;
  final List<String> DropDownList = ["1 pc", "2 pc", "3 pc"];
  final _formKey = GlobalKey<FormState>();
  RxBool showValidation = false.obs;
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  var selectedDate = DateTime.now().obs;

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dateOfBirth.text =
          DateFormat('dd-MM-yyyy').format(selectedDate.value).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(title: "Delivery Partner Apply", context: context),
        body: SingleChildScrollView(
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
                            hint: "Aadhar card number",
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Aadhar number is required'),
                            ]),
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          RegistrationTextField(
                            controller: panNoController,
                            hint: "Pan card number",
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Pan number is required'),
                            ]),
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
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Licence number is required'),
                            ]),
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
                                    image4.value.path != "") {
                                  Get.offAndToNamed(ThankYouVendorScreen
                                      .thankYouVendorScreen);
                                }
                                showValidation.value = true;
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
