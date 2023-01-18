import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/editprofile_textfield.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import '../../resources/app_theme.dart';
import '../../widgets/dimensions.dart';
import 'package:geolocator/geolocator.dart';

class ChooseAddress extends StatefulWidget {
  const ChooseAddress({Key? key}) : super(key: key);
  static var chooseAddressScreen = "/chooseAddressScreen";
  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  final List<String> choiceAddress = ["Home", "Office", "Hotel", "Other"];
  final RxBool _isValue = false.obs;
  RxString selectedChip = "".obs;
  final TextEditingController searchController = TextEditingController();
  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;

  String? _currentAddress;
  Position? _currentPosition;

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
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  showChangeAddressSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isValue.value = !_isValue.value;
                  });
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const ShapeDecoration(
                      color: AppTheme.blackcolor, shape: CircleBorder()),
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
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppTheme.blackcolor,
                            fontWeight: FontWeight.w500,
                            fontSize: AddSize.font16),
                      ),
                      SizedBox(
                        height: AddSize.size12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          choiceAddress.length,
                          (index) => chipList(choiceAddress[index]),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size20,
                      ),
                      const EditProfileTextFieldWidget(
                        hint: "Flat, House no, Floor, Tower",
                      ),
                      SizedBox(
                        height: AddSize.size20,
                      ),
                      const EditProfileTextFieldWidget(
                        hint: "Street, Society, Landmark",
                      ),
                      SizedBox(
                        height: AddSize.size20,
                      ),
                      const EditProfileTextFieldWidget(
                        hint: "Recipient’s name",
                      ),
                      SizedBox(
                        height: AddSize.size20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // Get.toNamed(MyRouter.chooseAddressScreen);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.maxFinite, 60),
                            primary: AppTheme.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkGps();
    _getCurrentPosition();
  }

  String googleApikey = "GOOGLE_MAP_API_KEY";
  GoogleMapController? mapController1; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(27.6602292, 85.308027);
  String location = "Search Location";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        mapController!.dispose();
        return true;
      },
      child: Scaffold(
          appBar: backAppBar(
              title: _isValue.value == true
                  ? "Complete Address"
                  : "Choose Address",
              context: context,
              dispose: "dispose",
              disposeController: () {
                mapController!.dispose();
              }),
          body: Stack(
            children: [
              // GoogleMap(
              //   mapType: MapType.normal,
              //   initialCameraPosition: CameraPosition(
              //     target: LatLng(0, 0),
              //     zoom: 14,
              //   ),
              //   onMapCreated: (GoogleMapController controller) {
              //     mapController = controller;
              //     googleMapController.complete(controller);
              //   },
              // ),
              GoogleMap(
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 14.0, //initial zoom level
                ),
                mapType: MapType.normal, //map type
                onMapCreated: (controller) {
                  setState(() {
                    mapController = controller;
                  });
                },
                onCameraMove: (CameraPosition cameraPositiona) {
                  cameraPosition = cameraPositiona;
                },
                onCameraIdle: () async {
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      cameraPosition!.target.latitude,
                      cameraPosition!.target.longitude);
                  setState(() {
                    location =
                        "${placemarks.first.administrativeArea}, ${placemarks.first.street}";
                  });
                },
              ),
              _isValue.value == true
                  ? const SizedBox()
                  : Positioned(
                      //search input bar
                      top: 10,
                      child: InkWell(
                          onTap: () async {
                            var place = await PlacesAutocomplete.show(
                                context: context,
                                apiKey:
                                    "AIzaSyAtvTCH-Vvvnq_lb_RlG0h1h3A1H26ULlQ",
                                mode: Mode.overlay,
                                types: [],
                                strictbounds: false,
                                components: [
                                  Component(Component.country, 'np')
                                ],
                                onError: (err) {});
                            if (place != null) {
                              setState(() {
                                location = place.description.toString();
                              });
                              final plist = GoogleMapsPlaces(
                                apiKey:
                                    "AIzaSyAtvTCH-Vvvnq_lb_RlG0h1h3A1H26ULlQ",
                                apiHeaders:
                                    await const GoogleApiHeaders().getHeaders(),
                              );
                              String placeid = place.placeId ?? "0";
                              final detail =
                                  await plist.getDetailsByPlaceId(placeid);
                              final geometry = detail.result.geometry!;
                              final lat = geometry.location.lat;
                              final lang = geometry.location.lng;
                              var newlatlang = LatLng(lat, lang);
                              mapController1?.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: newlatlang, zoom: 17)));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              child: Container(
                                  padding: const EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: ListTile(
                                    leading: Image.asset(
                                      AppAssets.drawer_location,
                                      width: AddSize.size15,
                                    ),
                                    title: Text(
                                      location.toString(),
                                      style:
                                          TextStyle(fontSize: AddSize.font14),
                                    ),
                                    trailing: const Icon(Icons.search),
                                    dense: true,
                                  )),
                            ),
                          ))),
              // Positioned(
              //   top: 10,
              //   left: 15,
              //   right: 15,
              //   child: TextField(
              //     controller: searchController,
              //     style: TextStyle(fontSize: AddSize.font14),
              //     textAlignVertical: TextAlignVertical.center,
              //     textInputAction: TextInputAction.search,
              //     onSubmitted: (value) => {},
              //     decoration: InputDecoration(
              //         filled: true,
              //         suffixIcon: Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             IconButton(
              //               onPressed: () {},
              //               icon: Icon(
              //                 Icons.search,
              //                 color: AppTheme.primaryColor,
              //                 size: AddSize.size25,
              //               ),
              //             ),
              //             IconButton(
              //               onPressed: () {
              //                 _getCurrentPosition();
              //               },
              //               icon: Icon(
              //                 Icons.gps_fixed,
              //                 color: AppTheme.primaryColor,
              //                 size: AddSize.size20,
              //               ),
              //             ),
              //           ],
              //         ),
              //         border: const OutlineInputBorder(
              //             borderSide: BorderSide.none,
              //             borderRadius: BorderRadius.all(Radius.circular(10))),
              //         fillColor: Colors.white,
              //         contentPadding: EdgeInsets.symmetric(
              //             horizontal: AddSize.padding20,
              //             vertical: AddSize.padding10),
              //         hintText: 'Search',
              //         hintStyle: TextStyle(
              //             fontSize: AddSize.font14,
              //             color: AppTheme.blackcolor,
              //             fontWeight: FontWeight.w400)),
              //   ),
              // ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    height: AddSize.size200,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: AppTheme.backgroundcolor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: AppTheme.primaryColor,
                                    size: AddSize.size25,
                                  ),
                                  SizedBox(
                                    width: AddSize.size12,
                                  ),
                                  Text(
                                    "B Block Vaishali Nagar Jaipur",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: AddSize.font16),
                                  )
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isValue.value = !_isValue.value;
                                    });
                                    showChangeAddressSheet();
                                  },
                                  child: Text(
                                    "CHANGE",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: AddSize.font12,
                                            color: AppTheme.primaryColor),
                                  ))
                            ],
                          ),
                          Text(
                            _currentAddress ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: AddSize.font14,
                                    color: AppTheme.lightblack),
                          ),
                          SizedBox(
                            height: AddSize.size30,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                // Get.toNamed(MyRouter.chooseAddressScreen);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.maxFinite, 60),
                                primary: AppTheme.primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text(
                                "SAVE ADDRESS",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: AppTheme.backgroundcolor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AddSize.font16),
                              )),
                        ],
                      ),
                    ),
                  ))
            ],
          )),
    );
  }

  chipList(
    title,
  ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return ChoiceChip(
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
        },
      );
    });
  }
}
