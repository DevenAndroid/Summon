import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/model/SingleProductModel.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/HomePageController1.dart';
import '../controller/SingleProductController.dart';
import '../repositories/WishList_Repository.dart';
import '../resources/app_assets.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';

class SingleProductPage extends StatefulWidget {
  const SingleProductPage({Key? key}) : super(key: key);
  static var singleProductPage = "/singleProductPage";

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  final singleProductController = Get.put(SingleProductController());
  final homeController1 = Get.put(HomePageController1());

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
                    Column(
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
                          style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Text(
                          "Calorie: 1200",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff3D4149),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xffFFC529),
                              size: 20,
                            ),
                            SizedBox(
                              width: width * .02,
                            ),
                            Text(
                              singleProductController
                                  .model.value.data!.productDetail!.avgRating
                                  .toString(),
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: AddSize.font14,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: width * .20,
                            ),
                            Text(
                              "See Review",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xffFE724C),
                                  fontSize: AddSize.font12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              singleProductController.model.value.data!
                                  .productDetail!.variants![0].price
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff333333)),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.removeIcon,
                                  height: 32,
                                  width: 32,
                                ),
                                SizedBox(
                                  width: 9,
                                ),
                                Text(
                                  "2",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff000000)),
                                ),
                                SizedBox(
                                  width: 9,
                                ),
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.primaryColor
                                          .withOpacity(.80)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
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
                        SizedBox(
                          height: height * .03,
                        ),
                        Text(
                          "Choice of Add On",
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: AddSize.font18,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        ...singleProductController
                            .model.value.data!.singlePageAddons!
                            .map((e) => addonsUI(e))
                            .toList(),
                        SizedBox(height: height * .05,),
                        Container(
                          height: height * .10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffFE724C)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: AssetImage(AppAssets.AddtoCartIcon)),
                                SizedBox(width: 10,),
                                Text(
                                  "Add to cart ",
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontSize: AddSize.font18,
                                      fontWeight: FontWeight.w700),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
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
                                  wishListRepo(productId: map, context: context)
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(e.title.toString()),
        ...e.addonData!
            .map((e2) => Row(
                  children: [
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
                      child: Text("${e2.price!} SR",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: AddSize.font14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Radio<String>(
                        value: e2.id.toString(),
                        groupValue: e.selectedAddon,
                        onChanged: (value) {
                          e.selectedAddon = value!;
                          setState(() {});
                        })
                  ],
                ))
            .toList(),
      ],
    );
  }
}
