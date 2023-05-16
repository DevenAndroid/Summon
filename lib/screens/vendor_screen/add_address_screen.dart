import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:fresh2_arrive/resources/helper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/MyAddress_controller.dart';
import '../../controller/address_controller.dart';
import '../../resources/app_theme.dart';
import '../../widgets/dimensions.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);
  static var addAddressScreen = '/addAddressScreen';
  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final Completer<GoogleMapController> googleMapController = Completer();
  final addressController = Get.put(AddressController());
  final myAddressController = Get.put(MyAddressController());

  GoogleMapController? mapController;

  String? _currentAddress;
  String? _address = "";


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10.4746,
  );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: const LatLng(0, 0).checkLatLong,
              zoom: 14.0,
            ),
            mapType: MapType.normal,
            onMapCreated: (controller) async {
              mapController = controller;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.setString("lastLocation", "${position.latitude}==${position.longitude}");
              String location = prefs.getString("lastLocation") ?? "";
              if(location.isNotEmpty && addressController.cameraPosition.target == const LatLng(0,0).checkLatLong){
                LatLng lastLocation = LatLng(double.parse(location.toString().split("==").first), double.parse(location.toString().split("==").last));
                await _getAddressFromLatLng(lastLocation);
                mapController!.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: lastLocation,
                        zoom: 15)));
                _onAddMarkerButtonPressed(lastLocation,
                    "${_currentAddress!} ${_address!}",
                    allowAnimation: true);
              }
            },
            markers: markers,
            onCameraMove: (CameraPosition cameraPositions) {
              cameraPosition = cameraPositions;
              addressController.cameraPosition = cameraPositions;
              _updatePosition(cameraPositions, allowFetch: false);
            },
            onCameraIdle: () async {
              if (mapController != null && cameraPosition != null) {
                _updatePosition(cameraPosition!);
              }
            },
          ),
          Positioned(
              top: 10,
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

                      if(mounted) {
                        setState(() {
                          _address = place.description.toString();
                        });
                      }
                      final plist = GoogleMapsPlaces(
                        apiKey: googleApikey,
                        apiHeaders:
                        await const GoogleApiHeaders().getHeaders(),
                      );
                      if (kDebugMode) {
                        print(plist);
                      }
                      String placeid = place.placeId ?? "0";
                      final detail =
                      await plist.getDetailsByPlaceId(placeid);
                      final geometry = detail.result.geometry!;
                      final lat = geometry.location.lat;
                      final lang = geometry.location.lng;
                      var newlatlang = LatLng(lat, lang).checkLatLong;

                      if(mounted) {
                        setState(() {
                          _address = place.description.toString();
                          _onAddMarkerButtonPressed(
                              LatLng(lat, lang).checkLatLong, place.description);
                        });
                      }
                      mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target: newlatlang, zoom: 17)));
                      if(mounted) {
                        setState(() {});
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      color: Colors.white,
                      child: Container(
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            leading: const Icon(
                              Icons.location_on_rounded,
                              color: AppTheme.primaryColor,
                            ),
                            title: Text(
                              "Search Location",
                              style: GoogleFonts.poppins(fontSize: AddSize.font14),
                            ),
                            trailing: const Icon(Icons.search),
                            dense: true,
                          )),
                    ),
                  ))),
          Positioned(
              bottom: 0,
              child: Container(

                height: AddSize.size200,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
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
                      Card(
                        child: ListTile(
                          minLeadingWidth: 10,
                          title: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppTheme.primaryColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: AddSize.size12,
                              ),
                              Expanded(
                                child: Text(
                                  _address.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: AddSize.font16),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size30,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            print(myAddressController.latLong1);
                            print(myAddressController.latLong2);
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.maxFinite, 60),
                            backgroundColor: AppTheme.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            "Confirm",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
