
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/My_cart_controller.dart';
import '../controller/SingleProductController.dart';
import '../controller/main_home_controller.dart';

import '../controller/single_store_controller.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import 'OneProduct_Screen.dart';
import 'SingleProdct_Screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);
  static var singleStoreScreen = "/singleStoreScreen";

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  //final singleStoreController = Get.put(StoreController());
  final singleStoreController = Get.put(SingleStoreController());
  final myCartController = Get.put(MyCartDataListController());
  final controller = Get.put(MainHomeController());
  final singleProductController = Get.put(SingleProductController());
  String? selectedCAt;
  final scrollController = ScrollController();

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // storeController
      //     .getData(context: context)
      //     .then((value) => setState(() {}));
      singleStoreController.getStoreDetails();
      scrollController.addListener(_scrollListener);
    }
  }
  //for make call
  _makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      singleStoreController.getStoreDetails(isFirstTime: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.grey.shade50,
          //backgroundColor: Color(0xffFFFFFF),
          appBar: backAppBar(title: "Store", context: context),
          body:
          singleStoreController.isDataLoading.value &&
              singleStoreController.storeDetailsModel.value.data != null
              ? CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                excludeHeaderSemantics: false,
                snap: false,
                floating: false,
                expandedHeight: height * .285,
                backgroundColor: Colors.white,
                elevation: 0,
                leadingWidth: 0,
                // toolbarHeight: 150,
                // title: ,
                bottom: PreferredSize(
                    preferredSize: Size(width, AddSize.size40 * 2.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * .03),
                          child: Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding16,
                                  vertical: AddSize.padding10),
                              // height: 100,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(
                                       singleStoreController
                                           .storeDetailsModel
                                           .value
                                           .data!
                                           .storeDetails!
                                           .availability
                                           .toString()
                                           .capitalizeFirst!,
                                       style: const TextStyle(
                                           fontSize: 13,
                                           color: Color(0xff5DB923),
                                           fontWeight: FontWeight.w500),
                                     ),
                                     Text(
                                       "${singleStoreController
                                           .storeDetailsModel
                                           .value
                                           .data!
                                           .storeDetails!
                                           .distance
                                           .toString()
                                           .capitalizeFirst!} KM",
                                       style: const TextStyle(
                                           fontSize: 12,
                                           color: Color(0xff606573),
                                           fontWeight: FontWeight.w400),
                                     ),
                                   ],
                                 ),
                                  Text(
                                    singleStoreController
                                        .storeDetailsModel
                                        .value
                                        .data!
                                        .storeDetails!
                                        .storeName
                                        .toString()
                                        .capitalizeFirst!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff293044),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      singleStoreController
                                          .storeDetailsModel
                                          .value
                                          .data!
                                          .storeDetails!
                                          .importedChicken == true ? Text("Imported Chicken",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xffFE724C),
                                            fontWeight: FontWeight.w500),
                                      ):SizedBox(),
                                      InkWell(
                                        onTap: () async {

                                          Uri phoneno =
                                          Uri.parse("tel:${singleStoreController
                                              .storeDetailsModel
                                              .value
                                              .data!
                                              .storeDetails!
                                              .phone
                                              .toString()}");
                                          if (await launchUrl(phoneno)) {
                                          } else {
                                          }

                                        },
                                        child: Image(
                                          height: 35,
                                          width: 35,
                                          image: AssetImage(AppAssets.callImage),
                                        ),
                                      ),
                                    ],
                                  ),
                                  singleStoreController
                                      .storeDetailsModel
                                      .value
                                      .data!
                                      .storeDetails!
                                      .importedMeat == true ? Text("Imported meat",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xffFE724C),
                                        fontWeight: FontWeight.w500),
                                  ):SizedBox(),
                                  SizedBox(
                                    height: height * .01,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    )),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.only(bottom: AddSize.size45,top: 1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: singleStoreController.storeDetailsModel
                            .value.data!.storeDetails!.storeImage
                            .toString(),
                        errorWidget: (_, __, ___) => const SizedBox(),
                        placeholder: (_, __) => const SizedBox(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Image.network(
                    //   singleStoreController.storeDetailsModel.value.data!
                    //       .storeDetails!.storeImage
                    //       .toString(),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: width * .03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * .015),
                        const Text(
                          "Today's Menu",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        ListView.builder(
                            itemCount: singleStoreController
                                .storeDetailsModel
                                .value
                                .data!
                                .latestProducts!
                                .length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: height * .015,
                            ),
                            physics:
                            const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // singleProductController.id.value =
                                  //     singleStoreController
                                  //         .storeDetailsModel
                                  //         .value
                                  //         .data!
                                  //         .latestProducts![index]
                                  //         .id
                                  //         .toString();
                                  // print(
                                  //     singleProductController.id.value);
                                  // Get.toNamed(SingleProductPage
                                  //     .singleProductPage);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  // height: height * .23,
                                  child: Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10)),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.symmetric(
                                              horizontal: width * .03,
                                              vertical: height * .02,
                                            ),
                                            child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  SizedBox(
                                                    height:
                                                    AddSize.size50 *
                                                        1.5,
                                                    width:
                                                    AddSize.size50 *
                                                        1.6,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          10),
                                                      child:
                                                      CachedNetworkImage(
                                                        imageUrl: singleStoreController
                                                            .storeDetailsModel
                                                            .value
                                                            .data!
                                                            .latestProducts![
                                                        index]
                                                            .image
                                                            .toString(),
                                                        errorWidget: (_,
                                                            __,
                                                            ___) =>
                                                        const SizedBox(),
                                                        placeholder: (_,
                                                            __) =>
                                                        const SizedBox(),
                                                        fit: BoxFit
                                                            .cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width * .04,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                            singleStoreController
                                                                .storeDetailsModel
                                                                .value
                                                                .data!
                                                                .latestProducts![
                                                            index]
                                                                .name
                                                                .toString(),
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                color: AppTheme
                                                                    .blackcolor,
                                                                fontSize:
                                                                16,
                                                                fontWeight:
                                                                FontWeight.w500)),
                                                        // SizedBox(
                                                        //   height: height *
                                                        //       .01,
                                                        // ),
                                                        Container(
                                                          // width: width * .60,
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                              width *
                                                                  .02),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  8.0),
                                                              color: Colors
                                                                  .grey
                                                                  .shade100),
                                                          child: singleStoreController
                                                              .storeDetailsModel
                                                              .value
                                                              .data!
                                                              .latestProducts![
                                                          index]
                                                              .type ==
                                                              "Variable"
                                                              ?
                                                          buildDropdownButtonFormField(
                                                              index)
                                                              : SizedBox(),
                                                        ),
                                                        // SizedBox(
                                                        //   height: height *
                                                        //       .01,
                                                        // ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  "\$" +
                                                                      (singleStoreController.storeDetailsModel.value.getVariant(index: index).price.toString()),
                                                                  style: const TextStyle(
                                                                      fontSize: 15,
                                                                      color: AppTheme.primaryColor,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                              ],
                                                            ),

                                                            OutlinedButton(
                                                              style: OutlinedButton
                                                                  .styleFrom(
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius.all(Radius.circular(6))),
                                                                minimumSize: Size(
                                                                    AddSize.size50,
                                                                    AddSize.size30),
                                                                side: const BorderSide(
                                                                    color:
                                                                    AppTheme.primaryColor,
                                                                    width: 1),
                                                                backgroundColor:
                                                                Color(0xffFFE1D9),
                                                              ),
                                                              onPressed:
                                                                  () {
                                                                singleProductController.id.value =
                                                                    singleStoreController
                                                                        .storeDetailsModel
                                                                        .value
                                                                        .data!
                                                                        .latestProducts![index]
                                                                        .id
                                                                        .toString();
                                                                print(
                                                                    singleProductController.id.value);
                                                                Get.toNamed(SingleProductPage
                                                                    .singleProductPage);
                                                              },
                                                              child: Text(
                                                                  "SELECT",
                                                                  style: TextStyle(
                                                                      fontSize: AddSize.font12,
                                                                      color: AppTheme.primaryColor,
                                                                      fontWeight: FontWeight.w600)),
                                                            )
                                                          ],
                                                        ),
                                                        // this is for dropdown testing code
                                                        // Text(singleStoreController.storeDetailsModel.value.data!
                                                        //     .latestProducts![index].variants!.map((e) => e.id.toString()).toList().toString()),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            }),
                        SizedBox(
                          height: height * .13,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
              : const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              )),
          extendBody: true,
          bottomNavigationBar: myCartController.isDataLoaded.value &&
              myCartController.model.value.data!.cartItems!.isNotEmpty
              ? addCartSection()
              : null,
        ),
      );
    });
  }
  buildDropdownButtonFormField(int index) {
    return Obx(() {
      return DropdownButtonFormField<dynamic>(
          decoration: InputDecoration(
            fillColor: Colors.grey.shade50,
            border: InputBorder.none,
            enabled: true,
          ),
          //value: null,
          // singleStoreController.storeDetailsModel.value.data!
          //     .latestProducts![index].varientIndex.value,
          hint: Text(
            'Select qty',
            style:
            TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
          ),
          items:
          // List.generate(
          //     singleStoreController.storeDetailsModel.value.data!
          //         .latestProducts![index].variants!.length,
          //         (index1) => DropdownMenuItem(
          //       value: singleStoreController.storeDetailsModel.value.data!
          //           .latestProducts![index].variants![index1].size
          //           .toString(),
          //       child: Text(
          //         "${singleStoreController.storeDetailsModel.value.data!.latestProducts![index].variants![index1].sizeName}",
          //         style: const TextStyle(fontSize: 16),
          //       ),
          //     )),

          singleStoreController.storeDetailsModel.value.data!
              .latestProducts![index].variants!.map((e) => DropdownMenuItem(
            value: e.id.toString(),
              child: Text(e.sizeName.toString()))).toList(),
          onChanged: (newValue) {
            singleStoreController.storeDetailsModel.value.data!
                .latestProducts![index].varientIndex!.value = newValue!;
            print(singleStoreController.storeDetailsModel.value.data!
                .latestProducts![index].varientIndex!.value);
            setState(() {});
          });
    });
  }
}
