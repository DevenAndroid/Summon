
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
      singleStoreController.getSingleStoreData();
      // singleStoreController.getStoreDetails(isFirstTime: true);
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
                                       style:  GoogleFonts.ibmPlexSansArabic(
                                           fontSize: 14,
                                           color: Color(0xff5DB923),
                                           fontWeight: FontWeight.w700),
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
                                       style:  GoogleFonts.ibmPlexSansArabic(
                                           fontSize: 13,
                                           color: Color(0xff606573),
                                           fontWeight: FontWeight.w400),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(
                                       singleStoreController
                                           .storeDetailsModel
                                           .value
                                           .data!
                                           .storeDetails!
                                           .storeName
                                           .toString()
                                           .capitalizeFirst!,
                                       style: GoogleFonts.ibmPlexSansArabic(
                                           fontSize: 17,
                                           color: Color(0xff293044),
                                           fontWeight: FontWeight.w700),
                                     ),
                                     Flexible(child: Container()),
                                     Icon(Icons.star,size: 20,color: Color(0xff606573),),
                                          SizedBox(width: 5,),
                                     Text(
                                       singleStoreController
                                           .storeDetailsModel
                                           .value
                                           .data!
                                           .storeDetails!
                                           .avgRating
                                           .toString(),
                                       style: GoogleFonts.ibmPlexSansArabic(
                                           fontSize: 14,
                                           color: Color(0xff293044),
                                           fontWeight: FontWeight.w400),
                                     )
                                   ],
                                 ),
                                  SizedBox(height: 5,),
                                  Row(
                                    //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
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
                                      Flexible(child: Container()),
                                      ...singleStoreController.storeDetailsModel.value.data!.storeDetails!.storeCategories!.map((e) =>
                                          InkWell(
                                        onTap: () {
                                        },
                                        child: Expanded(
                                          child: Container(
                                            margin: EdgeInsets.all(5.0),
                                             height: 35,
                                             width: 70,
                                            decoration: BoxDecoration(
                                                color: Color(0xffF2F2F2),
                                                borderRadius: BorderRadius.circular(
                                                    6)

                                            ),
                                            child: Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 7),
                                                child: Text(e,
                                                  textAlign:TextAlign.center,style: GoogleFonts.ibmPlexSansArabic(fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color:Color(0xff000000)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )).toList()
                                    ],
                                  ),
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

                        ListView.builder(
                            itemCount: singleStoreController
                                .storeDetailsModel
                                .value
                                .data!.latestProducts!.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: height * .015,
                            ),
                            physics:
                            const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(singleStoreController
                                        .storeDetailsModel
                                        .value
                                        .data!
                                        .latestProducts![
                                    index].title.toString(),style: GoogleFonts.ibmPlexSansArabic(
                                        color: Color(0xff293044),
                                        fontSize:
                                        16,
                                        fontWeight:
                                        FontWeight.w700),),
                                    SizedBox(height: height* .01,),
                                    GestureDetector(
                                      onTap:(){
                                        singleProductController.id.value =
                                            singleStoreController
                                                .storeDetailsModel
                                                .value
                                                .data!
                                                .latestProducts![index].productData![0]
                                                .id
                                                .toString();
                                        print(
                                            singleProductController.id.value);
                                        Get.toNamed(SingleProductPage
                                            .singleProductPage);

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
                                                              1.8,
                                                          width:
                                                          AddSize.size50 *
                                                              1.8,
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
                                                              index].productData![0]
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
                                                          width: width * .05,
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
                                                                  index].productData![0]
                                                                      .name
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  style:  GoogleFonts.ibmPlexSansArabic(
                                                                      color: Color(0xff151515),
                                                                      fontSize:
                                                                      16,
                                                                      fontWeight:
                                                                      FontWeight.w600)),
                                                              SizedBox(height: 10,),
                                                              Text(
                                                                  singleStoreController
                                                                      .storeDetailsModel
                                                                      .value
                                                                      .data!
                                                                      .latestProducts![
                                                                  index].productData![0]
                                                                      .content
                                                                      .toString().capitalizeFirst!,
                                                                 // maxLines: 2,
                                                                  style:  GoogleFonts.ibmPlexSansArabic(
                                                                      color: Color(0xff7B7B80),
                                                                      fontSize:
                                                                      13,
                                                                      fontWeight:
                                                                      FontWeight.w400)),
                                                              SizedBox(height: 5,),

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
                                                                        "Cal",
                                                                        style:  GoogleFonts.ibmPlexSansArabic(
                                                                            fontSize: 12,
                                                                            color: Color(0xff8E8E8E),
                                                                            fontWeight: FontWeight.w300),
                                                                      ),
                                                                      SizedBox(width: 3,),
                                                                      Text(
                                                                        singleStoreController
                                                                            .storeDetailsModel
                                                                            .value
                                                                            .data!
                                                                            .latestProducts![
                                                                        index].productData![0].calories
                                                                            .toString(),
                                                                        style:  GoogleFonts.ibmPlexSansArabic(
                                                                            fontSize: 12,
                                                                            color: Color(0xff8E8E8E),
                                                                            fontWeight: FontWeight.w300),
                                                                      ),
                                                                      SizedBox(width: 6,),
                                                                      Text(
                                                                        "SR",
                                                                        style:  GoogleFonts.ibmPlexSansArabic(
                                                                            fontSize: 15,
                                                                            color: AppTheme.primaryColor,
                                                                            fontWeight: FontWeight.w700),
                                                                      ),
                                                                      SizedBox(width: 4,),
                                                                      Text(
                                                                        singleStoreController
                                                                            .storeDetailsModel
                                                                            .value
                                                                            .data!
                                                                            .latestProducts![
                                                                        index].productData![0]
                                                                            .variants![0].price
                                                                            .toString().substring(0,2),
                                                                        style:  GoogleFonts.ibmPlexSansArabic(
                                                                            fontSize: 15,
                                                                            color: AppTheme.primaryColor,
                                                                            fontWeight: FontWeight.w700),
                                                                      ),

                                                                    ],
                                                                  ),

                                                                  // OutlinedButton(
                                                                  //   style: OutlinedButton
                                                                  //       .styleFrom(
                                                                  //     shape: const RoundedRectangleBorder(
                                                                  //         borderRadius:
                                                                  //         BorderRadius.all(Radius.circular(6))),
                                                                  //     minimumSize: Size(
                                                                  //         AddSize.size50,
                                                                  //         AddSize.size30),
                                                                  //     side: const BorderSide(
                                                                  //         color:
                                                                  //         AppTheme.primaryColor,
                                                                  //         width: 1),
                                                                  //     backgroundColor:
                                                                  //     Color(0xffFFE1D9),
                                                                  //   ),
                                                                  //   onPressed:
                                                                  //       () {
                                                                  //     singleProductController.id.value =
                                                                  //         singleStoreController
                                                                  //             .storeDetailsModel
                                                                  //             .value
                                                                  //             .data!
                                                                  //             .latestProducts![index].productData![index]
                                                                  //             .id
                                                                  //             .toString();
                                                                  //     print(
                                                                  //         singleProductController.id.value);
                                                                  //     Get.toNamed(SingleProductPage
                                                                  //         .singleProductPage);
                                                                  //   },
                                                                  //   child: Text(
                                                                  //       "SELECT",
                                                                  //       style: TextStyle(
                                                                  //           fontSize: AddSize.font12,
                                                                  //           color: AppTheme.primaryColor,
                                                                  //           fontWeight: FontWeight.w600)),
                                                                  // )
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

                                    ),
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                  ],
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
