import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/GetNearStoresOnMapController.dart';
import '../controller/single_store_controller.dart';
import 'Language_Change_Screen.dart';

class MapScreenPage extends StatefulWidget {
  const MapScreenPage({Key? key}) : super(key: key);
  static var mapScreen = "/mapScreen";

  @override
  State<MapScreenPage> createState() => _MapScreenPageState();
}

class _MapScreenPageState extends State<MapScreenPage> {
  final getStoreOnMapController = Get.put(GetStoresOnMapController());
  final singleStoreController = Get.put(SingleStoreController());
  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;

  PageController pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    getStoreOnMapController.getStoresOnMap().then((value) {
      if(getStoreOnMapController.model.value.data != null){
        markers.clear();
        // getStoreOnMapController.model.value.data!.forEach((element) {
          for(var i = 0; i < getStoreOnMapController.model.value.data!.length; i++) {
            var element = getStoreOnMapController.model.value.data![i];
            double? lat = double.tryParse(element.latitude.toString());
            double? long = double.tryParse(element.longitude.toString());
            if (lat != null && long != null) {
              _onAddMarkerButtonPressed(
                  lastMapPosition: LatLng(lat, long),
                  markerTitle: element.name.toString(),
                  id: element.id.toString(),
                index: i
              );
            }
          }
        // });
        if(getStoreOnMapController.model.value.data!.isNotEmpty) {
          var element = getStoreOnMapController.model.value.data![0];
          double? lat = double.tryParse(element.latitude.toString());
          double? long = double.tryParse(element.longitude.toString());
          if(lat != null && long != null) {
            if (mapController != null) {
              mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                      CameraPosition(target: LatLng(lat, long),zoom: 15)));
            }
          }
        }
        setState(() {});
      }
    });
  }
  final Set<Marker> markers = {};

  _onAddMarkerButtonPressed({
    required LatLng lastMapPosition,
    markerTitle,
    required String id,
    required int index,
  }) async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/mapIcon.png",
    );
    markers.add(Marker(

        markerId: MarkerId(lastMapPosition.toString()),
        position: lastMapPosition,
        onTap: (){
          print(id);
          pageViewController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.ease);
          },
        infoWindow: InfoWindow(
          title: markerTitle,
          onTap: (){
            print(id);
            pageViewController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.ease);
          }
        ),
        icon: markerbitmap));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        mapController!.dispose();
        return true;
      },
      child: Directionality(
        textDirection: locale==Locale('en','US')? TextDirection.ltr: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Color(0xffF9F9F9),
            appBar: backAppBar(
                title: "Stores".tr,
                context: context,
                dispose: "dispose",
                disposeController: () {
                  mapController!.dispose();
                }),
            body: Stack(
              children: [
                GoogleMap(
                  zoomGesturesEnabled: true,
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
                  myLocationButtonEnabled: true,
                  onTap: (value) {},
                  onCameraMove: (CameraPosition cameraPositions) {
                  },
                  onCameraIdle: () async {},
                ),
                Positioned(
                    bottom: 10,
                    child: Obx(() {
                      return getStoreOnMapController.model.value.data != null ?
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: PageView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: pageViewController,
                          itemCount:
                              getStoreOnMapController.model.value.data!.length,
                          onPageChanged: (value){
                              var element = getStoreOnMapController.model.value.data![value];
                              double? lat = double.tryParse(element.latitude.toString());
                              double? long = double.tryParse(element.longitude.toString());
                              if(lat != null && long != null) {
                                if (mapController != null) {
                                  mapController!.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(target: LatLng(lat, long),zoom: 14)));
                                }
                              }
                            setState(() {});
                          },
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () {
                                  singleStoreController.storeId.value= getStoreOnMapController.model.value.data![index].id.toString();
                                  print("store id is..${singleStoreController.storeId.value}");
                                  Get.toNamed(StoreScreen.singleStoreScreen);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                      height: 300,
                                     // margin: const EdgeInsets.only(top: 20),
                                      decoration: BoxDecoration(
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //       color: Colors.grey.shade200,
                                          //       blurRadius: 3)
                                          // ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: height * .19,
                                            width: width,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      getStoreOnMapController
                                                          .model
                                                          .value
                                                          .data![index]
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
                                          ),
                                          addHeight(10),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 15,),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  getStoreOnMapController.model
                                                      .value.data![index].name
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Color(0xff21283D),
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                  Row(
                                    children: [
                                      Text("SR",
                                        style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                              fontWeight: FontWeight
                                                  .w400,
                                              color: Color(
                                                  0xff2C4D61)),), SizedBox(width: 3,),
                                      Text("${getStoreOnMapController.model.value.data![index].deliveryCharge}",
                                        style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                              fontWeight: FontWeight
                                                  .w400,
                                              color: Color(
                                                  0xff2C4D61)),), SizedBox(width: 5,),
                                      Icon(Icons.circle,size: 5,color: Color(
                                            0xff2C4D61)),
                                      SizedBox(width: 5,),
                                      Text("KM",
                                        style:  GoogleFonts.ibmPlexSansArabic(fontSize: 12,
                                              fontWeight: FontWeight
                                                  .w400,
                                              color: Color(
                                                  0xff2C4D61)),), SizedBox(width: 3,),
                                      Text(getStoreOnMapController.model.value.data![index].distance
                                            .toString(),

                                        style:  GoogleFonts.ibmPlexSansArabic(fontSize: 14,
                                              fontWeight: FontWeight
                                                  .w400,
                                              color: Color(
                                                  0xff2C4D61)),),
                                      SizedBox(width: 5,),
                                      Icon(Icons.circle,size: 5,color: Color(
                                            0xff2C4D61)),
                                      SizedBox(width: 5,),
                                      Icon(Icons.star,color: Color(0xff2C4D61), size: 17,), SizedBox(width: 3,),
                                      Text(getStoreOnMapController.model.value.data![index].avgRating
                                            .toString(), style:  GoogleFonts.ibmPlexSansArabic(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff2C4D61)),),
                                    ],
                                  ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      )),
                                ));
                          },
                        ),
                      ) : SizedBox();
                    }))
              ],
            )),
      ),
    );
  }
}
