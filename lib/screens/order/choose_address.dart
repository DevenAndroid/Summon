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
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/editprofile_textfield.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import '../../controller/MyAddress_controller.dart';
import '../../model/MyAddressModel.dart';
import '../../resources/app_theme.dart';
import '../../resources/new_helper.dart';
import '../../widgets/dimensions.dart';
import 'package:geolocator/geolocator.dart';
import '../my_address.dart';

class ChooseAddress extends StatefulWidget {
  const ChooseAddress({Key? key}) : super(key: key);
  static var chooseAddressScreen = "/chooseAddressScreen";

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  final _formKey = GlobalKey<FormState>();
  final addressController = Get.put(MyAddressController());
  Rx<AddressData> addressModel = AddressData().obs;
  final List<String> choiceAddress = ["Home", "Office", "Hotel", "Other"];
  final RxBool _isValue = false.obs;
  RxBool customTip = false.obs;
  RxString selectedChip = "Home".obs;
  final TextEditingController searchController = TextEditingController();
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
                                        if (_formKey.currentState!.validate()) {
                                          addressModel.street != null &&
                                                  addressModel.flatNo != null &&
                                                  addressModel.landmark != null
                                              ? editAddress(
                                                      location: _address,
                                                      flat_no:
                                                          flatNoController.text,
                                                      street:
                                                          streetController.text,
                                                      landmark:
                                                          streetController.text,
                                                      address_type:
                                                          otherController.text,
                                                      context: context,
                                                      address_id: addressModel
                                                          .id
                                                          .toString())
                                                  .then((value) {
                                                  showToast(value.message);
                                                  if (value.status == true) {
                                                    Get.toNamed(MyAddress
                                                        .myAddressScreen);
                                                    addressController
                                                        .getAddress();
                                                    flatNoController.clear();
                                                    streetController.clear();
                                                    otherController.clear();
                                                    recipientController.clear();
                                                    selectedChip.value = "";
                                                  }
                                                })
                                              : addAddress(
                                                      location: _address,
                                                      flat_no:
                                                          flatNoController.text,
                                                      street:
                                                          streetController.text,
                                                      landmark:
                                                          streetController.text,
                                                      address_type:
                                                          otherController.text,
                                                      context: context)
                                                  .then((value) {
                                                  showToast(value.message);
                                                  if (value.status == true) {
                                                    Get.toNamed(MyAddress
                                                        .myAddressScreen);
                                                    addressController
                                                        .getAddress();
                                                    flatNoController.clear();
                                                    streetController.clear();
                                                    otherController.clear();
                                                    recipientController.clear();
                                                    selectedChip.value = "";
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
                  ));
            }),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkGps();
    _getCurrentPosition();
    if (Get.arguments != null) {
      addressModel.value = Get.arguments[0];
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
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Color(0xffF9F9F9),
            appBar: backAppBar(
                title: _isValue.value == true
                    ? "Complete Address"
                    : "Add new address",
                context: context,
                dispose: "dispose",
                disposeController: () {
                  mapController!.dispose();
                }),
            body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 28,right: 24),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 9,
                    ),
                    EditProfileTextFieldWidget1(
                      hint: "Name",
                      //controller: controller.firstNameController,
                      validator: validateName,
                    ),

                    const SizedBox(
                      height: 9,
                    ),
                    EditProfileTextFieldWidget1(
                      hint: "Phone",
                      //controller: controller.mobileController,
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
                      hint: "Note",
                      //controller: controller.firstNameController,
                      validator: validateName,
                    ),

                    const SizedBox(
                      height: 9,
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
                              "Upload an image of your house",
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
                      "Choose Location",
                      style: GoogleFonts
                          .ibmPlexSansArabic(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.w700,
                          color: Color(
                              0xffADADB8)),
                    ),

                    SizedBox(
                      height: height * .20,
                      width: width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(image: AssetImage(AppAssets.mapImage),

                        ),
                      ),
                    ),
                   //  Container(
                   //      child: InkWell(
                   //          onTap: () async {
                   //            var place = await PlacesAutocomplete.show(
                   //                context: context,
                   //                apiKey: googleApikey,
                   //                mode: Mode.overlay,
                   //                types: [],
                   //                strictbounds: false,
                   //                // components: [
                   //                //   Component(Component.country, 'np')
                   //                // ],
                   //                onError: (err) {
                   //                  log("error.....   ${err.errorMessage}");
                   //                });
                   //            if (place != null) {
                   //              setState(() {
                   //                _address = place.description.toString();
                   //              });
                   //              final plist = GoogleMapsPlaces(
                   //                apiKey: googleApikey,
                   //                apiHeaders:
                   //                await const GoogleApiHeaders().getHeaders(),
                   //              );
                   //              print(plist);
                   //              String placeid = place.placeId ?? "0";
                   //              final detail =
                   //              await plist.getDetailsByPlaceId(placeid);
                   //              final geometry = detail.result.geometry!;
                   //              final lat = geometry.location.lat;
                   //              final lang = geometry.location.lng;
                   //              var newlatlang = LatLng(lat, lang);
                   //              setState(() {
                   //                _address = place.description.toString();
                   //                _onAddMarkerButtonPressed(
                   //                    LatLng(lat, lang), place.description);
                   //              });
                   //              mapController?.animateCamera(
                   //                  CameraUpdate.newCameraPosition(CameraPosition(
                   //                      target: newlatlang, zoom: 17)));
                   //              setState(() {});
                   //            }
                   //          },
                   //          child: Card(
                   //            child: Container(
                   //                padding: const EdgeInsets.all(0),
                   //               // width: MediaQuery.of(context).size.width - 40,
                   //                child: ListTile(
                   //                  leading: Icon(
                   //                    Icons.my_location,color: AppTheme.primaryColor,size: 30,
                   //                  ),
                   //                  title: Text(
                   //                    _address.toString(),
                   //                    style:
                   //                    TextStyle(fontSize: AddSize.font14),
                   //                  ),
                   //                  trailing: const Icon(Icons.search,color: AppTheme.primaryColor,),
                   //                  dense: true,
                   //                )),
                   //          ))),
                   //  _isValue.value == true
                   //      ? const SizedBox()
                   //      :
                   // SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    // google map
                    // Stack(
                    //   children: [
                    //     Container(
                    //       height: height * .25,
                    //       //padding: EdgeInsets.all(10),
                    //       child:
                    //       ClipRRect(
                    //         borderRadius: BorderRadius.circular(20),
                    //         child: GoogleMap(
                    //
                    //           zoomGesturesEnabled: true,
                    //           //enable Zoom in, out on map
                    //           initialCameraPosition: const CameraPosition(
                    //             target: LatLng(0, 0),
                    //             zoom: 14.0, //initial zoom level
                    //           ),
                    //           mapType: MapType.normal,
                    //           //map type
                    //           onMapCreated: (controller) {
                    //             setState(() async {
                    //               mapController = controller;
                    //             });
                    //           },
                    //           markers: markers,
                    //
                    //           // myLocationEnabled: true,
                    //           // myLocationButtonEnabled: true,
                    //           // compassEnabled: true,
                    //           // markers: Set<Marker>.of(_markers),
                    //           onCameraMove: (CameraPosition cameraPositions) {
                    //             cameraPosition = cameraPositions;
                    //           },
                    //           onCameraIdle: () async {},
                    //         ),
                    //       ),
                    //     ),
                    //
                    //
                    //   ],
                    // ),
                    SizedBox(height: height * .02,),
                    ElevatedButton(
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
                        )),
                    SizedBox(height: height * .02,),
                  ],
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
