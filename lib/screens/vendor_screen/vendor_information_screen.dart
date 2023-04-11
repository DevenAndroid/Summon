import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/controller/home_page_controller.dart';
import 'package:fresh2_arrive/controller/store_controller.dart';
import 'package:fresh2_arrive/model/time_model.dart';
import 'package:fresh2_arrive/repositories/vendor_registration_repo.dart';
import 'package:fresh2_arrive/screens/vendor_screen/thank_you.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import '../../controller/VendorInformation_Controller.dart';
import '../../controller/main_home_controller.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../resources/new_helper.dart';
import '../../widgets/registration_form_textField.dart';

class VendorInformation extends StatefulWidget {
  const VendorInformation({Key? key}) : super(key: key);
  static var vendorInformation = "/vendorInformation";

  @override
  State<VendorInformation> createState() => _VendorInformationState();
}

class _VendorInformationState extends State<VendorInformation> {
  final vendorInformationController = Get.put(VendorInformationController());
  final controller = Get.put(MainHomeController());
  final homeController = Get.put(HomePageController());
  final storeController = Get.put(StoreController());
  Rx<File> image = File("").obs;
  Rx<File> image1 = File("").obs;
  Rx<File> image2 = File("").obs;
  Rx<File> image3 = File("").obs;
  Rx<File> image4 = File("").obs;
  RxString selectedCAt = "".obs;
  final List<String> dropDownList = [
    "500",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
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

  @override
  void initState() {
    super.initState();
    vendorInformationController.getVendorInformation();
  }

  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";
  ScrollController _scrollController = ScrollController();

  scrollNavigation(double offset) {
    _scrollController.animateTo(offset,
        duration: Duration(seconds: 1), curve: Curves.easeOutSine);
  }

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
      appBar: backAppBar(title: "Vendor Information", context: context),
      body: Obx(() {
        return vendorInformationController.isDataLoading.value
            ? SingleChildScrollView(
                controller: _scrollController,
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
                                  height: AddSize.size12,
                                ),
                                RegistrationTextField(
                                    controller:
                                        vendorInformationController.storeName,
                                    hint: "Store Name",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Store name is required')
                                    ])),
                                SizedBox(
                                  height: AddSize.size12,
                                ),
                                RegistrationTextField(
                                  readOnly: true,
                                    controller:
                                    vendorInformationController.addressController,
                                    hint: "Store Address",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Store name is required')
                                    ])),
                                SizedBox(
                                  height: AddSize.size12,
                                ),
                                InkWell(
                                    onTap: () async {
                                      var place = await PlacesAutocomplete.show(
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
                                          vendorInformationController
                                                  .locationController.text =
                                              (place.description ?? "Location")
                                                  .toString();
                                        });
                                        final plist = GoogleMapsPlaces(
                                          apiKey: googleApikey,
                                          apiHeaders:
                                              await const GoogleApiHeaders()
                                                  .getHeaders(),
                                        );
                                        print(plist);
                                        String placeid = place.placeId ?? "0";
                                        final detail = await plist
                                            .getDetailsByPlaceId(placeid);
                                        final geometry =
                                            detail.result.geometry!;
                                        final lat = geometry.location.lat;
                                        final lang = geometry.location.lng;
                                        setState(() {
                                          vendorInformationController
                                                  .locationController.text =
                                              (place.description ?? "Location")
                                                  .toString();
                                        });
                                      }
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: !checkValidation(
                                                            showValidation
                                                                .value,
                                                            vendorInformationController
                                                                    .locationController
                                                                    .text ==
                                                                "")
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
                                                (vendorInformationController.locationController.text ?? "Location").toString(),
                                                style: TextStyle(
                                                    fontSize: AddSize.font14),
                                              ),
                                              trailing:
                                                  const Icon(Icons.search),
                                              dense: true,
                                            )),
                                        checkValidation(
                                                showValidation.value,
                                                vendorInformationController
                                                        .locationController
                                                        .text ==
                                                    "")
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    top: AddSize.size5),
                                                child: Text(
                                                  "      Location is required",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.red.shade700,
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
                                  controller: vendorInformationController
                                      .adharNoController,
                                  hint: vendorInformationController
                                      .model.value.data!.aadharNo
                                      .toString(),
                                  enable: false,
                                ),
                                SizedBox(
                                  height: AddSize.size12,
                                ),
                                RegistrationTextField(
                                  controller: vendorInformationController
                                      .panNoController,
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
                                    items: area.map((value) {
                                      return DropdownMenuItem(
                                        value: value.key.toString(),
                                        child: Text(
                                          value.value.toString(),
                                          style: TextStyle(
                                              fontSize: AddSize.font14),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      selectedCAt.value = newValue.toString();
                                      showValidation.value == false;
                                    },
                                    // validator: (String? value) {
                                    //   if (value?.isEmpty ?? true) {
                                    //     return 'Please select area';
                                    //   }
                                    //   return null;
                                    // },
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
                                          color: Colors.grey.shade300,
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
                                          color: Colors.grey.shade300,
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
                                              color: Colors.grey.shade300,
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
                                              color: Colors.grey.shade300,
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
                                ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        vendorInformationEditRepo(
                                                storeName:
                                                    vendorInformationController
                                                        .storeName.text,
                                                location:
                                                    vendorInformationController
                                                        .locationController
                                                        .text,
                                                context: context)
                                            .then((value) {
                                          showToast(value.message.toString());
                                          if (value.status == true) {
                                            homeController.getData();
                                            storeController.getData();
                                          }
                                        });
                                        Get.back();
                                        Get.back();
                                        Get.back();
                                        Get.back();
                                        controller.onItemTap(2);
                                      } else {
                                        showValidation.value = true;
                                        if (vendorInformationController
                                            .storeName.text
                                            .trim()
                                            .isEmpty) {
                                          scrollNavigation(0);
                                        } else if (vendorInformationController
                                            .locationController.text
                                            .trim()
                                            .isEmpty) {
                                          scrollNavigation(10);
                                        }
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
                                              fontSize: AddSize.font18),
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
            : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
