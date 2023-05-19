import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/controller/vendor_category_controller.dart';
import 'package:fresh2_arrive/model/time_model.dart';
import 'package:fresh2_arrive/repositories/vendor_categories_repo.dart';
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
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/MyAddress_controller.dart';
import '../../controller/address_controller.dart';
import '../../model/MyAddressModel.dart';
import '../../model/vendor_category_model.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../resources/showDialog.dart';
import '../../widgets/editprofile_textfield.dart';
import '../../widgets/registration_form_textField.dart';
import '';

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
          mapController!.animateCamera(
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
      })
          .catchError((e) {
        debugPrint(e);
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
          _currentAddress =
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
      print("${_currentAddress!} ${_address!}");
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
 // bool _value = false;

  /*List checkListItems = [
    {
      "id": 0,
      "value": false,
      "title": "Sunday",
    },
    {
      "id": 1,
      "value": false,
      "title": "Monday",
    },
    {
      "id": 2,
      "value": false,
      "title": "Tuesday",
    },
    {
      "id": 3,
      "value": false,
      "title": "Wednesday",
    },
    {
      "id": 4,
      "value": false,
      "title": "Thursday",
    },
    {
      "id": 5,
      "value": false,
      "title": "Friday",
    },
    {
      "id": 6,
      "value": false,
      "title": "Saturday",
    },
  ];*/
  //maps
  /*Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGoogle = CameraPosition(
    target: LatLng(19.0759837, 72.8776559),
    zoom: 15,
  );
  Uint8List? marketimages;
  List<String> images = ['images/car.png','images/bus.png', 'images/travelling.png', 'images/bycicle.png', 'images/food-delivery.png'];
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLen = <LatLng>[

    LatLng(19.0759837, 72.8776559),
    LatLng(28.679079, 77.069710),
    LatLng(26.850000, 80.949997),
    LatLng(24.879999, 74.629997),
    LatLng(16.166700, 74.833298),
    LatLng(12.971599, 77.594563),
  ];*/

  /*Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }*/
  /*loadData() async{
    for(int i=0 ;i<images.length; i++){
      final Uint8List markIcons = await getImages(images[i], 100);
      // makers added according to index
      _markers.add(
          Marker(
            // given marker id
            markerId: MarkerId(i.toString()),
            // given marker icon
            icon: BitmapDescriptor.fromBytes(markIcons),
            // given position
            position: _latLen[i],
            infoWindow: InfoWindow(
              // given title for marker
              title: 'Location: '+i.toString(),
            ),
          )
      );
      setState(() {
      });
    }
  }*/

  @override
  void initState() {
    super.initState();
    //getCategory();
    _getCurrentPosition();
//    loadData();
  }
  final TextEditingController storeName = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController businessIdController = TextEditingController();

 // final TextEditingController categoryController = TextEditingController();

 // Rx<File> image = File("").obs;
  Rx<File> image1 = File("").obs;
  Rx<File> image2 = File("").obs;
  Rx<File> image3 = File("").obs;
  Rx<File> image4 = File("").obs;
  RxString selectedCAt = "".obs;
  //String? _address = "";
  bool? _isValue1 = false;
  bool? _isValue2 = false;
 // final _formKey = GlobalKey<FormState>();
  /*RxBool showValidation = false.obs;
  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }*/
 /* Rx<CategoriesModel> model = CategoriesModel().obs;
  RxBool isDataLoaded = false.obs;*/
/*getCategory(){
  vendorCategoryRepo().then((value1) {
    model.value = value1;
    if(value1.status == true){
      isDataLoaded.value = true;
    }
  });
}*/

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

                            /*InkWell(
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
                                          leading: Text('Address',style: TextStyle(color: AppTheme.userText, fontSize: AddSize.font14,fontWeight: FontWeight.w700,),),
                                          title: Text(
                                            _address ?? "Location".toString(),
                                            style: TextStyle(
                                                fontSize: AddSize.font14),
                                          ),
                                          trailing: Image.asset(
                                            AppAssets.drawer_location,
                                            width: AddSize.size15,
                                          ),
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
                                )),*/
                            SizedBox(
                              height: AddSize.size12,
                            ),
                            RegistrationTextField(
                              readOnly: true,
                              controller: vendorCategoryController.categoryController,
                              hint: "Select Category",
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
                              "Business ID",
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
                            Text(
                              "Location",
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
                            /*Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: InkWell(
                                          onTap: () async {
                                            var place = await PlacesAutocomplete.show(
                                                context: context,
                                                apiKey: googleApikey,
                                                mode: Mode.overlay,
                                                types: [],
                                                strictbounds: false,
                                                // components: [
                                                //   Component(Component.country, 'np')
                                                // ],
                                                onError: (err) {
                                                  log("error.....   ${err.errorMessage}");
                                                });
                                            if (place != null) {
                                              setState(() {
                                                _address = place.description.toString();
                                              });
                                              final plist = GoogleMapsPlaces(
                                                apiKey: googleApikey,
                                                apiHeaders:
                                                await const GoogleApiHeaders().getHeaders(),
                                              );
                                              print(plist);
                                              String placeid = place.placeId ?? "0";
                                              final detail =
                                              await plist.getDetailsByPlaceId(placeid);
                                              final geometry = detail.result.geometry!;
                                              final lat = geometry.location.lat;
                                              final lang = geometry.location.lng;
                                              var newlatlang = LatLng(lat, lang);
                                              setState(() {
                                                _address = place.description.toString();
                                                _onAddMarkerButtonPressed(
                                                    LatLng(lat, lang), place.description);
                                              });
                                              mapController?.animateCamera(
                                                  CameraUpdate.newCameraPosition(CameraPosition(
                                                      target: newlatlang, zoom: 17)));
                                              setState(() {});
                                            }
                                          },
                                          child: Card(
                                            */
                            /*child: Container(
                                                padding: const EdgeInsets.all(0),
                                                // width: MediaQuery.of(context).size.width - 40,
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.my_location,color: AppTheme.primaryColor,size: 30,
                                                  ),
                                                  title: Text(
                                                    _address.toString(),
                                                    style:
                                                    TextStyle(fontSize: AddSize.font14),
                                                  ),
                                                  trailing: const Icon(Icons.search,color: AppTheme.primaryColor,),
                                                  dense: true,
                                                ))*/
                            /*
                                          ))),
                                  _isValue.value == true
                                      ? const SizedBox()
                                      :
                                  SizedBox(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // google map
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
                                      )
                                      //Icon((Icons.telegram))
                      
                                     */
                            /* Container(
                                        height: height * .2,
                                        //padding: EdgeInsets.all(10),
                                        child:
                                       */
                            /**/
                            /* ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: GoogleMap(

                                            zoomGesturesEnabled: true,
                                            //enable Zoom in, out on map
                                            initialCameraPosition: const CameraPosition(
                                              target: LatLng(0, 0),
                                              zoom: 14.0, //initial zoom level
                                            ),
                                            mapType: MapType.normal,
                                            //map type
                                            onMapCreated: (controller) {
                                              setState(() async {
                                                mapController = controller;
                                              });
                                            },
                                            markers: markers,

                                            // myLocationEnabled: true,
                                            // myLocationButtonEnabled: true,
                                            // compassEnabled: true,
                                            // markers: Set<Marker>.of(_markers),
                                            onCameraMove: (CameraPosition cameraPositions) {
                                              cameraPosition = cameraPositions;
                                            },
                                            onCameraIdle: () async {},
                                          ),
                                        ),*/
                            /**/
                            /*
                                      ),*/
                            /*


                                    ],
                                  ),
                                  SizedBox(height: height * .02,),
                                  */
                            /*ElevatedButton(
                                      onPressed: () {
                                        // setState(() {
                                        //   _isValue.value = !_isValue.value;
                                        //   selectedChip.value = "Home";
                                        // });
                                        // showChangeAddressSheet(addressModel.value);
                                        // Get.toNamed(MyRouter.chooseAddressScreen);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(double.maxFinite, 60),
                                        primary: AppTheme.primaryColor.withOpacity(.80),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)),
                                      ),
                                      child: Text(
                                        "Save",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                            color: AppTheme.backgroundcolor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: AddSize.font16),
                                      )),*/
                            /*
                                  SizedBox(height: height * .02,),
                                ],
                              ),
                            ),*/
                            /*Container(
                              child: GoogleMap(
                                initialCameraPosition: _kGoogle,
                                // set markers on google map
                                markers: Set<Marker>.of(_markers),
                                // on below line we have given map type
                                mapType: MapType.normal,
                                // on below line we have enabled location
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,

                                compassEnabled: true,
                                onMapCreated: (GoogleMapController controller){
                                  _controller.complete(controller);
                                },

                              ),
                            ),*/
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
                            // Row(
                            //   children: [
                            //     Checkbox(
                            //         side: BorderSide(
                            //             color: showValidation == false
                            //                 ? AppTheme.primaryColor
                            //                 : Colors.red,
                            //             width: 2),
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(5)),
                            //         value: _isValue1,
                            //         onChanged: (bool? value) {
                            //           setState(() {
                            //             _isValue1 = value;
                            //           });
                            //         }),
                            //     Expanded(
                            //         child: Text(
                            //           "? Using imported  meats",
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .headline5!
                            //               .copyWith(
                            //               fontWeight: FontWeight.w400,
                            //               fontSize: 14,color: Color(0xff1D303A)),
                            //         ))
                            //   ],
                            // ),
                            //
                            // Row(
                            //   children: [
                            //     Checkbox(
                            //         side: BorderSide(
                            //             color: showValidation == false
                            //                 ? AppTheme.primaryColor.withOpacity(.80)
                            //                 : Colors.red,
                            //             width: 2),
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(5)),
                            //         value: _isValue2,
                            //         onChanged: (bool? value) {
                            //           setState(() {
                            //             _isValue2 = value;
                            //           });
                            //         }),
                            //     Expanded(
                            //         child: Text(
                            //           "? Using imported  Chicken",
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .headline5!
                            //               .copyWith(
                            //               fontWeight: FontWeight.w400,
                            //               fontSize: 14,color: Color(0xff1D303A)),
                            //         ))
                            //   ],
                            // ),
                            SizedBox(
                              height: AddSize.size15,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                  //_address!.isNotEmpty &&
                                      image.value.path != "" &&
                                      image1.value.path != "") {
                                    Map<String, String> mapData = {
                                      'store_name': storeName.text,
                                      'phone': phoneController.text,
                                      'latitude': myAddressController.latLong1!,
                                      'longitude': myAddressController.latLong2!,
                                    // 'location': _address!,
                                      'business_id': businessIdController.text,
                                      'category': vendorCategoryController.categoryController.text,
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
/*
  chipList(
      title,
      ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Column(
        children: [
          ChoiceChip(
            padding: EdgeInsets.symmetric(
                horizontal: width * .01, vertical: height * .01),
            backgroundColor: AppTheme.backgroundcolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: title != selectedChip.value
                        ? Colors.grey.shade300
                        : const Color(0xff4169E2))),
            label: Text("$title",
                style: TextStyle(
                    color: title != selectedChip.value
                        ? Colors.grey.shade600
                        : const Color(0xff4169E2),
                    fontSize: AddSize.font14,
                    fontWeight: FontWeight.w500)),
            selected: title == selectedChip.value,
            selectedColor: const Color(0xff4169E2).withOpacity(.3),
            onSelected: (value) {
              selectedChip.value = title;
              if (title == "Other") {
                customTip.value = true;
                otherController.text = "";
              } else {
                customTip.value = false;
                otherController.text = title;
              }
              setState(() {});
            },
          )
        ],
      );
    });
  }*/
}
