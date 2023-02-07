import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/routers/my_router.dart';
import 'package:fresh2_arrive/screens/order/choose_address.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/main_home_controller.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static var homePage = "/homePage";

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final controller = Get.put(MainHomeController());
  final searchController = TextEditingController();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  final List<String> categoryData = ["Fruits", "Vegie", "Dairy", "Juice"];
  final List<String> distanceData = ["Fruits", "Vegie", "Dairy", "Juice"];
  RxString selectedCAt = "".obs;
  final List<String> dropDownList = ["500g", "1Kg"];

  @override
  void initState() {
    super.initState();
    checkGps();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });
        getLocation();
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text(
                  "Location",
                ),
                content: const Text(
                  "Please turn on GPS location service to narrow down the nearest eateries.",
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Approve'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await Geolocator.openLocationSettings();
                      servicestatus =
                          await Geolocator.isLocationServiceEnabled();
                      if (servicestatus) {
                        permission = await Geolocator.checkPermission();

                        if (permission == LocationPermission.denied) {
                          permission = await Geolocator.requestPermission();
                          if (permission == LocationPermission.denied) {
                            print('Location permissions are denied');
                          } else if (permission ==
                              LocationPermission.deniedForever) {
                            print(
                                "Location permissions are permanently denied");
                          } else {
                            haspermission = true;
                          }
                        } else {
                          haspermission = true;
                        }

                        if (haspermission) {
                          setState(() {
                            //refresh the UI
                          });

                          getLocation();
                        }
                      }
                    },
                  ),
                ],
              ));

      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('latitude', lat.toString());
    prefs.setString('longitude', long.toString());
    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    // StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        // print('Latitude :: ' +
        //     position.longitude.toString()); //Output: 80.24599079
        // print('Longitude :: ' +
        //     position.latitude.toString()); //Output: 29.6593457

        //refresh UI on update
      });
    });
  }

  RxDouble sliderIndex = (0.0).obs;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double itemHeight = screenSize.height / 2.8;
    final double itemWidth = screenSize.width / 2;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * .04,
                ),
                SizedBox(
                  height: height * .07,
                  child: TextField(
                    maxLines: 1,
                    controller: searchController,
                    style: const TextStyle(fontSize: 17),
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) => {},
                    decoration: InputDecoration(
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search_rounded,
                            color: AppTheme.primaryColor,
                            size: 30,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: width * .04),
                        hintText: 'Search Your Groceries',
                        hintStyle: TextStyle(
                            fontSize: AddSize.font14,
                            color: AppTheme.blackcolor,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                SizedBox(
                  height: height * .015,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      onPageChanged: (value, _) {
                        sliderIndex.value = value.toDouble();
                      },
                      autoPlayCurve: Curves.ease,
                      height: height * .20),
                  items: List.generate(
                      3,
                      (index) => Container(
                          width: width,
                          margin: EdgeInsets.symmetric(horizontal: width * .01),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppTheme.backgroundcolor),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://media.istockphoto.com/id/1328991116/photo/fresh-vegetables-and-fruits-on-counter-in-grocery-supermarket.jpg?b=1&s=170667a&w=0&k=20&c=yPu0rw6pU8oD4c3YR91bzKQx2GxyZxBQFpzMwVwR_g4=",
                              errorWidget: (_, __, ___) => const SizedBox(),
                              placeholder: (_, __) => const SizedBox(),
                              fit: BoxFit.cover,
                            ),
                          ))),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Obx(() {
                  return Center(
                    child: DotsIndicator(
                      dotsCount: 3,
                      position: sliderIndex.value,
                      decorator: DotsDecorator(
                        color: Colors.grey.shade300, // Inactive color
                        activeColor: AppTheme.primaryColor,
                        size: const Size.square(12),
                        activeSize: const Size.square(12),
                      ),
                    ),
                  );
                }),
                const Text(
                  'Best Fresh Product',
                  style: TextStyle(
                      color: AppTheme.blackcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * .35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: height * .02),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: width * .03),
                          child: Material(
                            color: AppTheme.backgroundcolor,
                            borderRadius: BorderRadius.circular(15),
                            elevation: 0,
                            child: Container(
                              width: width * .45,
                              decoration: BoxDecoration(
                                color: AppTheme.backgroundcolor,
                                borderRadius: BorderRadius.circular(10),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.shade100,
                                //     offset: const Offset(
                                //       5.0,
                                //       5.0,
                                //     ),
                                //     blurRadius: 20.0,
                                //     spreadRadius: 2.0,
                                //   ),
                                // ]
                              ),
                              // height: height * .23,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * .03,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * .12,
                                            width: width * .25,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://media.istockphoto.com/id/673162168/photo/green-cabbage-isolated-on-white.jpg?s=612x612&w=0&k=20&c=mCc4mXATvCcfp2E9taRJBp-QPYQ_LCj6nE1D7geaqVk=",
                                              errorWidget: (_, __, ___) =>
                                                  const SizedBox(),
                                              placeholder: (_, __) =>
                                                  const SizedBox(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * .01,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Coriander Leaves And Greens",
                                                  style: TextStyle(
                                                      color:
                                                          AppTheme.blackcolor,
                                                      fontSize: AddSize.font14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  fillColor:
                                                      Colors.grey.shade50,
                                                  border: InputBorder.none,
                                                  enabled: true,
                                                ),
                                                hint: Text(
                                                  'Select qty',
                                                  style: TextStyle(
                                                      color: AppTheme.userText,
                                                      fontSize: AddSize.font14),
                                                ),
                                                // value: selectedCAt.value == ""
                                                //     ? null
                                                //     : selectedCAt.value,
                                                items: List.generate(
                                                    index + 2,
                                                    (index1) =>
                                                        DropdownMenuItem(
                                                          value:
                                                              index1.toString(),
                                                          child: Text(
                                                            "${index1}Kg",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        )),
                                                // items: dropDownList.map((value) {
                                                //   return DropdownMenuItem(
                                                //     value: value,
                                                //     child: Text(
                                                //       value,
                                                //       style: const TextStyle(
                                                //           fontSize: 16),
                                                //     ),
                                                //   );
                                                // }).toList(),
                                                onChanged: (newValue) {
                                                  selectedCAt.value =
                                                      newValue.toString();
                                                },
                                                // validator: (String? value) {
                                                //   if (value?.isEmpty ?? true) {
                                                //     return 'Please select bank';
                                                //   }
                                                //   return null;
                                                // },
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "₹15.00",
                                                    style: TextStyle(
                                                        fontSize:
                                                            AddSize.font14,
                                                        color: AppTheme
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                      minimumSize: Size(
                                                          AddSize.size50,
                                                          AddSize.size30),
                                                      side: const BorderSide(
                                                          color: AppTheme
                                                              .primaryColor,
                                                          width: 1),
                                                      backgroundColor:
                                                          AppTheme.addColor,
                                                    ),
                                                    onPressed: () {},
                                                    child: Text('ADD',
                                                        style: TextStyle(
                                                            fontSize:
                                                                AddSize.font12,
                                                            color: AppTheme
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  )
                                                ],
                                              ),
                                              // OutlinedButton(
                                              //   style: OutlinedButton.styleFrom(
                                              //     shape: const RoundedRectangleBorder(
                                              //         borderRadius: BorderRadius.all(
                                              //             Radius.circular(10))),
                                              //     side: const BorderSide(
                                              //         color: AppTheme.primaryColor,
                                              //         width: 1),
                                              //     backgroundColor: AppTheme.addColor,
                                              //   ),
                                              //   onPressed: () {},
                                              //   child: const Text('ADD',
                                              //       style: TextStyle(
                                              //           color: AppTheme.primaryColor,
                                              //           fontWeight: FontWeight.w600)),
                                              // ),
                                            ],
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Get here what you want',
                      style: TextStyle(
                          color: AppTheme.blackcolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View All',
                        style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                SizedBox(
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 12,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.back();
                            controller.onItemTap(3);
                          },
                          child: Container(
                              // margin: const EdgeInsets.only(right: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.size5,
                                  vertical: AddSize.size5),
                              decoration: BoxDecoration(
                                  color: index % 3 == 0
                                      ? AppTheme.appPrimaryPinkColor
                                      : index % 3 == 2
                                          ? AppTheme.appPrimaryGreenColor
                                          : AppTheme.appPrimaryYellowColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding10,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image(
                                      image: const AssetImage(
                                          AppAssets.category_image),
                                      height: AddSize.size50,
                                      width: AddSize.size80,
                                      fit: BoxFit.cover,
                                    ),
                                    const Text(
                                      "Fruits",
                                      style: TextStyle(
                                          color: AppTheme.subText,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              )),
                        );
                      }),
                ),
                SizedBox(
                  height: height * .02,
                ),
                const Text(
                  'Featured Stores',
                  style: TextStyle(
                      color: AppTheme.blackcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * .33,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: height * .02),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: width * .03),
                          child: Material(
                            color: AppTheme.backgroundcolor,
                            borderRadius: BorderRadius.circular(16),
                            elevation: 0,
                            child: Container(
                              width: width * .5,
                              decoration: BoxDecoration(
                                color: AppTheme.backgroundcolor,
                                borderRadius: BorderRadius.circular(16),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.shade100,
                                //     offset: const Offset(
                                //       5.0,
                                //       5.0,
                                //     ),
                                //     blurRadius: 20.0,
                                //     spreadRadius: 2.0,
                                //   ),
                                // ]
                              ),
                              // height: height * .23,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * .03,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * .19,
                                            width: width * .44,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://media.istockphoto.com/id/1328991116/photo/fresh-vegetables-and-fruits-on-counter-in-grocery-supermarket.jpg?b=1&s=170667a&w=0&k=20&c=yPu0rw6pU8oD4c3YR91bzKQx2GxyZxBQFpzMwVwR_g4=",
                                                errorWidget: (_, __, ___) =>
                                                    const SizedBox(),
                                                placeholder: (_, __) =>
                                                    const SizedBox(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * .01,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Store abcd@ 3125A\n# market",
                                                  style: TextStyle(
                                                      color:
                                                          AppTheme.blackcolor,
                                                      fontSize: AddSize.font14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              // Container(
                                              //   width: width * .20,
                                              //   padding:
                                              //       const EdgeInsets.symmetric(
                                              //           horizontal: 20.0),
                                              //   decoration: BoxDecoration(
                                              //       borderRadius:
                                              //           BorderRadius.circular(
                                              //               8.0),
                                              //       color: Colors.grey.shade200),
                                              //   child:
                                              //       DropdownButtonHideUnderline(
                                              //     child: DropdownButton(
                                              //       isExpanded: false,
                                              //       value: selectedCAt == ""
                                              //           ? null
                                              //           : selectedCAt,
                                              //       items:
                                              //           DropDownList.map((value) {
                                              //         return DropdownMenuItem(
                                              //           value: value.toString(),
                                              //           child: Text(
                                              //             value,
                                              //             style: TextStyle(
                                              //                 fontSize: 14),
                                              //           ),
                                              //         );
                                              //       }).toList(),
                                              //       onChanged: (newValue) {
                                              //         setState(() {
                                              //           selectedCAt =
                                              //               newValue as String?;
                                              //           print("object000" +
                                              //               selectedCAt
                                              //                   .toString());
                                              //         });
                                              //       },
                                              //     ),
                                              //   ),
                                              // ),
                                              SizedBox(
                                                height: height * .01,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    color:
                                                        AppTheme.primaryColor,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: width * .02,
                                                  ),
                                                  Text(
                                                    "2KM",
                                                    style: TextStyle(
                                                        color:
                                                            AppTheme.blackcolor,
                                                        fontSize:
                                                            AddSize.font12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              // OutlinedButton(
                                              //   style: OutlinedButton.styleFrom(
                                              //     shape: const RoundedRectangleBorder(
                                              //         borderRadius: BorderRadius.all(
                                              //             Radius.circular(10))),
                                              //     side: const BorderSide(
                                              //         color: AppTheme.primaryColor,
                                              //         width: 1),
                                              //     backgroundColor: AppTheme.addColor,
                                              //   ),
                                              //   onPressed: () {},
                                              //   child: const Text('ADD',
                                              //       style: TextStyle(
                                              //           color: AppTheme.primaryColor,
                                              //           fontWeight: FontWeight.w600)),
                                              // ),
                                            ],
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: height * .02,
                ),
                const Text(
                  '(24) Stores Near You',
                  style: TextStyle(
                      color: AppTheme.blackcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * .01,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          Get.toNamed(StoreScreen.singleStoreScreen);
                        },
                        child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: AppTheme.backgroundcolor,
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding10,
                                  vertical: AddSize.padding10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * .19,
                                    width: width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://media.istockphoto.com/id/1328991116/photo/fresh-vegetables-and-fruits-on-counter-in-grocery-supermarket.jpg?b=1&s=170667a&w=0&k=20&c=yPu0rw6pU8oD4c3YR91bzKQx2GxyZxBQFpzMwVwR_g4=",
                                        errorWidget: (_, __, ___) =>
                                            const SizedBox(),
                                        placeholder: (_, __) =>
                                            const SizedBox(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  addHeight(10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Store abcd@3125A#",
                                        style: TextStyle(
                                            color: AppTheme.blackcolor,
                                            fontSize: AddSize.font14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: AppTheme.primaryColor,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: width * .02,
                                          ),
                                          Text(
                                            "2KM",
                                            style: TextStyle(
                                                color: AppTheme.blackcolor,
                                                fontSize: AddSize.font12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )));
                  },
                ),
                SizedBox(
                  height: height * .04,
                )
              ],
            )),
      ),
    );
  }

  void applySearch(BuildContext context) {
    // final controller = Get.put(SearchController());
    // controller.context = context;
    // if (searchController.text.isEmpty) {
    //   showToast('Please enter something to search');
    // } else {
    //   Get.toNamed(MyRouter.searchProductScreen,
    //       arguments: [searchController.text]);
    //   searchController.clear();
    //   FocusManager.instance.primaryFocus?.unfocus();
    // }
  }

