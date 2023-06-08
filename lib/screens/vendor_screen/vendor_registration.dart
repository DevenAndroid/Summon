import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/controller/vendor_category_controller.dart';
import 'package:fresh2_arrive/repositories/vendor_registration_repo.dart';
import 'package:fresh2_arrive/resources/helper.dart';
import 'package:fresh2_arrive/resources/new_helper.dart';
import 'package:fresh2_arrive/screens/vendor_screen/add_address_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/thank_you.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/MyAddress_controller.dart';
import '../../controller/address_controller.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../resources/showDialog.dart';
import '../../widgets/registration_form_textField.dart';
import '';
import '../Language_Change_Screen.dart';

class VendorRegistrationForm extends StatefulWidget  {
  const VendorRegistrationForm({Key? key}) : super(key: key);
  static var vendorRegistrationForm = "/vendorRegistrationForm";
  @override
  State<VendorRegistrationForm> createState() => _VendorRegistrationFormState();
}

class _VendorRegistrationFormState extends State<VendorRegistrationForm> {



  final Completer<GoogleMapController> googleMapController = Completer();
  final addressController = Get.put(AddressController());
  final myAddressController = Get.put(MyAddressController());
  GoogleMapController? mapController;

  String? _currentAddress;
  String? _address = "";


  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled().then((value) {
      if (!value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
      }
      return value;
    });
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission().then((value) {
      if (value == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
      }
      return value;
    });
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission().then((value) {
        if (value == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
        }
        return value;
      });
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    await Permission.locationWhenInUse.request();
    final hasPermission = await _handleLocationPermission();
    if (hasPermission == true) {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            "lastLocation", "${position.latitude}==${position.longitude}");
        if (addressController.cameraPosition.target ==
            const LatLng(0, 0).checkLatLong) {
          print("Address is empty...........");
          await _getAddressFromLatLng(
              LatLng(position.latitude, position.longitude));
          mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 15)
              )
          );
          _onAddMarkerButtonPressed(
              LatLng(position.latitude, position.longitude).checkLatLong,
              _address!,
              allowAnimation: true);
          if (mounted) {
            setState(() {});
          }
        }
        else {
          print("Address is not empty...........");
          await _getAddressFromLatLng(
              addressController.cameraPosition.target);
          mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: addressController.cameraPosition.target,
                      zoom: 15)
              )
          );
          _onAddMarkerButtonPressed(
              addressController.cameraPosition.target, _address!,
              allowAnimation: true);
          if (mounted) {
            setState(() {});
          }
        }
      });
    }
    else {
      print("Address is not empty...........");
      await _getAddressFromLatLng(
          addressController.cameraPosition.target);
      mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: addressController.cameraPosition.target,
                  zoom: 15)
          )
      );
      _onAddMarkerButtonPressed(
          addressController.cameraPosition.target, _address!,
          allowAnimation: true);
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<String> _getAddressFromLatLng(LatLng latLong) async {
    await placemarkFromCoordinates(latLong.latitude, latLong.longitude)
        .then((List<Placemark> placemarks) {
      addressController.place = placemarks[0];
      if(mounted) {
        setState(() {
          myAddressController.latLong1 = latLong.longitude.toString();
          myAddressController.latLong2 = latLong.latitude.toString();
          print("THIS IS LONGITUDE...${latLong.longitude.toString()}");
          '${addressController.place.street}, ${addressController.place
              .subLocality}, ${addressController.place
              .subAdministrativeArea}, ${addressController.place.postalCode}';
          _address =
          '${addressController.place.subLocality}, ${addressController.place
              .subAdministrativeArea}, ${addressController.place.postalCode}';
        });
      }
    })
        .catchError((e) {
      debugPrint(e.toString());
      _currentAddress = "";
      _address = "";
    });
    if (kDebugMode) {
      print("${_currentAddress} ${_address!}");
    }
    return _address!;
  }



  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";
  GoogleMapController? mapController1;
  CameraPosition? cameraPosition;
  String location = "Search Location";
  final Set<Marker> markers = {};
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _onAddMarkerButtonPressed(LatLng lastMapPosition, markerTitle,
      {allowZoomIn = true, allowAnimation = true}) async {
    markers.clear();
    markers.add(Marker(
        markerId: MarkerId(lastMapPosition.toString()),
        position: lastMapPosition,
        infoWindow: InfoWindow(
          title: markerTitle,
        ),
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)));
    if (googleMapController.isCompleted && allowAnimation) {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: lastMapPosition, zoom: allowZoomIn ? 14 : 11)));
    }
    if(mounted) {
      setState(() {});
    }
  }

  Future<void> _updatePosition(CameraPosition position,
      {allowFetch = true}) async {
    if (allowFetch) {
      _onAddMarkerButtonPressed(
        position.target,
        await _getAddressFromLatLng(position.target),
        allowAnimation: false,
      );
    } else {
      _onAddMarkerButtonPressed(
        position.target,
        "Marker Location",
        allowAnimation: false,
      );
    }
  }
  //String? _address = "";
  final _formKey = GlobalKey<FormState>();
  //final addressController = Get.put(MyAddressController());
  //Rx<AddressData> addressModel = AddressData().obs;
  //final List<String> choiceAddress = ["Home", "Office", "Hotel", "Other"];
  //final RxBool _isValue = false.obs;
  //RxBool customTip = false.obs;
  //RxString selectedChip = "Home".obs;
  //final TextEditingController searchController = TextEditingController();
 // final Completer<GoogleMapController> googleMapController = Completer();
 // GoogleMapController? mapController;
  Rx<File> image = File("").obs;
  //String? _currentAddress;
  //String? _address = "";
  //Position? _currentPosition;
  RxBool showValidation = false.obs;
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }
  /*Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }*/
  /*Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  _currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 15)));
      _onAddMarkerButtonPressed(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          "current location");
      setState(() {});
      // location = _currentAddress!;
    }).catchError((e) {
      debugPrint(e);
    });
  }*/

  /*Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        _address =
        '${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }*/

  /*final TextEditingController otherController = TextEditingController();
  showChangeAddressSheet(AddressData addressModel) {
    final TextEditingController flatNoController =
    TextEditingController(text: addressModel.flatNo ?? "");
    final TextEditingController streetController =
    TextEditingController(text: (addressModel.street ?? ""));
    final TextEditingController recipientController = TextEditingController();
    otherController.text = addressModel.addressType ?? "Home";
    selectedChip.value = addressModel.addressType ?? "Home";
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Obx(() {
              return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isValue.value = !_isValue.value;
                              });
                              Get.back();
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const ShapeDecoration(
                                  color: AppTheme.blackcolor,
                                  shape: CircleBorder()),
                              child: Center(
                                  child: Icon(
                                    Icons.clear,
                                    color: AppTheme.backgroundcolor,
                                    size: AddSize.size30,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: AddSize.size20,
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding16,
                                  vertical: AddSize.padding16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enter complete address",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                        color: AppTheme.blackcolor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AddSize.font16),
                                  ),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      choiceAddress.length,
                                          (index) => chipList(choiceAddress[index]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  if (customTip.value)
                                    EditProfileTextFieldWidget(
                                      hint: "Other",
                                      controller: otherController,
                                    ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  EditProfileTextFieldWidget(
                                    controller: flatNoController,
                                    hint: "Flat, House no, Floor, Tower",
                                    label: "Flat, House no, Floor, Tower",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                          'Flat, House no, Floor, Tower'),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  EditProfileTextFieldWidget(
                                    controller: streetController,
                                    hint: "Street, Society, Landmark",
                                    label: "Street, Society, Landmark",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                          'Street, Society, Landmark'),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  EditProfileTextFieldWidget(
                                    controller: recipientController,
                                    hint: "Recipient’s name",
                                    label: "Recipient’s name",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Recipient’s name'),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        // if (_formKey.currentState!.validate()) {
                                        //   addressModel.street != null &&
                                        //       addressModel.flatNo != null &&
                                        //       addressModel.landmark != null
                                        //       ? editAddress(
                                        //       location: _address,
                                        //       flat_no:
                                        //       flatNoController.text,
                                        //       street:
                                        //       streetController.text,
                                        //       landmark:
                                        //       streetController.text,
                                        //       address_type:
                                        //       otherController.text,
                                        //       context: context,
                                        //       address_id: addressModel
                                        //           .id
                                        //           .toString())
                                        //       .then((value) {
                                        //     showToast(value.message);
                                        //     if (value.status == true) {
                                        //       Get.toNamed(MyAddress
                                        //           .myAddressScreen);
                                        //       addressController
                                        //           .getAddress();
                                        //       flatNoController.clear();
                                        //       streetController.clear();
                                        //       otherController.clear();
                                        //       recipientController.clear();
                                        //       selectedChip.value = "";
                                        //     }
                                        //   })
                                        //       : addAddress(
                                        //       location: _address,
                                        //       flat_no:
                                        //       flatNoController.text,
                                        //       street:
                                        //       streetController.text,
                                        //       landmark:
                                        //       streetController.text,
                                        //       address_type:
                                        //       otherController.text,
                                        //       context: context)
                                        //       .then((value) {
                                        //     showToast(value.message);
                                        //     if (value.status == true) {
                                        //       Get.toNamed(MyAddress
                                        //           .myAddressScreen);
                                        //       addressController
                                        //           .getAddress();
                                        //       flatNoController.clear();
                                        //       streetController.clear();
                                        //       otherController.clear();
                                        //       recipientController.clear();
                                        //       selectedChip.value = "";
                                        //     }
                                        //   });
                                        // }
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
                                        "SAVE ADDRESS",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                            color: AppTheme.backgroundcolor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: AddSize.font18),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          // Obx(() {
                          //   return SizedBox(
                          //     height: sizeBoxHeight.value,
                          //   );
                          // })
                        ],
                      ),
                    ),
                  )
              );
            }),
          );
        });
  }*/

  /*String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";
  GoogleMapController? mapController1; //contrller for Google map
  CameraPosition? cameraPosition;
  String location = "Search Location";
  final Set<Marker> markers = {};
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }*/

 /* Future<void> _onAddMarkerButtonPressed(LatLng lastMapPosition, markerTitle,
      {allowZoomIn = true}) async {
    final Uint8List markerIcon =
    await getBytesFromAsset(AppAssets.locationMarker, 100);
    markers.clear();
    markers.add(Marker(
        markerId: MarkerId(lastMapPosition.toString()),
        position: lastMapPosition,
        infoWindow: const InfoWindow(
          title: "",
        ),
        icon: BitmapDescriptor.fromBytes(markerIcon)));
    // BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan,)));
    if (googleMapController.isCompleted) {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: lastMapPosition, zoom: allowZoomIn ? 14 : 11)));
    }
    setState(() {});
  }*/

  final vendorCategoryController = Get.put(VendorCategoryController());

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }
  final TextEditingController storeName = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController businessIdController = TextEditingController();


  Rx<File> image1 = File("").obs;
  Rx<File> image2 = File("").obs;
  Rx<File> image3 = File("").obs;
  Rx<File> image4 = File("").obs;
  RxString selectedCAt = "".obs;
  //String? _address = "";
  bool? _isValue1 = false;
  bool? _isValue2 = false;

  //String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";
  ScrollController _scrollController = ScrollController();

  scrollNavigation(double offset) {
    _scrollController.animateTo(offset,
        duration: Duration(seconds: 1), curve: Curves.easeOutSine);
  }

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
      child: Scaffold(
        appBar: backAppBar(title: "Vendor Registration".tr, context: context),
        body:

            SingleChildScrollView(
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
                                hint: "Store Name".tr,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Store name is required')
                                ])),
                            SizedBox(
                              height: AddSize.size12,
                            ),
                            RegistrationTextField(
                              controller: phoneController,
                              hint: "Phone number".tr,
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
                            RegistrationTextField(
                              controller: businessIdController,
                              hint: "Business ID (number)".tr,
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

                            SizedBox(
                              height: AddSize.size12,
                            ),
                            RegistrationTextField(
                              readOnly: true,
                              controller: vendorCategoryController.categoryController,
                              hint: "Select Category".tr,
                              //length: 12,
                             // keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please chose category';
                                }
                                return null;
                              },
                              suffix: InkWell(onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return ShowDialogForCategories();
                                    });
                              },
                                  child: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,),),
                            ),
                            SizedBox(
                              height: AddSize.size12,
                            ),
                            Text(
                              "Store Logo".tr,
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
                                              "Upload".tr,
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
                              "Business ID".tr,
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
                                      "Upload".tr,
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
                            Text(
                              "Location".tr,
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
                        Stack(
                          children: [
                            Image.asset('assets/images/mapimg.png'),
                            Positioned(top: 50,
                              right: 150,
                              child: InkWell(onTap: (){
                                Get.toNamed(AddAddressScreen.addAddressScreen);
                              },
                                  child: CircleAvatar(backgroundColor: Colors.white,
                                      radius: 22,
                                      child: Icon((Icons.telegram),size: 30,color: Color(0xFFFE724C),))),
                            ),
                            ]
                        ),
                            SizedBox(
                              height: AddSize.padding12,
                            ),

                            SizedBox(
                              height: AddSize.size15,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                  //_address!.isNotEmpty &&
                                      image.value.path != "" &&
                                      image1.value.path != "") {
                                    var item= vendorCategoryController.model.value.data!.categories!.where((element) => element.selected == true)
                                        .map((e) => e.id.toString()).toList();
                                    Map<String, dynamic> map1={};
                                    for(var i=0; i<item.length; i++){
                                      map1[i.toString()]=item[i];
                                    }
                                    Map<String, String> mapData = {
                                      'store_name': storeName.text,
                                      'phone': phoneController.text,
                                      'latitude': myAddressController.latLong2.toString(),
                                      'longitude': myAddressController.latLong1.toString(),
                                    // 'location': _address!,
                                      'business_id': businessIdController.text,
                                      'category': jsonEncode(map1),
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
                                  /*showValidation.value = true;
                                  if (_address!.isEmpty) {
                                    scrollNavigation(10);
                                  } else if (storeName.text.trim().isEmpty) {
                                    scrollNavigation(0);
                                  }*/
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.maxFinite, 60),
                                  primary: AppTheme.primaryColor.withOpacity(.80),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text(
                                  "APPLY".tr,
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
        ),
      );
  }
}
