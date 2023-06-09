import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/generated/assets.dart';
import 'package:fresh2_arrive/repositories/add_address_repository.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/helper.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/editprofile_textfield.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/GetSaveAddressController.dart';
import '../../controller/MyAddress_controller.dart';
import '../../model/MyAddressModel.dart';
import '../../repositories/Add_Address1_repo.dart';
import '../../resources/app_theme.dart';
import '../../resources/new_helper.dart';
import '../../widgets/dimensions.dart';
import 'package:geolocator/geolocator.dart';
import '../Language_Change_Screen.dart';
import '../my_address.dart';
import '../vendor_screen/add_address_screen.dart';

class ChooseAddress extends StatefulWidget {
  const ChooseAddress({Key? key}) : super(key: key);
  static var chooseAddressScreen = "/chooseAddressScreen";

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  final _formKey = GlobalKey<FormState>();
  final addressController = Get.put(MyAddressController());
  final getSaveAddressController = Get.put(GetSaveAddressController());
  final List<String> choiceAddress = ["Home", "Office", "Hotel", "Other"];
  final RxBool _isValue = false.obs;
  bool chooseOption = false;
  RxBool customTip = false.obs;
  RxString selectedChip = "Home".obs;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
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

 Color containerColor= Colors.grey.shade300;

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
      setState(() => _currentPosition = position);
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
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        _address =
            '${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  final TextEditingController otherController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkGps();
    getSaveAddressController.saveAddressData();
    _getCurrentPosition();
    if (Get.arguments != null) {
      // addressModel.value = Get.arguments[0];
    }
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
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
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
                title: "Add new address".tr,
                context: context,
                dispose: "dispose",
                disposeController: () {
                  mapController!.dispose();

                }),
            body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 28,right: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 9,
                      ),
                      EditProfileTextFieldWidget1(
                        hint: "Name".tr,
                        controller: nameController,
                        validator: validateName,
                      ),

                      const SizedBox(
                        height: 9,
                      ),
                      EditProfileTextFieldWidget1(
                        hint: "Phone".tr,
                        controller: phoneController,
                        validator: validateMobile,
                        keyboardType: TextInputType.number,
                        length: 10,
                        //readOnly: true,
                        //enable: false,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      EditProfileTextFieldWidget1(
                        hint: "Note".tr,
                        controller: noteController,
                        validator: validateName,
                      ),

                      const SizedBox(
                        height: 9,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                              side: BorderSide(
                                  color:AppTheme.primaryColor,
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
                                style: GoogleFonts.ibmPlexSansArabic(color: Color(0xffACACB7),
                                    fontSize: AddSize.font14,fontWeight:FontWeight.w700),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
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
                                color: containerColor
                              )),
                          child: image.value.path == ""
                              ?
                          Column(
                            children: [

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
                              SizedBox(
                                height: AddSize.size10,
                              ),
                              Text(
                                "Upload an image of your house".tr,
                                style: GoogleFonts
                            .ibmPlexSansArabic(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.w700,
                        color: Color(
                        0xff435960)),
                              ),
                            ],
                          )

                              :
                          Stack(
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
                            child: GoogleMap(
                              zoomGesturesEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: const LatLng(0, 0).checkLatLong,
                                zoom: 14.0,
                              ),
                            ),

                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(10),
                            //   child: Image(image: AssetImage(AppAssets.mapImage),
                            //
                            //   ),
                            // ),
                          ),
                          Positioned(top: 50,
                            right: 150,
                            child: InkWell(onTap: (){
                              Get.toNamed(AddAddressScreen.addAddressScreen);
                            },
                                child:
                                CircleAvatar(backgroundColor: Colors.white,
                                    radius: 22,
                                    child: Icon((Icons.telegram),size: 30,color: Color(0xFFFE724C),))
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
                                   setState(() {
                                     containerColor= image.value.path== ""?Colors.red:Colors.grey.shade300;
                                   });
                            if(_formKey.currentState!.validate()
                                    && image.value.path != "" && chooseOption==true){
                              print("hellloo");
                              var map = <String, String>{
                           'latitude':addressController.latLong2!,
                           'longitude': addressController.latLong1!,
                           'name':nameController.text.toString(),
                           'phone':phoneController.text,
                           'note':noteController.text,
                           'note':noteController.text,
                                'leave_at_door': chooseOption ? "1" : "0",

                            };
                              print(map);
                              addAddress1Repo(
                                map:map,
                                fieldName1: "image",
                                file1: image.value,
                                 context:context,
                              ).then((value){
                                if(value.status==true){
                                  showToast(value.message);
                                  Get.toNamed(MyAddress
                                      .myAddressScreen);
                                  addressController
                                      .getAddress();
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
                            "Save".tr,
                            style: Theme.of(context)
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
            )),
      ),
    );
  }

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
  }
}
