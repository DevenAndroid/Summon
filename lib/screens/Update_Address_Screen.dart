import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/screens/vendor_screen/add_address_screen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/editprofile_textfield.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controller/GetSaveAddressController.dart';
import '../../controller/MyAddress_controller.dart';
import '../../repositories/Add_Address1_repo.dart';
import '../../resources/app_theme.dart';
import '../../resources/new_helper.dart';
import '../../widgets/dimensions.dart';
import 'package:geolocator/geolocator.dart';

import '../repositories/Edit_Address_REpo.dart';
import '../widgets/registration_form_textField.dart';
import 'Language_Change_Screen.dart';
import 'my_address.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({Key? key}) : super(key: key);
  static var updateAddressScreen = "/updateAddressScreen";

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final addressController = Get.put(MyAddressController());
  final getSaveAddressController = Get.put(GetSaveAddressController());
  final RxBool _isValue = false.obs;
  bool chooseOption = false;

  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;
  Rx<File> image = File("").obs;
  String? _currentAddress;
  String? _address = "";
  Position? _currentPosition;
  RxBool showValidation = false.obs;

  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _handleLocationPermission() async {
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
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      // setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  _currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 15))
      );
      _onAddMarkerButtonPressed(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          "current location");
      setState(() {});
      // location = _currentAddress!;
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place
            .subAdministrativeArea}, ${place.postalCode}';
        _address =
        '${place.subLocality}, ${place.subAdministrativeArea}, ${place
            .postalCode}';
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkGps();

    _getCurrentPosition();
    getSaveAddressController.saveAddressData().then((value){
      if (getSaveAddressController.isSaveAddressLoad.value &&
          getSaveAddressController.getSaveAddressModel.value.data != null){
        getSaveAddressController.nameController.text =
            getSaveAddressController.getSaveAddressModel.value.data!.name.toString();
        getSaveAddressController.phoneController.text =
            getSaveAddressController.getSaveAddressModel.value.data!.phone.toString();
        getSaveAddressController.noteController.text =
            getSaveAddressController.getSaveAddressModel.value.data!.note.toString();
        chooseOption= getSaveAddressController.getSaveAddressModel.value.data!.leaveAtDoor!;

      }
    });
  }

  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";
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
  }

  Future<void> _onAddMarkerButtonPressed(LatLng lastMapPosition, markerTitle,
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
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return WillPopScope(
      onWillPop: () async {
        mapController!.dispose();
        return true;
      },
      child: Directionality(
        textDirection: locale==Locale('en','US') ? TextDirection.ltr: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Color(0xffF9F9F9),
            appBar: backAppBar(
                title: "Update Address".tr,
                context: context,
                dispose: "dispose",
                disposeController: () {
                  mapController!.dispose();
                }),
            body: Obx(() {

              return  getSaveAddressController.isSaveAddressLoad.value &&
                  getSaveAddressController.getSaveAddressModel.value.data != null ?
               SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 28, right: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 9,
                        ),
                        RegistrationTextField1(
                          hint: "Name".tr,
                          controller: getSaveAddressController.nameController,
                          keyboardType: TextInputType.name,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Please enter the Name")
                          ]),

                        ),

                        const SizedBox(
                          height: 9,
                        ),
                        RegistrationTextField1(
                          hint: "Phone".tr,
                          controller: getSaveAddressController.phoneController,
                          keyboardType: TextInputType.number,
                          length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Please enter the Phone")
                          ]),

                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        RegistrationTextField1(
                          hint: "Note".tr,
                          controller: getSaveAddressController.noteController,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Please enter the NOte")
                          ]),
                        ),

                        const SizedBox(
                          height: 9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                                side: BorderSide(
                                    color: showValidation == false
                                        ? AppTheme.primaryColor
                                        : Colors.red,
                                    width: 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                value: chooseOption,
                                onChanged: (bool? value) {
                                  setState(() {
                                    chooseOption = value!;
                                  });
                                }),
                            Expanded(
                                child: Text(
                                  "Leave orders at the door".tr,
                                  style: GoogleFonts.ibmPlexSansArabic(
                                      color: Color(0xffACACB7),
                                      fontSize: AddSize.font14,
                                      fontWeight: FontWeight.w700),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
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
                                    getSaveAddressController
                                        .getSaveAddressModel
                                        .value
                                        .data!
                                        .image
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
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Choose Location".tr,
                          style: GoogleFonts
                              .ibmPlexSansArabic(
                              fontSize: 16,
                              fontWeight:
                              FontWeight.w700,
                              color: Color(
                                  0xffADADB8)),
                        ),

                        Stack(
                          children: [

                            SizedBox(
                              height: height * .20,
                              width: width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: AssetImage(AppAssets.mapImage),

                                ),
                              ),
                            ),
                            Positioned(top: 50,
                              right: 150,
                              child: InkWell(onTap: () {
                                Get.toNamed(AddAddressScreen.addAddressScreen);
                              },
                                  child:
                                  CircleAvatar(backgroundColor: Colors.white,
                                      radius: 22,
                                      child: Icon((Icons.telegram), size: 30,
                                        color: Color(0xFFFE724C),))
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: height * .02,),
                        ElevatedButton(
                            onPressed: () {
                              print("hello");
                              if (_formKey.currentState!.validate() && chooseOption == true
                                  ) {
                                var map = <String, String>{
                                  'name': getSaveAddressController
                                      .nameController.text,
                                  'phone': getSaveAddressController
                                      .phoneController.text,
                                  'address_id': getSaveAddressController.getSaveAddressModel.value.data!.id.toString(),
                                  'latitude': addressController.latLong2.toString(),
                                  'longitude': addressController.latLong1.toString(),
                                  'note': getSaveAddressController
                                      .noteController.text,
                                  'leave_at_door': chooseOption ? "1" : "0"

                                };
                                print("Addresss id is..${getSaveAddressController.getSaveAddressModel.value.data!.id.toString()}");
                                print(map);
                                editAddressREpo(
                                  map: map,
                                  context: context,
                                  fieldName1: "image",
                                  file1: image.value,
                                ).then((value) {
                                  if (value.status == true) {
                                    showToast(value.message);
                                    Get.toNamed(MyAddress
                                        .myAddressScreen);
                                    addressController
                                        .getAddress();
                                    // Get.back();
                                  }
                                });
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
                              "Update".tr,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                  color: AppTheme.backgroundcolor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AddSize.font16),
                            )),
                        SizedBox(height: height * .02,),
                      ],
                    ),
                  ),
                ),
              ):Center(child: CircularProgressIndicator());
            })
  ),
      ),
    );
  }


}
