// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:fresh2_arrive/resources/app_assets.dart';
// import 'package:fresh2_arrive/widgets/add_text.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/directions.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../resources/app_theme.dart';
// import '../../routers/my_router.dart';
// import '../../widgets/dimensions.dart';
// import 'package:geolocator/geolocator.dart';
//
// class CompleteAddress extends StatefulWidget {
//   const CompleteAddress({Key? key}) : super(key: key);
//
//   @override
//   State<CompleteAddress> createState() => _CompleteAddressState();
// }
//
// class _CompleteAddressState extends State<CompleteAddress> {
//   final TextEditingController searchController = TextEditingController();
//   final Completer<GoogleMapController> googleMapController = Completer();
//   GoogleMapController? mapController;
//
//   String? _currentAddress;
//   Position? _currentPosition;
//
//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }
//
//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();
//
//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//       _getAddressFromLatLng(_currentPosition!);
//       mapController!.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(
//               target: LatLng(
//                   _currentPosition!.latitude, _currentPosition!.longitude),
//               zoom: 15)));
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
//
//   Future<void> _getAddressFromLatLng(Position position) async {
//     await placemarkFromCoordinates(
//             _currentPosition!.latitude, _currentPosition!.longitude)
//         .then((List<Placemark> placemarks) {
//       Placemark place = placemarks[0];
//       setState(() {
//         _currentAddress =
//             '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
//       });
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //checkGps();
//     _getCurrentPosition();
//   }
//
//   String googleApikey = "GOOGLE_MAP_API_KEY";
//   GoogleMapController? mapController1; //contrller for Google map
//   CameraPosition? cameraPosition;
//   LatLng startLocation = LatLng(27.6602292, 85.308027);
//   String location = "Search Location";
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         mapController!.dispose();
//         return true;
//       },
//       child: Scaffold(
//         appBar: backAppBar(
//             title: "Complete Address",
//             context: context,
//             dispose: "dispose",
//             disposeController: () {
//               mapController!.dispose();
//             }),
//         body: Stack(
//           children: [
//             // GoogleMap(
//             //   mapType: MapType.normal,
//             //   initialCameraPosition: CameraPosition(
//             //     target: LatLng(0, 0),
//             //     zoom: 14,
//             //   ),
//             //   onMapCreated: (GoogleMapController controller) {
//             //     mapController = controller;
//             //     googleMapController.complete(controller);
//             //   },
//             // ),
//             GoogleMap(
//               zoomGesturesEnabled: true, //enable Zoom in, out on map
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(0, 0),
//                 zoom: 14.0, //initial zoom level
//               ),
//               mapType: MapType.normal, //map type
//               onMapCreated: (controller) {
//                 setState(() {
//                   mapController = controller;
//                 });
//               },
//               onCameraMove: (CameraPosition cameraPositiona) {
//                 cameraPosition = cameraPositiona;
//               },
//               onCameraIdle: () async {
//                 List<Placemark> placemarks = await placemarkFromCoordinates(
//                     cameraPosition!.target.latitude,
//                     cameraPosition!.target.longitude);
//                 setState(() {
//                   location =
//                       "${placemarks.first.administrativeArea}, ${placemarks.first.street}";
//                 });
//               },
//             ),
//             Positioned(
//                 child: IconButton(
//               icon: Icon(Icons.clear),
//               onPressed: () {},
//             ))
//           ],
//         ),
//         // bottomSheet: BottomSheet(
//         //   backgroundColor: Colors.transparent,
//         //   builder: (BuildContext context) {
//         //     return Container(
//         //       height: AddSize.size300,
//         //       width: AddSize.screenWidth,
//         //       color: AppTheme.primaryColor,
//         //     );
//         //   },
//         //   onClosing: () {},
//         //
//         // ),
//       ),
//     );
//   }
// }