// Widget categoryList(List<Categories> categories, int index) {
//   return InkWell(
//     onTap: () {
//       Get.toNamed(MyRouter.categoryScreen, arguments: [
//         categories,
//         categories[index].termId,
//       ]);
//     },
//     child: Container(
//         margin: const EdgeInsets.only(right: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         decoration: BoxDecoration(boxShadow: const [
//           BoxShadow(
//             color: Colors.grey,
//             blurRadius: 1.0,
//           ),
//         ], color: Colors.white, borderRadius: BorderRadius.circular(6)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
//           child: Row(
//             children: [
//               // CAtegory Image commented
//
//               // Material(
//               //   borderRadius: BorderRadius.circular(50),
//               //   elevation: 3,
//               //   child: SizedBox(
//               //     height: 30,
//               //     width: 30,
//               //     child: ClipRRect(
//               //       borderRadius:
//               //           const BorderRadius.all(Radius.circular(100)),
//               //       child: Image.network(
//               //         categories[index].imageUrl.toString(),
//               //         fit: BoxFit.cover,
//               //         loadingBuilder: (BuildContext context, Widget child,
//               //             ImageChunkEvent? loadingProgress) {
//               //           if (loadingProgress == null) {
//               //             return child;
//               //           }
//               //           return Center(
//               //             child: Padding(
//               //               padding: const EdgeInsets.only(
//               //                   top: 10.0, bottom: 10.0),
//               //               child: CircularProgressIndicator(
//               //                 color: AppTheme.primaryColor,
//               //                 value: loadingProgress.expectedTotalBytes !=
//               //                         null
//               //                     ? loadingProgress.cumulativeBytesLoaded /
//               //                         loadingProgress.expectedTotalBytes!
//               //                     : null,
//               //               ),
//               //             ),
//               //           );
//               //         },
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               // addWidth(8),
//               Text(
//                 categories[index].name.toString(),
//                 style: const TextStyle(
//                     color: AppTheme.textColorDarkBLue,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500),
//               )
//             ],
//           ),
//         )),
//   );
// }
}
