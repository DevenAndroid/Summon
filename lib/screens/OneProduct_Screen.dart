import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/model/SingleProductModel.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/CartController.dart';
import '../controller/HomePageController1.dart';
import '../controller/SingleProductController.dart';
import '../model/MyCartDataListModel.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../repositories/WishList_Repository.dart';
import '../resources/app_assets.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import 'MyCart_Page.dart';

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
 final TextEditingController noteController=TextEditingController();

  @override
  void initState() {
    super.initState();
    singleProductController.getSingleProductData();
    homeController1.getHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
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
                          Text(
                            singleProductController
                                .model.value.data!.productDetail!.name
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
                            singleProductController
                                .model.value.data!.productDetail!.content
                                .toString(),
                            style: TextStyle(
                                color: Color(0xff8E8E8E),
                                fontSize: AddSize.font14,
                                fontWeight: FontWeight.w400),
                          ),

                          // Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.star,
                          //       color: Color(0xffFFC529),
                          //       size: 20,
                          //     ),
                          //     SizedBox(
                          //       width: width * .02,
                          //     ),
                          //     Text(
                          //       singleProductController
                          //           .model.value.data!.productDetail!.avgRating
                          //           .toString(),
                          //       style: TextStyle(
                          //           color: Color(0xff333333),
                          //           fontSize: AddSize.font14,
                          //           fontWeight: FontWeight.w600),
                          //     ),
                          //     SizedBox(
                          //       width: width * .20,
                          //     ),
                          //     Text(
                          //       "See Review",
                          //       style: TextStyle(
                          //           decoration: TextDecoration.underline,
                          //           color: Color(0xffFE724C),
                          //           fontSize: AddSize.font12,
                          //           fontWeight: FontWeight.w500),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: height * .02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if(singleProductController.model.value.data!
                                  .productDetail!.variants != null)
                              Text(
                                singleProductController.model.value.data!
                                    .productDetail!.variants![0].price
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.primaryColor),
                              ),
                              SizedBox(width: 6,),
                              Text(
                               "SR",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color:AppTheme.primaryColor),
                              ),
                              SizedBox(width: 5,),
                              Text(
                                "1200 Cal",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color:Color(0xff8E8E8E)),
                              ),
                              Flexible(child: Container()),
                              Container(
                                height: height * .05,
                                width: width * .30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xffC4C4C4))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        singleProductController.decreaseQty();
                                      },
                                      child:  Icon(
                                        Icons.remove,
                                        color: AppTheme.primaryColor,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    Text(
                                     singleProductController.counter.value.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff000000)),
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    InkWell(

                                      onTap: (){
                                          singleProductController.increaseQty();
                                          setState(() {

                                          });

                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: AppTheme.primaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * .03,
                          ),



                          ...singleProductController
                              .model.value.data!.singlePageAddons!
                              .map((e) => addonsUI(e))
                              .toList(),
                          SizedBox(
                            height: height * .01,
                          ),

                          SizedBox(
                            height: height * .09,
                            child: TextField(
                              maxLines: 3,
                              controller:
                              noteController,
                              style: const TextStyle(fontSize: 17),
                              // textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) => {},
                              decoration: InputDecoration(
                                //filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:  BorderSide(color: Color(0xffC0CCD4)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))
                                  ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15)),
                                  borderSide:  BorderSide(color: Color(0xffC0CCD4)),
                                ),
                                border: const OutlineInputBorder(
                                   borderSide:  BorderSide(color: Color(0xffC0CCD4)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15))
                                ),
                                //fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: width * .03,
                                    vertical: height * .03),
                                hintText: 'Notes',
                                hintStyle: TextStyle(
                                    fontSize: AddSize.font14,
                                    color: Color(0xffACACB7),
                                    fontWeight: FontWeight.w400),

                                // prefixIcon: IconButton(
                                //   onPressed: () {
                                //     // Get.to(const SearchScreenData());
                                //
                                //   },
                                //   icon: const Icon(
                                //     Icons.place_rounded,
                                //     color: Color(0xffD3D1D8),
                                //     size: 30,
                                //   ),
                                // ),
                              ),
                            ),
                          ),

                          SizedBox(height: height * .12,),
                          // Add to cart button
                          GestureDetector(
                            onTap: (){
                              String addonId = "";
                              if(singleProductController.model.value.data!.productDetail != null){
                                if(singleProductController.model.value.data!.productDetail!.addons != null && singleProductController.model.value.data!.productDetail!.addons!.isNotEmpty){
                                  addonId = singleProductController.model.value.data!.productDetail!.addons![0].id.toString();
                                }
                              }
                              addToCartRepo1(
                               variant_id:  singleProductController.model.value.data!.productDetail!.variants![0].id.toString(),
                              product_id:   singleProductController.model.value.data!.productDetail!.id.toString(),
                               qty:  singleProductController.counter.value.toString(),
                                addons_Id: addonId,
                                context: context,

                              ).then((value){
                                print("item added successfuly");
                                if(value.status==true){
                                  showToast(value.message);
                                  Get.toNamed(MyCartPage.myCartPage);
                                  myCartController.getCartData();
                                }
                              });
                            },
                            child: BottomAppBar(
                              child: Container(
                                height: height * .08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffFE724C)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      //SizedBox(width: 10,),
                                      Text(
                                        "Add To Cart",
                                        style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontSize: AddSize.font18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "18 SR ",
                                        style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontSize: AddSize.font18,
                                            fontWeight: FontWeight.w500),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: -2,
                        //left: 50,
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
                              SizedBox(
                                width: width * .65,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print(
                                      "product wishlist id..${singleProductController.model.value.data!.productDetail!.id.toString()}");
                                  Map<String, dynamic> map = {};
                                  map['product_id'] = singleProductController
                                      .model.value.data!.productDetail!.id
                                      .toString();
                                  wishListRepo(store_id: map, context: context)
                                      .then((value) {
                                    if (value.status == true) {
                                      showToast(value.message);
                                      singleProductController
                                          .getSingleProductData();
                                    }
                                  });
                                },
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(AppAssets.FavriteIcon),
                                  )),
                                ),
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
      );
    });
  }

  Column addonsUI(SinglePageAddons e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(e.title.toString(),style: TextStyle(
            color: Color(0xff000000),
            fontSize: AddSize.font18,
            fontWeight: FontWeight.w700),),
        ...e.addonData!
            .map((e2) => Row(
                  children: [
                    Radio<String>(
                        value: e2.id.toString(),
                        groupValue: e.selectedAddon,
                        onChanged: (value) {
                          e.selectedAddon = value!;
                          setState(() {});
                        }),
                    Expanded(
                      child: Text(
                        e2.name!,
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: AddSize.font14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Flexible(child: Container()),
                    Expanded(
                      child: Text("+${e2.price!} SR",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: AddSize.font14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                  ],
                ))
            .toList(),
      ],
    );
  }
}
