import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/model/time_model.dart';
import 'package:fresh2_arrive/repositories/vendor_registration_repo.dart';
import 'package:fresh2_arrive/resources/new_helper.dart';
import 'package:fresh2_arrive/screens/vendor_screen/thank_you.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
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
  final TextEditingController storeName = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController businessIdController = TextEditingController();
  Rx<File> image = File("").obs;
  Rx<File> image1 = File("").obs;
  Rx<File> image2 = File("").obs;
  Rx<File> image3 = File("").obs;
  Rx<File> image4 = File("").obs;
  RxString selectedCAt = "".obs;
  String? _address = "";
  bool? _isValue1 = false;
  bool? _isValue2 = false;
  final _formKey = GlobalKey<FormState>();
  RxBool showValidation = false.obs;
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";
  ScrollController _scrollController = ScrollController();

  scrollNavigation(double offset) {
    _scrollController.animateTo(offset,
        duration: Duration(seconds: 1), curve: Curves.easeOutSine);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: backAppBar(title: "Vendor Registration", context: context),
        body: Obx(() {
          return SingleChildScrollView(
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
                                controller: storeName,
                                hint: "Store Name",
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Store name is required')
                                ])),
                            SizedBox(
                              height: AddSize.size12,
                            ),
                            RegistrationTextField(
                              controller: phoneController,
                              hint: "Phone number",
                              length: 10,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 10) {
                                  return 'Please enter 12 digit Aadhaar card number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: AddSize.size12,
                            ),
                            InkWell(
                                onTap: () async {
                                  var place = await PlacesAutocomplete.show(
                                      hint: "Location",
                                      context: context,
                                      apiKey: googleApikey,
                                      mode: Mode.overlay,
                                      types: [],
                                      strictbounds: false,
                                      onError: (err) {
                                        log("error.....   ${err.errorMessage}");
                                      });
                                  if (place != null) {
                                    setState(() {
                                      _address = (place.description ?? "Location")
                                          .toString();
                                    });
                                    final plist = GoogleMapsPlaces(
                                      apiKey: googleApikey,
                                      apiHeaders: await const GoogleApiHeaders()
                                          .getHeaders(),
                                    );
                                    print(plist);
                                    String placeid = place.placeId ?? "0";
                                    final detail =
                                    await plist.getDetailsByPlaceId(placeid);
                                    final geometry = detail.result.geometry!;
                                    final lat = geometry.location.lat;
                                    final lang = geometry.location.lng;
                                    setState(() {
                                      _address = (place.description ?? "Location")
                                          .toString();
                                    });
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: !checkValidation(
                                                    showValidation.value,
                                                    _address == "")
                                                    ? Colors.grey.shade300
                                                    : Colors.red),
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            color: Colors.grey.shade50),
                                        // width: MediaQuery.of(context).size.width - 40,
                                        child: ListTile(
                                          leading: Image.asset(
                                            AppAssets.drawer_location,
                                            width: AddSize.size15,
                                          ),
                                          title: Text(
                                            _address ?? "Location".toString(),
                                            style: TextStyle(
                                                fontSize: AddSize.font14),
                                          ),
                                          trailing: const Icon(Icons.search),
                                          dense: true,
                                        )),
                                    checkValidation(
                                        showValidation.value, _address == "")
                                        ? Padding(
                                      padding: EdgeInsets.only(
                                          top: AddSize.size5),
                                      child: Text(
                                        "      Location is required",
                                        style: TextStyle(
                                            color: Colors.red.shade700,
                                            fontSize: AddSize.font12),
                                      ),
                                    )
                                        : SizedBox()
                                  ],
                                )),
                            SizedBox(
                              height: AddSize.size12,
                            ),
                            RegistrationTextField(
                              controller: businessIdController,
                              hint: "Business ID (number)",
                              length: 12,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 12) {
                                  return 'Please enter 12 digit Business ID (number)';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: AddSize.size12,
                            ),
                            Text(
                              "Store Logo",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AddSize.font16,color: Color(0xff2F2F2F)),
                            ),
                            SizedBox(
                              height: AddSize.size12,
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
                                                image.value.path == "")
                                            ? Colors.grey.shade300
                                            : Colors.red,
                                      )),
                                  child: image.value.path == ""
                                      ?
                                  Column(
                                          children: [
                                            Text(
                                              "Upload",
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

                                      : Stack(
                                    children: [
                                      SizedBox(
                                          width: double.maxFinite,
                                          height: AddSize.size100,
                                          child: Image.file(image.value)),

                                      Positioned(
                                        right: 0,
                                        top: 0,
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
                                  ),
                              );
                            }),
                            SizedBox(
                              height: AddSize.size12,
                            ),
                            Text(
                              "Business ID One Image ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AddSize.font16,color: Color(0xff2F2F2F)),
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
                                    ?
                                Column(
                                  children: [
                                    Text(
                                      "Upload",
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

                                    : Stack(
                                  children: [
                                    SizedBox(
                                        width: double.maxFinite,
                                        height: AddSize.size100,
                                        child: Image.file(image1.value)),

                                    Positioned(
                                      right: 0,
                                      top: 0,
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
                                ),
                              );
                            }),
                            SizedBox(
                              height: AddSize.size15,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    side: BorderSide(
                                        color: showValidation == false
                                            ? AppTheme.primaryColor
                                            : Colors.red,
                                        width: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: _isValue1,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isValue1 = value;
                                      });
                                    }),
                                Expanded(
                                    child: Text(
                                      "? Using imported  meats",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,color: Color(0xff1D303A)),
                                    ))
                              ],
                            ),

                            Row(
                              children: [
                                Checkbox(
                                    side: BorderSide(
                                        color: showValidation == false
                                            ? AppTheme.primaryColor.withOpacity(.80)
                                            : Colors.red,
                                        width: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: _isValue2,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isValue2 = value;
                                      });
                                    }),
                                Expanded(
                                    child: Text(
                                      "? Using imported  Chicken",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,color: Color(0xff1D303A)),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: AddSize.size15,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() && _isValue1==true &&
                                      _address!.isNotEmpty &&
                                      image.value.path != "" &&
                                      image1.value.path != "") {
                                    Map<String, String> mapData = {
                                      'store_name': storeName.text,
                                      'phone': phoneController.text,
                                      'location': _address!,
                                      'business_id': businessIdController.text,
                                      'imported_meat': '',
                                      'imported_chicken': ''
                                    };
                                    vendorRegistrationRepo(
                                            context: context,
                                            mapData: mapData,
                                            fieldName1: "store_image",
                                            fieldName2: "business_id_image",

                                            file1: image.value,
                                            file2: image1.value,
                                            )
                                        .then((value) {
                                      if (value.status == true) {
                                        showToast(
                                            "${value.message} Wait For Admin Approval");
                                        log(value.status.toString());
                                        Get.toNamed(ThankYouVendorScreen
                                            .thankYouVendorScreen);
                                      } else {
                                        showToast(value.message);
                                      }
                                    });
                                  }
                                  showValidation.value = true;
                                  if (_address!.isEmpty) {
                                    scrollNavigation(10);
                                  } else if (storeName.text.trim().isEmpty) {
                                    scrollNavigation(0);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.maxFinite, 60),
                                  primary: AppTheme.primaryColor.withOpacity(.80),
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
      ),
    );
  }
}
