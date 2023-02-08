import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/home_page_controller.dart';
import 'package:fresh2_arrive/controller/near_store_controller.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/main_home_controller.dart';
import '../repositories/near_store_repository.dart';
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
  final homeController = Get.put(HomePageController());
  final nearStoreController = Get.put(NearStoreController());
  RxString selectedCAt = "".obs;
  RxString price = "".obs;
  RxDouble sliderIndex = (0.0).obs;
  final scrollController = ScrollController();

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      nearStoreController
          .getData(context: context)
          .then((value) => setState(() {}));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .03),
            child: Column(
              children: [
                Obx(() {
                  return homeController.isDataLoading.value
                      ? Column(
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
                                    // prefixIcon: Icon(
                                    //   Icons.search_rounded,
                                    //   color: Theme.of(context).iconTheme.color,
                                    // ),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: width * .04),
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
                                  homeController
                                      .model.value.data!.sliderData!.length,
                                  (index) => Container(
                                      width: width,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: width * .01),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: AppTheme.backgroundcolor),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: homeController.model.value
                                              .data!.sliderData![index].image
                                              .toString(),
                                          errorWidget: (_, __, ___) =>
                                              const SizedBox(),
                                          placeholder: (_, __) =>
                                              const SizedBox(),
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
                                  dotsCount: homeController
                                      .model.value.data!.sliderData!.length,
                                  position: sliderIndex.value,
                                  decorator: DotsDecorator(
                                    color:
                                        Colors.grey.shade300, // Inactive color
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
                                  itemCount: homeController.model.value.data!
                                      .bestFreshProduct!.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: height * .02),
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(right: width * .03),
                                      child: Material(
                                        color: AppTheme.backgroundcolor,
                                        borderRadius: BorderRadius.circular(15),
                                        elevation: 0,
                                        child: Container(
                                          width: width * .45,
                                          decoration: BoxDecoration(
                                            color: AppTheme.backgroundcolor,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: height * .12,
                                                        width: width * .25,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: homeController
                                                              .model
                                                              .value
                                                              .data!
                                                              .bestFreshProduct![
                                                                  index]
                                                              .image
                                                              .toString(),
                                                          errorWidget: (_, __,
                                                                  ___) =>
                                                              const SizedBox(),
                                                          placeholder: (_,
                                                                  __) =>
                                                              const SizedBox(),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * .01,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              homeController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .bestFreshProduct![
                                                                      index]
                                                                  .name
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: AppTheme
                                                                      .blackcolor,
                                                                  fontSize:
                                                                      AddSize
                                                                          .font14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          DropdownButtonFormField(
                                                              decoration:
                                                                  InputDecoration(
                                                                fillColor: Colors
                                                                    .grey
                                                                    .shade50,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                enabled: true,
                                                              ),
                                                              hint: Text(
                                                                'Select qty',
                                                                style: TextStyle(
                                                                    color: AppTheme
                                                                        .userText,
                                                                    fontSize:
                                                                        AddSize
                                                                            .font14),
                                                              ),
                                                              // value: selectedCAt
                                                              //             .value ==
                                                              //         ""
                                                              //     ? null
                                                              //     : selectedCAt
                                                              //         .value,
                                                              items:
                                                                  List.generate(
                                                                      homeController
                                                                          .model
                                                                          .value
                                                                          .data!
                                                                          .bestFreshProduct![
                                                                              index]
                                                                          .varints!
                                                                          .length,
                                                                      (index1) =>
                                                                          DropdownMenuItem(
                                                                            value:
                                                                                index1.toString(),
                                                                            child:
                                                                                Text(
                                                                              "${homeController.model.value.data!.bestFreshProduct![index].varints![index1].variantQty}${homeController.model.value.data!.bestFreshProduct![index].varints![index1].variantQtyType}",
                                                                              style: const TextStyle(fontSize: 16),
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
                                                              onChanged:
                                                                  (newValue) {
                                                                selectedCAt
                                                                        .value =
                                                                    newValue
                                                                        .toString();
                                                                for (int i = 0;
                                                                    i <
                                                                        homeController
                                                                            .model
                                                                            .value
                                                                            .data!
                                                                            .bestFreshProduct![index]
                                                                            .varints!
                                                                            .length;
                                                                    i++) {
                                                                  price.value = homeController
                                                                      .model
                                                                      .value
                                                                      .data!
                                                                      .bestFreshProduct![
                                                                          index]
                                                                      .varints![
                                                                          i]
                                                                      .price
                                                                      .toString();
                                                                }
                                                              }
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
                                                                "₹${price.value.toString() == "" ? homeController.model.value.data!.bestFreshProduct![index].varints![0].price.toString() : price.value.toString()}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        AddSize
                                                                            .font14,
                                                                    color: AppTheme
                                                                        .primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              OutlinedButton(
                                                                style: OutlinedButton
                                                                    .styleFrom(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(6))),
                                                                  minimumSize: Size(
                                                                      AddSize
                                                                          .size50,
                                                                      AddSize
                                                                          .size30),
                                                                  side: const BorderSide(
                                                                      color: AppTheme
                                                                          .primaryColor,
                                                                      width: 1),
                                                                  backgroundColor:
                                                                      AppTheme
                                                                          .addColor,
                                                                ),
                                                                onPressed:
                                                                    () {},
                                                                child: Text(
                                                                    'ADD',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            AddSize
                                                                                .font12,
                                                                        color: AppTheme
                                                                            .primaryColor,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
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
                                  itemCount: homeController.model.value.data!
                                      .bestFreshProduct!.length,
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
                                                      ? AppTheme
                                                          .appPrimaryGreenColor
                                                      : AppTheme
                                                          .appPrimaryYellowColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: AddSize.padding10,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  height: AddSize.size50,
                                                  width: AddSize.size80,
                                                  child: CachedNetworkImage(
                                                    imageUrl: homeController
                                                        .model
                                                        .value
                                                        .data!
                                                        .sliderData![index]
                                                        .image
                                                        .toString(),
                                                    errorWidget: (_, __, ___) =>
                                                        const SizedBox(),
                                                    placeholder: (_, __) =>
                                                        const SizedBox(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                // Image(
                                                //   image: const AssetImage(
                                                //       AppAssets.category_image),
                                                //   height: AddSize.size50,
                                                //   width: AddSize.size80,
                                                //   fit: BoxFit.cover,
                                                // ),
                                                const Text(
                                                  "Fruits",
                                                  style: TextStyle(
                                                      color: AppTheme.subText,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                  itemCount: homeController
                                      .model.value.data!.featuredStores!.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: height * .02),
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(right: width * .03),
                                      child: Material(
                                        color: AppTheme.backgroundcolor,
                                        borderRadius: BorderRadius.circular(16),
                                        elevation: 0,
                                        child: Container(
                                          width: width * .5,
                                          decoration: BoxDecoration(
                                            color: AppTheme.backgroundcolor,
                                            borderRadius:
                                                BorderRadius.circular(16),
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: height * .19,
                                                        width: width * .44,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: homeController
                                                                .model
                                                                .value
                                                                .data!
                                                                .featuredStores![
                                                                    index]
                                                                .image
                                                                .toString(),
                                                            errorWidget: (_, __,
                                                                    ___) =>
                                                                const SizedBox(),
                                                            placeholder: (_,
                                                                    __) =>
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
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              homeController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .featuredStores![
                                                                      index]
                                                                  .name
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: AppTheme
                                                                      .blackcolor,
                                                                  fontSize:
                                                                      AddSize
                                                                          .font14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
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
                                                            height:
                                                                height * .01,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .location_on,
                                                                color: AppTheme
                                                                    .primaryColor,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    width * .02,
                                                              ),
                                                              Text(
                                                                "${homeController.model.value.data!.featuredStores![index].distance.toString()}KM",
                                                                style: TextStyle(
                                                                    color: AppTheme
                                                                        .blackcolor,
                                                                    fontSize:
                                                                        AddSize
                                                                            .font12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
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
                          ],
                        )
                      : const Center(child: CircularProgressIndicator());
                }),
                Obx(() {
                  return nearStoreController.isDataLoading.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * .02,
                            ),
                            nearStoreController.model.value.data!.isEmpty
                                ? const Text(
                                    'Stores Near You',
                                    style: TextStyle(
                                        color: AppTheme.backgroundcolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    '(${nearStoreController.model.value.data!.length}) Stores Near You',
                                    style: const TextStyle(
                                        color: AppTheme.backgroundcolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                            SizedBox(
                              height: height * .01,
                            ),
                            Obx(() {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: nearStoreController
                                    .model.value.data!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            StoreScreen.singleStoreScreen);
                                      },
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                              color: AppTheme.backgroundcolor,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AddSize.padding10,
                                                vertical: AddSize.padding10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: height * .19,
                                                  width: width,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          nearStoreController
                                                              .model
                                                              .value
                                                              .data![index]
                                                              .image
                                                              .toString(),
                                                      errorWidget:
                                                          (_, __, ___) =>
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      nearStoreController
                                                          .model
                                                          .value
                                                          .data![index]
                                                          .name
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .blackcolor,
                                                          fontSize:
                                                              AddSize.font14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.location_on,
                                                          color: AppTheme
                                                              .primaryColor,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: width * .02,
                                                        ),
                                                        Text(
                                                          "${nearStoreController.model.value.data![index].distance.toString()} KM",
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .blackcolor,
                                                              fontSize: AddSize
                                                                  .font12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )));
                                },
                              );
                            }),
                            SizedBox(
                              height: height * .04,
                            )
                          ],
                        )
                      : SizedBox();
                })
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
