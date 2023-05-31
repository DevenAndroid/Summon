import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fresh2_arrive/model/SingleProductModel.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/CartController.dart';
import '../controller/HomePageController1.dart';
import '../controller/SingleProductController.dart';
import '../controller/main_home_controller.dart';
import '../model/MyCartDataListModel.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../repositories/WishList_Repository.dart';
import '../resources/app_assets.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import 'MyCart_Page.dart';
import 'package:collection/collection.dart';

class SingleProductPage extends StatefulWidget {
  const SingleProductPage({Key? key}) : super(key: key);
  static var singleProductPage = "/singleProductPage";

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  final singleProductController = Get.put(SingleProductController());
  final myCartController = Get.put(MyCartController());
  final homeController1 = Get.put(HomePageController1());
  final TextEditingController noteController = TextEditingController();
  final controller = Get.put(MainHomeController());
 RxString isSelectedVariants = "".obs;
 bool value1=false;

  @override
  void initState() {
    super.initState();
    singleProductController.getSingleProductData().then((value) {
      isSelectedVariants.value = singleProductController.model.value.data!.productDetail!.variants![0].id.toString();
    });
    homeController1.getHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          body: singleProductController.isDataLoading.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * .25,
                              width: width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: singleProductController
                                      .model.value.data!.productDetail!.image
                                      .toString(),
                                  errorWidget: (_, __, ___) => const SizedBox(),
                                  placeholder: (_, __) => const SizedBox(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * .01,
                            ),
                            SizedBox(
                              height: height * .2,
                              width: width,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          singleProductController.model.value
                                              .data!.productDetail!.name
                                              .toString(),
                                          style: GoogleFonts.ibmPlexSansArabic(
                                              fontSize: 25,
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: height * .01,
                                        ),
                                        Text(
                                          singleProductController.model.value
                                              .data!.productDetail!.content
                                              .toString(),
                                          style: TextStyle(
                                              color: Color(0xff8E8E8E),
                                              fontSize: AddSize.font14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: height * .02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if(singleProductController.model.value
                                                .data!.productDetail!.variants !=null)
                                            Text(
                                              (double.tryParse(singleProductController
                                                  .model.value.data!.productDetail!.variants!.firstWhere((element) => element.id.toString() == isSelectedVariants.value,orElse: ()=> Variants()).price.toString()) ??
                                                  0) == 0 ? singleProductController
                                                  .model.value.data!.productDetail!.variants![0].price.toString(): (double.tryParse(singleProductController
                                                  .model.value.data!.productDetail!.variants!.firstWhere((element) => element.id.toString() == isSelectedVariants.value,orElse: ()=> Variants()).price.toString()) ??
                                                  0).toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppTheme.primaryColor),
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              "SR",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppTheme.primaryColor),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "1200 Cal",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff8E8E8E)),
                                            ),
                                            Flexible(child: Container()),
                                            Container(
                                              height: height * .05,
                                              width: width * .30,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color: Color(0xffC4C4C4))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      singleProductController
                                                          .decreaseQty();
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color:
                                                          AppTheme.primaryColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 9,
                                                  ),
                                                  Text(
                                                    singleProductController
                                                        .counter.value
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .ibmPlexSansArabic(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Color(
                                                                0xff000000)),
                                                  ),
                                                  SizedBox(
                                                    width: 9,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      singleProductController
                                                          .increaseQty();
                                                      setState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color:
                                                          AppTheme.primaryColor,
                                                      size: 22,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * .03,
                            ),

                            if( singleProductController.model.value.data!.productDetail!.variants != null &&
                                singleProductController.model.value.data!.productDetail!.variants!.isNotEmpty )
                            singleProductController.model.value.data!.productDetail!.type == "Variable" ? variantUI():SizedBox(),

                            ...singleProductController
                                .model.value.data!.singlePageAddons!
                                .map((e) => addonsUI(e))
                                .toList(),

                            SizedBox(
                              height: height * .02,
                            ),
                            SizedBox(
                              height: height * .09,
                              child: TextField(
                                maxLines: 3,
                                controller:
                                    singleProductController.noteController,
                                style: const TextStyle(fontSize: 17),
                                // textAlignVertical: TextAlignVertical.center,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value) => {},
                                decoration: InputDecoration(
                                  //filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffC0CCD4)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide:
                                        BorderSide(color: Color(0xffC0CCD4)),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffC0CCD4)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                  //fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: width * .03,
                                      vertical: height * .03),
                                  hintText: 'Notes',
                                  hintStyle: GoogleFonts.ibmPlexSansArabic(
                                      fontSize: AddSize.font14,
                                      color: Color(0xffACACB7),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * .02,
                            ),

                            //SizedBox(height: height * .12,),

                            // Add to cart button
                          ],
                        ),
                      ),
                      Positioned(
                          top: -2,
                          right: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: SizedBox(
                                      height: height * .10,
                                      width: width * .10,
                                      child: Image(
                                          image: AssetImage(AppAssets.BACKICON))),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                )),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              String addonId = "";
              List<String> ids = [];
              if (singleProductController.model.value.data!.productDetail !=
                  null) {
                if (singleProductController
                    .model.value.data!.productDetail!.addons !=
                    null &&
                    singleProductController
                        .model.value.data!.productDetail!.addons!.isNotEmpty) {
                  ids = singleProductController.model.value.data!.singlePageAddons!.map((element) => element.selectedAddon).toList();
                  for(var item in singleProductController.model.value.data!.singlePageAddons!){
                    if(item.multiSelectAddons == true){
                      for(var item1 in item.addonData!){
                        if(item1.selectedAddOn.isNotEmpty){
                          ids.add(item1.selectedAddOn);
                        }
                      }
                    }
                  }
                }
              }
              print(ids);
              ids.removeWhere((element) => element.isEmpty);
              print(ids);
              addonId = ids.join(",");
              addToCartRepo1(
                  variant_id: isSelectedVariants.value.isEmpty?singleProductController.model.value.data!.productDetail!.variants![0].id.toString(): isSelectedVariants.value,
                product_id: singleProductController
                    .model.value.data!.productDetail!.id
                    .toString(),
                qty: singleProductController.counter.value.toString(),
                addons_Id: addonId,
                note: singleProductController.noteController.text,
                itemPrice: singleProductController.model.value.data!.productDetail!.variants![0].price.toString(),
                context: context,
              ).then((value) {
                print("item added successfuly");
                if (value.status == true) {
                  showToast(value.message);
                 Get.back();
                 Get.back();
                 Get.back();
                 Get.back();
                 Get.back();
                  controller.onItemTap(1);
                  myCartController.getCartData();
                  singleProductController.noteController.clear();
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: singleProductController.isDataLoading.value ? BottomAppBar(
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffFE724C)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //SizedBox(width: 10,),
                        Expanded(
                          child: Text(
                            "Add To Cart",
                            style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: AddSize.font18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          (((double.tryParse(singleProductController
                              .model.value.data!.productDetail!.variants!.firstWhere((element) => element.id.toString() == isSelectedVariants.value,orElse: ()=> Variants()).price.toString()) ??
                              0) + (singleProductController
                              .model.value.data!.singlePageAddons!.map(
                                  (element) => (double.tryParse(element.addonData!.firstWhere((element1) => element1.id.toString() ==element.selectedAddon, orElse: ()=> AddonData()).price.toString()) ?? 0)
                          ).toList().sum) +

                              (singleProductController
                              .model.value.data!.singlePageAddons!.map(
                                  (element) => element.addonData!.where((e) => e.id.toString() == e.selectedAddOn).toList().map((e) => (double.tryParse(e.price.toString()) ?? 0)).toList().sum
                          ).toList().sum)


                          )* (singleProductController.counter.value)
                          )
                              .toString(),
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: AddSize.font18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "SR",
                          style: GoogleFonts.ibmPlexSansArabic(
                              color: Color(0xffFFFFFF),
                              fontSize: AddSize.font18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ):Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      );
    });
  }


  //Variants Ui
  Card variantUI() {
    final singleProductController = Get.put(SingleProductController());
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
               "Size",
                style: GoogleFonts.ibmPlexSansArabic(
                    color: Color(0xff000000),
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
                itemCount: singleProductController.model.value.data!.productDetail!.variants!.length,
                itemBuilder:(BuildContext, int index){
              return  Row(
                children: [

                  Radio<String>(
                      value: singleProductController.model.value.data!.productDetail!.variants![index].id.toString(),
                      groupValue: isSelectedVariants.value,
                      onChanged: (value) {
                        isSelectedVariants.value = value!;
                        print(isSelectedVariants.value);
                        setState(() {});
                      }),
                  Expanded(
                    child: Text(
                      singleProductController.model.value.data!.productDetail!.variants![index].sizeName.toString(),
                      style: GoogleFonts.ibmPlexSansArabic(
                          color: Color(0xff000000),
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Flexible(child: Container()),
                  Expanded(
                    child: Text(
                      singleProductController.model.value.data!.productDetail!.variants![index].price.toString(),
                      // "+${e.price!} SR",
                      style: GoogleFonts.ibmPlexSansArabic(
                          color: Color(0xff000000),
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              );
            })

          ],
        ),
      ),
    );
  }
  //Addons Ui
  Card addonsUI(SinglePageAddons e) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                e.title.toString(),
                style: GoogleFonts.ibmPlexSansArabic(
                    color: Color(0xff000000),
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
            ),
            ...e.addonData!
                .map((e2) =>
                Row(
                      children: [
                        e.multiSelectAddons == false
                            ? Radio<String>(
                                value: e2.id.toString(),
                                groupValue: e.selectedAddon,
                                onChanged: (value) {
                                  e.selectedAddon = value!;
                                  setState(() {});
                                })
                            : Checkbox(
                                value: e2.selectedAddOn.isNotEmpty,
                                onChanged: (value11) {
                                  if(value11 == true){
                                    e2.selectedAddOn = e2.id.toString();
                                  } else {
                                    e2.selectedAddOn = "";
                                  }
                                    setState(() {});
                                }),
                        Expanded(
                          child: Text(
                            e2.name!,
                            style: GoogleFonts.ibmPlexSansArabic(
                                color: Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Flexible(child: Container()),
                        Expanded(
                          child: Text(
                            "+${e2.price!} SR",
                            style: GoogleFonts.ibmPlexSansArabic(
                                color: Color(0xff000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
